import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import syntaxtree.AllocationExpression;
import syntaxtree.AndExpression;
import syntaxtree.ArrayAllocationExpression;
import syntaxtree.ArrayAssignmentStatement;
import syntaxtree.ArrayLength;
import syntaxtree.ArrayLookup;
import syntaxtree.ArrayType;
import syntaxtree.AssignmentStatement;
import syntaxtree.Block;
import syntaxtree.BooleanType;
import syntaxtree.BracketExpression;
import syntaxtree.ClassDeclaration;
import syntaxtree.ClassExtendsDeclaration;
import syntaxtree.Clause;
import syntaxtree.CompareExpression;
import syntaxtree.Expression;
import syntaxtree.ExpressionList;
import syntaxtree.ExpressionTail;
import syntaxtree.ExpressionTerm;
import syntaxtree.FalseLiteral;
import syntaxtree.Goal;
import syntaxtree.Identifier;
import syntaxtree.IfStatement;
import syntaxtree.IntegerLiteral;
import syntaxtree.IntegerType;
import syntaxtree.MainClass;
import syntaxtree.MessageSend;
import syntaxtree.MethodDeclaration;
import syntaxtree.MinusExpression;
import syntaxtree.NotExpression;
import syntaxtree.PlusExpression;
import syntaxtree.PrimaryExpression;
import syntaxtree.PrintStatement;
import syntaxtree.Statement;
import syntaxtree.ThisExpression;
import syntaxtree.TimesExpression;
import syntaxtree.TrueLiteral;
import syntaxtree.Type;
import syntaxtree.TypeDeclaration;
import syntaxtree.VarDeclaration;
import syntaxtree.WhileStatement;
import visitor.GJDepthFirst;

public class LLVMVisitor extends GJDepthFirst<Entry, String> {
	private Vtable vtable;
	
	private PrintWriter writer;
	private SymbolTable symbolTable;
	private int regCounter = 0;
	private int ifCounter = 0;
	private int loopCounter = 0;
	private int arrAllocCounter = 0;
	private int oobCounter = 0;
	private int andCounter = 0;
	
	private ClassContent currentClassContent;
	private FunctionContent currentFunctionContent;


	public LLVMVisitor(SymbolTable symbolTable, String filename) throws FileNotFoundException {
		this.writer = new PrintWriter(filename);
		this.symbolTable = symbolTable;
		resetCounters();
		this.vtable = new Vtable();
	}

	private void emit(String s) {
		this.writer.print(s);
		this.writer.flush();
	}

	private String getReg() {
		String str = "%_" + regCounter;
		regCounter++;
		return str;
	}

	private String getIf() {
		String str = "if" + ifCounter;
		ifCounter++;
		return str;
	}

	private String getLoop() {
		String str = "loop" + loopCounter;
		loopCounter++;
		return str;
	}

	private String getArrAlloc() {
		String str = "arr_alloc" + arrAllocCounter;
		arrAllocCounter++;
		return str;
	}
	
	private String getOob() {
		String str = "oob" + oobCounter;
		oobCounter++;
		return str;
	}
	
	private String getAnd() {
		String str = "andClause" + andCounter;
		andCounter++;
		return str;
	}
	

	private void resetCounters() {
		regCounter = 0;
		ifCounter = 0;
		loopCounter = 0;
		arrAllocCounter = 0;
		oobCounter = 0;
		andCounter = 0; 
	}

	private String getIType(String type) {
		if(type.equals("int")) {
			return "i32";
		} else if(type.equals("boolean")) {
			return "i1";
		} else if(type.equals("int[]")) {
			return "i32*";
		} else {
			return "i8*";
		}
	}

	private int getClassSize(String name) {
		return 8 + symbolTable.getClassContent(name).getCurrentOffset();
	}

	
	private void createVtable() {
		Map<ClassContent,List<FunctionContent>> map = new LinkedHashMap<>();
		for (Map.Entry<String, ClassContent> entry : symbolTable.getClassTable().entrySet()) {
			ClassContent currentClass = entry.getValue();
			List<FunctionContent> funcs = new ArrayList<>();
			
			for(Map.Entry<String, FunctionContent> funcEntry : currentClass.getSuperFuncTable().entrySet()) {
				FunctionContent curFunc = funcEntry.getValue();
				curFunc.setRealClass(currentClass);
				//System.out.println(currentClass.getName() + "#" + curFunc.getRealClass().getName() + "#" + curFunc.getName()+ "#" + curFunc.getOffset());
				funcs.add(curFunc);
			}
			
			map.put(currentClass, funcs);
		}
		this.vtable.setMap(map);
	}
	
	private void emitVtable() {
		boolean main = true;
		for (Map.Entry<ClassContent,List<FunctionContent>> entry : this.vtable.getMap().entrySet()) {
			int numFunc = entry.getKey().getSuperFuncTable().size();
			if(main) {numFunc = 0;}
			emit("@."+entry.getKey().getName()+"_vtable = global [" + numFunc + " x i8*] ["	);
			if(main) {main = false; emit("]\n");continue;}

			StringBuilder str = new StringBuilder();
			for(FunctionContent func: entry.getValue()) {
				str.append("i8* bitcast (" + getIType(func.getType()) + " (i8*");
				for(Entry arg : func.getArguments()) {
					str.append("," + getIType(arg.getType()));
				}
				str.append(")* @" + func.getRealClass().getName() + "." + func.getName() + " to i8*),");				
			}
			//delete last comma
			if(str.charAt(str.length() - 1) == ',')
				str = str.deleteCharAt(str.length() - 1);
			emit(str + "]\n");
		}
	}
	
	private void emitIntro() {
		emit("\n\ndeclare i8* @calloc(i32, i32)\ndeclare i32 @printf(i8*, ...)\n" + 
				"declare void @exit(i32)\n\n@_cint = constant [4 x i8] c\"%d\\0a\\00\"\n" + 
				"@_cOOB = constant [15 x i8] c\"Out of bounds\\0a\\00\"\n" + 
				"define void @print_int(i32 %i) {\n\t%_str = bitcast [4 x i8]* @_cint to i8*\n" + 
				"\tcall i32 (i8*, ...) @printf(i8* %_str, i32 %i)\n" + 
				"\tret void\n}\n\ndefine void @throw_oob() {\n" + 
				"\t%_str = bitcast [15 x i8]* @_cOOB to i8*\n" + 
				"\tcall i32 (i8*, ...) @printf(i8* %_str)\n" + 
				"\tcall void @exit(i32 1)\n\tret void\n}\n\n");
	}
	
	/**
	 * f0 -> MainClass()
	 * f1 -> ( TypeDeclaration() )*
	 * f2 -> <EOF>
	 */
	public Entry visit(Goal n, String argu) throws Exception {
		
		this.createVtable();
		this.emitVtable();
		this.emitIntro();
		
		n.f0.accept(this,argu);
		n.f1.accept(this,argu);

		return null;
	}

	/**
	 * f0 -> "class"
	 * f1 -> Identifier()
	 * f2 -> "{"
	 * f3 -> "public"
	 * f4 -> "static"
	 * f5 -> "void"
	 * f6 -> "main"
	 * f7 -> "("
	 * f8 -> "String"
	 * f9 -> "["
	 * f10 -> "]"
	 * f11 -> Identifier()
	 * f12 -> ")"
	 * f13 -> "{"
	 * f14 -> ( VarDeclaration() )*
	 * f15 -> ( Statement() )*
	 * f16 -> "}"
	 * f17 -> "}"
	 */
	public Entry visit(MainClass n, String argu) throws Exception {
		this.currentClassContent = symbolTable.getMainClass();
		this.currentFunctionContent = this.currentClassContent.getFunction("main");

		emit("define i32 @main() {\n");

		currentClassContent = symbolTable.getMainClass();

		n.f14.accept(this,argu);
		n.f15.accept(this,argu);

		emit("\n\tret i32 0\n}\n");

		return null;
	}

	/**
	 * f0 -> ClassDeclaration()
	 *       | ClassExtendsDeclaration()
	 */
	public Entry visit(TypeDeclaration n, String argu) throws Exception {
		return n.f0.accept(this, argu);
	}

	/**
	 * f0 -> "class"
	 * f1 -> Identifier()
	 * f2 -> "{"
	 * f3 -> ( VarDeclaration() )*
	 * f4 -> ( MethodDeclaration() )*
	 * f5 -> "}"
	 */
	public Entry visit(ClassDeclaration n, String argu) throws Exception {
		currentClassContent = symbolTable.getClassContent(n.f1.f0.toString());
		return n.f4.accept(this, argu);
	}

	/**
	 * f0 -> "class"
	 * f1 -> Identifier()
	 * f2 -> "extends"
	 * f3 -> Identifier()
	 * f4 -> "{"
	 * f5 -> ( VarDeclaration() )*
	 * f6 -> ( MethodDeclaration() )*
	 * f7 -> "}"
	 */
	public Entry visit(ClassExtendsDeclaration n, String argu) throws Exception {
		currentClassContent = symbolTable.getClassContent(n.f1.f0.toString());
		return n.f6.accept(this, argu);
	}

	/**
	 * f0 -> Type()
	 * f1 -> Identifier()
	 * f2 -> ";"
	 */
	public Entry visit(VarDeclaration n, String argu) throws Exception {
		emit("\t"+n.f1.accept(this,"noload").getName() + " = alloca "
				+ getIType(n.f0.accept(this,argu).getName()) + "\n");
		return null;
	}

	/**
	 * f0 -> "public"
	 * f1 -> Type()
	 * f2 -> Identifier()
	 * f3 -> "("
	 * f4 -> ( FormalParameterList() )?
	 * f5 -> ")"
	 * f6 -> "{"
	 * f7 -> ( VarDeclaration() )*
	 * f8 -> ( Statement() )*
	 * f9 -> "return"
	 * f10 -> Expression()
	 * f11 -> ";"
	 * f12 -> "}"
	 */
	public Entry visit(MethodDeclaration n, String argu) throws Exception {

		this.currentFunctionContent = currentClassContent.getFunction(n.f2.f0.toString());
		resetCounters();

		String funcType = getIType(n.f1.accept(this,argu).getName());
		String funcName = n.f2.f0.toString();

		emit("define " + funcType + " @" + currentClassContent.getName()
		+ "." + funcName + "(i8* %this");

		for (Entry arg: currentClassContent.getFunction(funcName).getArguments()) {
			emit(", " + getIType(arg.getType()) + " %." + arg.getName());
		}
		emit(") {\n");

		for (Entry arg: currentClassContent.getFunction(funcName).getArguments()) {
			String argType = getIType(arg.getType());
			String argName = arg.getName();
			emit("\t%" + argName + " = alloca " + argType + "\n\tstore " + argType
					+ " %." + argName + ", " + argType + "* %" + argName + "\n");
		}

		n.f7.accept(this,argu);
		n.f8.accept(this,argu);


		Entry entry = n.f10.accept(this,argu);
		String reg = entry.getName();
		
		if(!entry.getType().equals(funcType)) {
			String reg1 = getReg();
			emit(reg1 + " = load " + funcType + ", " + funcType + "* " + entry.getName());
			reg = reg1;
		}
			
		emit("\n\tret " + funcType + " " + reg + "\n}\n");
		
		return null;
	}

	/**
	 * f0 -> ArrayType()
	 *       | BooleanType()
	 *       | IntegerType()
	 *       | Identifier()
	 */
	public Entry visit(Type n, String argu) throws Exception {
		return n.f0.accept(this,"caution");
	}

	/**
	 * f0 -> "int"
	 * f1 -> "["
	 * f2 -> "]"
	 */
	public Entry visit(ArrayType n, String argu) throws Exception {
		return new Entry("int[]",null);
	}

	/**
	 * f0 -> "boolean"
	 */
	public Entry visit(BooleanType n, String argu) throws Exception {
		return new Entry("boolean",null);
	}

	/**
	 * f0 -> "int"
	 */
	public Entry visit(IntegerType n, String argu) throws Exception {
		return new Entry("int",null);
	}

	/**
	 * f0 -> Block()
	 *       | AssignmentStatement()
	 *       | ArrayAssignmentStatement()
	 *       | IfStatement()
	 *       | WhileStatement()
	 *       | PrintStatement()
	 */
	public Entry visit(Statement n, String argu) throws Exception {
		return n.f0.accept(this,argu);
	}

	/**
	 * f0 -> "{"
	 * f1 -> ( Statement() )*
	 * f2 -> "}"
	 */
	public Entry visit(Block n, String argu) throws Exception {
		return n.f1.accept(this,argu);
	}

	/**
	 * f0 -> Identifier()
	 * f1 -> "="
	 * f2 -> Expression()
	 * f3 -> ";"
	 */
	public Entry visit(AssignmentStatement n, String argu) throws Exception {
		Entry entry1 = n.f0.accept(this,"noload");
		Entry entry2 = n.f2.accept(this,argu);
		emit("\tstore " + entry2.getType() + " " + entry2.getName()
		 		+ ", "	+ entry1.getType() + " " + entry1.getName());
		return null;
	}

	/**
	 * f0 -> Identifier()
	 * f1 -> "["
	 * f2 -> Expression()
	 * f3 -> "]"
	 * f4 -> "="
	 * f5 -> Expression()
	 * f6 -> ";"
	 */
	public Entry visit(ArrayAssignmentStatement n, String argu) throws Exception {
		String reg = n.f0.accept(this,argu).getName();
		String index = n.f2.accept(this,argu).getName();
		String expression = n.f5.accept(this,null).getName();
		String reg1 = getReg();
		String reg2 = getReg();
		String reg3 = getReg();
		String reg4 = getReg();
		String label1 = getOob();
		String label2 = getOob();
		String label3 = getOob();
		
		emit("\t" + reg1 + " = load i32, i32* " + reg + "\n"
			+"\t" + reg2 + " = icmp ult i32 " + index + ", " + reg1 + "\n"
			+"\tbr i1 " + reg2 + ", label %" + label1 + ", label %" + label2 + "\n\n"
			+label1 + ":\n\t"
			+ reg3 + " = add i32 " + index + ", 1\n"
			+"\t" + reg4 + " = getelementptr i32, i32* " + reg + ", i32 " + reg3 + "\n"
			+"\tstore i32 " + expression + ", i32* " + reg4 
			+ "\n\tbr label %" + label3 + "\n"
			+label2 + ":\ncall void @throw_oob()\nbr label %" + label3 + "\n");
		
		return null;
	}

	/**
	 * f0 -> "if"
	 * f1 -> "("
	 * f2 -> Expression()
	 * f3 -> ")"
	 * f4 -> Statement()
	 * f5 -> "else"
	 * f6 -> Statement()
	 */
	public Entry visit(IfStatement n, String argu) throws Exception {
		String label1 = getIf();
		String label2 = getIf();
		String label3 = getIf();
		String regExp = n.f2.accept(this,null).getName();
		
		emit("\tbr i1 " + regExp + ", label %" + label1 + ", label %" + label2 + "\n\n"
				+label1 + ":\n");
		n.f4.accept(this,argu);
		emit("\tbr label %" + label3 + "\n\n"
				+label2 + ":\n");
		n.f6.accept(this,argu);
		emit("\tbr label %" + label3 + "\n\n"
				+label3 + ":\n");
		return null;
	}


	/**
	 * f0 -> "while"
	 * f1 -> "("
	 * f2 -> Expression()
	 * f3 -> ")"
	 * f4 -> Statement()
	 */
	public Entry visit(WhileStatement n, String argu) throws Exception {
		String label1 = getLoop();
		String label2 = getLoop();
		String label3 = getLoop();

		emit("\tbr label %" + label1 + "\n\n"
				+label1 + ":\n");

		String regExp = n.f2.accept(this,argu).getName();
		
		emit("\tbr i1 " + regExp + ", label %" + label2 + ", label %" + label3 + "\n\n"
				+label2 + ":\n");
		n.f4.accept(this,argu);
		emit("\tbr label %" + label1 + "\n\n"
				+label3 + ":\n");

		return null;
	}

	/**
	 * f0 -> "System.out.println"
	 * f1 -> "("
	 * f2 -> Expression()
	 * f3 -> ")"
	 * f4 -> ";"
	 */
	public Entry visit(PrintStatement n, String argu) throws Exception {

		Entry entry = n.f2.accept(this,null);
		String reg = entry.getName();
		//for boolean
		if(entry.getType().equals("i1")) {
			String reg1 = getReg();
			emit("\t" + reg1 + " = zext i1 " + reg + " to i32\n");
			reg = reg1;
		}
		emit("\tcall void (i32) @print_int(i32 " + reg + ")\n");
		
		return null;
	}


	/**
	 * f0 -> AndExpression()
	 *       | CompareExpression()
	 *       | PlusExpression()
	 *       | MinusExpression()
	 *       | TimesExpression()
	 *       | ArrayLookup()
	 *       | ArrayLength()
	 *       | MessageSend()
	 *       | Clause()
	 */
	public Entry visit(Expression n, String argu) throws Exception {
		return n.f0.accept(this,argu);
	}


	/**
	 * f0 -> Clause()
	 * f1 -> "&&"
	 * f2 -> Clause()
	 */
	public Entry visit(AndExpression n, String argu) throws Exception {
		String label1 = getAnd();
		String label2 = getAnd();
		String label3 = getAnd();
		String label4 = getAnd();
		String reg = getReg();
		
		String clause1 = n.f0.accept(this,null).getName();
		
		emit("\tbr label %" + label1 + "\n\n"
				+label1 + ":\n"
				+"\tbr i1 " + clause1 + ", label %" + label2 + ", label %" + label4 +"\n\n"
				+label2 + ":\n");
		
		String clause2 = n.f2.accept(this,null).getName();
		
		emit("\tbr label %" + label3 + "\n\n"
				+label3 + ":\n\tbr label %" + label4 + "\n\n"
				+label4 + ":\n\t" + reg + " = phi i1 [ 0, %" + label1
				+ " ], [ " + clause2 + ", %" + label3 + " ]\n");

		return new Entry(reg, "i1");
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "<"
	 * f2 -> PrimaryExpression()
	 */
	public Entry visit(CompareExpression n, String argu) throws Exception {
		String reg = getReg();
		emit("\t" + reg + " = icmp slt i32 " + n.f0.accept(this,null).getName() + ", " + n.f2.accept(this,null).getName());
		return new Entry(reg, "i1");
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "+"
	 * f2 -> PrimaryExpression()
	 */
	public Entry visit(PlusExpression n, String argu) throws Exception {
		String reg = getReg();
		emit("\t" + reg + " = add i32 " + n.f0.accept(this,null).getName() + ", " + n.f2.accept(this,null).getName());
		return new Entry(reg, "i32");
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "-"
	 * f2 -> PrimaryExpression()
	 */
	public Entry visit(MinusExpression n, String argu) throws Exception {
		String reg = getReg();
		emit("\t" + reg + " = sub i32 " + n.f0.accept(this,null).getName() + ", " + n.f2.accept(this,null).getName());
		return new Entry(reg, "i32");
	}


	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "*"
	 * f2 -> PrimaryExpression()
	 */
	public Entry visit(TimesExpression n, String argu) throws Exception {
		String reg = getReg();
		emit("\t" + reg + " = mul i32 " + n.f0.accept(this,null).getName() + ", " + n.f2.accept(this,null).getName());
		return new Entry(reg, "i32");
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "["
	 * f2 -> PrimaryExpression()
	 * f3 -> "]"
	 */
	public Entry visit(ArrayLookup n, String argu) throws Exception {

		String reg = n.f0.accept(this,argu).getName();
		String index = n.f2.accept(this,argu).getName();
		String reg1 = getReg();
		String reg2 = getReg();
		String reg3 = getReg();
		String reg4 = getReg();
		String reg5 = getReg();
		String label1 = getOob();
		String label2 = getOob();
		String label3 = getOob();
		
		
		emit("\t" + reg1 + " = load i32, i32* " + reg + "\n"
			+"\t" + reg2 + " = icmp ult i32 " + index + ", " + reg1 + "\n"
			+"\tbr i1 " + reg2 + ", label %" + label1 + ", label %" + label2 + "\n\n"
			+label1 + ":\n\t" + reg3 + " = add i32 " + index + ", 1\n"
			+"\t" + reg4 + " = getelementptr i32, i32* " + reg + ", i32 " + reg3 + "\n");
		String type = "i32*";
		if(argu==null || !argu.equals("noload")) {
			emit("\t" + reg5 + " = load i32, i32* " + reg4 + "\n");
			reg4 = reg5;
			type = "i32";
		}
		emit("\tbr label %" + label3 + "\n"
			+label2 + ":\ncall void @throw_oob()\nbr label %" + label3 + "\n");
		
		return new Entry(reg4, type);
	}


	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "."
	 * f2 -> "length"
	 */
	public Entry visit(ArrayLength n, String argu) throws Exception {
		String reg = n.f0.accept(this,argu).getName();
		return new Entry(reg,"i32");
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "."
	 * f2 -> Identifier()
	 * f3 -> "("
	 * f4 -> ( ExpressionList() )?
	 * f5 -> ")"
	 */
	
	//used for parameters
	private Stack<String> typeStack = new Stack<>();
	private Stack<String> bufferStack = new Stack<>();
	
	public Entry visit(MessageSend n, String argu) throws Exception {

		//calls new visitor, to find the type of the class, that the primary expression represents.
		String clazz = n.f0.accept(new GetClassContentVisitor(symbolTable, currentClassContent, currentFunctionContent));
		ClassContent targetClass = symbolTable.getClassContent(clazz);

		FunctionContent func = targetClass.getFunctionSuper(n.f2.f0.toString());

		String reg1 = getReg();
		String reg2 = getReg();
		String reg3 = getReg();
		String reg4 = getReg();
		String reg5 = getReg();
		String reg6 = getReg();
		String reg7 = getReg();
		
		reg1 = n.f0.accept(this,argu).getName();		
		
		emit("\t" + reg2 + " = bitcast i8* " + reg1 + " to i8***\n"
			+"\t" + reg3 + " = load i8**, i8*** " + reg2 + "\n"
			+"\t" + reg4 + " = getelementptr i8*, i8** " + reg3 + ", i32 " + func.getOffset()/8 + "\n"
			+"\t" + reg5 + " = load i8*, i8** " + reg4 + "\n"
			+"\t" + reg6 + " = bitcast i8* " + reg5 + " to " + this.getIType(func.getType()) + " (i8*");
		String types="";
		for(Entry arg: func.getArguments()) {
			types += this.getIType(arg.getType()) + " ";
			emit(","+this.getIType(arg.getType()));
		}
		emit(")*\n");
		typeStack.push(types);
		String buffer = null;
		if(n.f4.present())
			buffer = n.f4.accept(this,argu).getName();
		if (buffer == null) buffer = "";
		typeStack.pop();
		emit("\t" + reg7 + " = call " + this.getIType(func.getType()) + " " + reg6 + "(i8* " + reg1 + buffer + ")\n");

		return new Entry(reg7,this.getIType(func.getType()));
	}

	/**
	 * f0 -> Expression()
	 * f1 -> ExpressionTail()
	 */
	public Entry visit(ExpressionList n, String argu) throws Exception {
		String types = typeStack.pop();
		int i = types.indexOf(' ');
		String word = types.substring(0, i);
		types = types.substring(i + 1);
		typeStack.push(types);
		String reg = n.f0.accept(this,argu).getName();
		String buffer = ", " + word + " " +reg;
		bufferStack.push(buffer);
		n.f1.accept(this,argu);
		return new Entry(bufferStack.pop(),null);
	}

	/**
	 * f0 -> ( ExpressionTerm() )*
	 */
	public Entry visit(ExpressionTail n, String argu) throws Exception {
		return n.f0.accept(this,argu);
	}

	/**
	 * f0 -> ","
	 * f1 -> Expression()
	 */
	public Entry visit(ExpressionTerm n, String argu) throws Exception {
		
		String types = typeStack.pop();
		int i = types.indexOf(' ');
		String word = types.substring(0, i);
		types = types.substring(i + 1);
		typeStack.push(types);
		String reg = n.f1.accept(this,null).getName();

		String buffer = ", " + word + " " +reg;

		String prevBuffer = bufferStack.pop();
		bufferStack.push(prevBuffer + buffer);
		
		return null;
	}

	/**
	 * f0 -> NotExpression()
	 *       | PrimaryExpression()
	 */
	public Entry visit(Clause n, String argu) throws Exception {
		return n.f0.accept(this, argu);
	}

	/**
	 * f0 -> IntegerLiteral()
	 *       | TrueLiteral()
	 *       | FalseLiteral()
	 *       | Identifier()
	 *       | ThisExpression()
	 *       | ArrayAllocationExpression()
	 *       | AllocationExpression()
	 *       | BracketExpression()
	 */
	public Entry visit(PrimaryExpression n, String argu) throws Exception {
		return n.f0.accept(this,argu);
	}

	/**
	 * f0 -> <INTEGER_LITERAL>
	 */
	public Entry visit(IntegerLiteral n, String argu) throws Exception {
		return new Entry(n.f0.toString(),"i32");
	}

	/**
	 * f0 -> "true"
	 */
	public Entry visit(TrueLiteral n, String argu) throws Exception {
		return new Entry("1","i1");
	}

	/**
	 * f0 -> "false"
	 */
	public Entry visit(FalseLiteral n, String argu) throws Exception {
		return new Entry("0","i1");
	}

	/**
	 * f0 -> <IDENTIFIER>
	 */
	public Entry visit(Identifier n, String argu) throws Exception {
		
		String name = n.f0.toString();
		String type = null;
		String reg = "%" + name;
		
		if(argu!=null && argu.equals("caution")) {
			return new Entry(reg,type);
		}
		
		if(this.currentFunctionContent.getVariableEntry(name) == null) {
			//then it is a class variable, search it
			String reg1 = getReg();
			String reg2 = getReg();
			String reg3 = getReg();
			type = this.getIType(this.currentClassContent.getVariableEntry(name).getType());
			int offset = this.currentClassContent.getVariableEntry(name).getOffset() + 8;
			emit("\t" + reg1 + " = getelementptr i8, i8* %this, i32 " + offset + "\n"
				+"\t" + reg2 + " = bitcast i8* " + reg1 + " to " + type + "*\n");
			if(argu!=null && argu.equals("noload"))
				return new Entry(reg2,type+"*");
			emit("\t" + reg3 + " = load " + type + ", " + type + "* " + reg2 + "\n");
			reg = reg3;
		}
		else {
			type = this.getIType(this.currentFunctionContent.getVariableEntry(name).getType());
			String reg1 = getReg();
			if(argu!=null && argu.equals("noload"))
				return new Entry(reg,type+"*");
			emit("\t" + reg1 + " = load " + type + ", " + type + "* " + reg + "\n");
			reg = reg1;
		}
		return new Entry(reg,type);
	}

	/**
	 * f0 -> "this"
	 */
	public Entry visit(ThisExpression n, String argu) throws Exception {
		return new Entry("%this","i8*");
	}

	/**
	 * f0 -> "new"
	 * f1 -> "int"
	 * f2 -> "["
	 * f3 -> Expression()
	 * f4 -> "]"
	 */
	public Entry visit(ArrayAllocationExpression n, String argu) throws Exception {
		String reg1 = getReg();
		String reg2 = getReg();
		String reg3 = getReg();
		String reg4 = getReg();
		String reg5 = getReg();
		String arrAlloc1 = getArrAlloc();
		String arrAlloc2 = getArrAlloc();

		emit("\t" + reg1 + " = load i32, i32* " + n.f3.accept(this,argu).getName() + "\n"
			+"\t" + reg2 + " = icmp slt i32 " + reg1 + ", 0\n"
			+"\tbr i1 " + reg2 + ", label %" + arrAlloc1 + ", label %" + arrAlloc2 + "\n\n"
			+arrAlloc1 + ":\ncall void @throw_oob()\nbr label %" + arrAlloc2 + "\n\n"
			+arrAlloc2 + ":\n" + reg3 + " = add i32 " + reg1 + ", 1\n"
			+"\t" + reg4 + " = call i8* @calloc(i32 4, i32 " + reg3 + ")\n"
			+"\t" + reg5 + " = bitcast i8* " + reg4 + " to i32*\n"
			+"\tstore i32 " + reg1 + ", i32* " + reg5 + "\n");

		return new Entry(reg5,"i32*");
	}

	/**
	 * f0 -> "new"
	 * f1 -> Identifier()
	 * f2 -> "("
	 * f3 -> ")"
	 */
	public Entry visit(AllocationExpression n, String argu) throws Exception {
		String reg1 = getReg();
		String reg2 = getReg();
		String reg3 = getReg();
		String identifier = n.f1.f0.toString();
		int numOfFuncs = symbolTable.getClassContent(identifier).getFuncTable().size();

		emit("\t" + reg1 + " = call i8* @calloc(i32 1, i32 " + getClassSize(identifier) + ")\n"
			+"\t" + reg2 + " = bitcast i8* " + reg1 + " to i8***\n"
			+"\t" + reg3 + " = getelementptr [" + numOfFuncs + " x i8*], [" + numOfFuncs
			+" x i8*]* @." + identifier + "_vtable, i32 0, i32 0\n"
			+"\t" + "store i8** " + reg3 + ",i8*** " + reg2 + "\n");

		return new Entry(reg1,"i8*");
	}

	/**
	 * f0 -> "!"
	 * f1 -> Clause()
	 */
	public Entry visit(NotExpression n, String argu) throws Exception {
		String reg = getReg();
		emit("\t" + reg + " = xor i1 1, " + n.f1.accept(this,argu).getName());
		return new Entry(reg,"i1");
	}

	/**
	 * f0 -> "("
	 * f1 -> Expression()
	 * f2 -> ")"
	 */
	public Entry visit(BracketExpression n, String argu) throws Exception {
		return n.f1.accept(this, argu);
	}

}
