import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Map;

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
import syntaxtree.FormalParameter;
import syntaxtree.FormalParameterList;
import syntaxtree.FormalParameterTail;
import syntaxtree.FormalParameterTerm;
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

public class LLVMVisitor extends GJDepthFirst<String, String> {


	private PrintWriter writer;
	private SymbolTable symbolTable;
	private int regCounter = 0;
	private int ifCounter = 0;
	private int loopCounter = 0;

	private ClassContent currentClassContent;


	public LLVMVisitor(SymbolTable symbolTable, String filename) throws FileNotFoundException {
		this.writer = new PrintWriter(filename);
		this.symbolTable = symbolTable;
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

	private String getLabelIf() {
		String str = "if" + ifCounter + ":";
		ifCounter++;
		return str;
	}

	private String getLabelLoop() {
		String str = "loop" + loopCounter + ":";
		loopCounter++;
		return str;
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

	/**
	 * f0 -> MainClass()
	 * f1 -> ( TypeDeclaration() )*
	 * f2 -> <EOF>
	 */
	public String visit(Goal n, String argu) throws Exception {
		//emit vTable and helper methods
		boolean main = true;
		for (Map.Entry<String, ClassContent> entry : symbolTable.getClassTable().entrySet()) {
			int numFunc = entry.getValue().getFuncTable().size();
			if(main) {numFunc = 0;}
			emit("@."+entry.getKey()+"_vtable = global [" + numFunc + " x i8*] ["	);
			if(main) {main = false; emit("]\n");continue;}

			StringBuilder str = new StringBuilder();
			for(Map.Entry<String, FunctionContent> funcEntry : entry.getValue().getFuncTable().entrySet()) {				
				str.append("i8* bitcast (" + getIType(funcEntry.getValue().getType()) + " (i8*");
				for(Entry arg : funcEntry.getValue().getArguments()) {
					str.append("," + getIType(arg.getType()));
				}
				str.append(")* @" + entry.getKey() + "." + funcEntry.getKey() + " to i8*),");				
			}
			//delete last comma
			str = str.deleteCharAt(str.length() - 1);
			emit(str + "]\n");
		}
		emit("\n\ndeclare i8* @calloc(i32, i32)\ndeclare i32 @printf(i8*, ...)\n" + 
				"declare void @exit(i32)\n\n@_cint = constant [4 x i8] c\"%d\\0a\\00\"\n" + 
				"@_cOOB = constant [15 x i8] c\"Out of bounds\\0a\\00\"\n" + 
				"define void @print_int(i32 %i) {\n\t%_str = bitcast [4 x i8]* @_cint to i8*\n" + 
				"\tcall i32 (i8*, ...) @printf(i8* %_str, i32 %i)\n" + 
				"\tret void\n}\n\ndefine void @throw_oob() {\n" + 
				"\t%_str = bitcast [15 x i8]* @_cOOB to i8*\n" + 
				"\tcall i32 (i8*, ...) @printf(i8* %_str)\n" + 
				"\tcall void @exit(i32 1)\n\tret void\n}\n\n");


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
	public String visit(MainClass n, String argu) throws Exception {
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
	public String visit(TypeDeclaration n, String argu) throws Exception {
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
	public String visit(ClassDeclaration n, String argu) throws Exception {
		currentClassContent = symbolTable.getClassContent(n.f1.accept(this,argu));
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
	public String visit(ClassExtendsDeclaration n, String argu) throws Exception {
		currentClassContent = symbolTable.getClassContent(n.f1.accept(this,argu));
		return n.f6.accept(this, argu);
	}

	/**
	 * f0 -> Type()
	 * f1 -> Identifier()
	 * f2 -> ";"
	 */
	public String visit(VarDeclaration n, String argu) throws Exception {
		emit("\t%"+n.f1.accept(this,argu) + " = alloca "
				+ getIType(n.f0.accept(this,argu)) + "\n");
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
	public String visit(MethodDeclaration n, String argu) throws Exception {

		String funcType = getIType(n.f1.accept(this,argu));
		String funcName = n.f2.accept(this,argu);

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

		emit("\n\tret " + funcType + " " + n.f10.accept(this,argu) + "\n}\n");

		return null;
	}

	/**
	 * f0 -> ArrayType()
	 *       | BooleanType()
	 *       | IntegerType()
	 *       | Identifier()
	 */
	public String visit(Type n, String argu) throws Exception {
		return n.f0.accept(this,argu);
	}

	/**
	 * f0 -> "int"
	 * f1 -> "["
	 * f2 -> "]"
	 */
	public String visit(ArrayType n, String argu) throws Exception {
		return "int[]";
	}

	/**
	 * f0 -> "boolean"
	 */
	public String visit(BooleanType n, String argu) throws Exception {
		return "boolean";
	}

	/**
	 * f0 -> "int"
	 */
	public String visit(IntegerType n, String argu) throws Exception {
		return "int";
	}

	/**
	 * f0 -> Block()
	 *       | AssignmentStatement()
	 *       | ArrayAssignmentStatement()
	 *       | IfStatement()
	 *       | WhileStatement()
	 *       | PrintStatement()
	 */
	public String visit(Statement n, String argu) throws Exception {
		return n.f0.accept(this,argu);
	}

	/**
	 * f0 -> "{"
	 * f1 -> ( Statement() )*
	 * f2 -> "}"
	 */
	public String visit(Block n, String argu) throws Exception {
		
		
		
		return n.f1.accept(this,argu);
	}

	/**
	 * f0 -> Identifier()
	 * f1 -> "="
	 * f2 -> Expression()
	 * f3 -> ";"
	 */
	public String visit(AssignmentStatement n, String argu) throws Exception {





		return super.visit(n, argu);
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
	public String visit(ArrayAssignmentStatement n, String argu) throws Exception {





		return super.visit(n, argu);
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
	public String visit(IfStatement n, String argu) throws Exception {





		return super.visit(n, argu);
	}


	/**
	 * f0 -> "while"
	 * f1 -> "("
	 * f2 -> Expression()
	 * f3 -> ")"
	 * f4 -> Statement()
	 */
	public String visit(WhileStatement n, String argu) throws Exception {





		return super.visit(n, argu);
	}

	/**
	 * f0 -> "System.out.println"
	 * f1 -> "("
	 * f2 -> Expression()
	 * f3 -> ")"
	 * f4 -> ";"
	 */
	public String visit(PrintStatement n, String argu) throws Exception {





		return super.visit(n, argu);
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
	public String visit(Expression n, String argu) throws Exception {
		return n.f0.accept(this,argu);
	}


	/**
	 * f0 -> Clause()
	 * f1 -> "&&"
	 * f2 -> Clause()
	 */
	public String visit(AndExpression n, String argu) throws Exception {





		return super.visit(n, argu);
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "<"
	 * f2 -> PrimaryExpression()
	 */
	public String visit(CompareExpression n, String argu) throws Exception {





		return super.visit(n, argu);
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "+"
	 * f2 -> PrimaryExpression()
	 */
	public String visit(PlusExpression n, String argu) throws Exception {





		return super.visit(n, argu);
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "-"
	 * f2 -> PrimaryExpression()
	 */
	public String visit(MinusExpression n, String argu) throws Exception {





		return super.visit(n, argu);
	}


	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "*"
	 * f2 -> PrimaryExpression()
	 */
	public String visit(TimesExpression n, String argu) throws Exception {





		return super.visit(n, argu);
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "["
	 * f2 -> PrimaryExpression()
	 * f3 -> "]"
	 */
	public String visit(ArrayLookup n, String argu) throws Exception {





		return super.visit(n, argu);
	}


	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "."
	 * f2 -> "length"
	 */
	public String visit(ArrayLength n, String argu) throws Exception {





		return super.visit(n, argu);
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "."
	 * f2 -> Identifier()
	 * f3 -> "("
	 * f4 -> ( ExpressionList() )?
	 * f5 -> ")"
	 */
	public String visit(MessageSend n, String argu) throws Exception {




		return super.visit(n, argu);
	}

	/**
	 * f0 -> Expression()
	 * f1 -> ExpressionTail()
	 */
	public String visit(ExpressionList n, String argu) throws Exception {




		return super.visit(n, argu);
	}

	/**
	 * f0 -> ( ExpressionTerm() )*
	 */
	public String visit(ExpressionTail n, String argu) throws Exception {





		return super.visit(n, argu);
	}

	/**
	 * f0 -> ","
	 * f1 -> Expression()
	 */
	public String visit(ExpressionTerm n, String argu) throws Exception {




		return super.visit(n, argu);
	}

	/**
	 * f0 -> NotExpression()
	 *       | PrimaryExpression()
	 */
	public String visit(Clause n, String argu) throws Exception {




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
	public String visit(PrimaryExpression n, String argu) throws Exception {




		return n.f0.accept(this,argu);
	}

	/**
	 * f0 -> <INTEGER_LITERAL>
	 */
	public String visit(IntegerLiteral n, String argu) throws Exception {




		return n.f0.toString();
	}

	/**
	 * f0 -> "true"
	 */
	public String visit(TrueLiteral n, String argu) throws Exception {
		return "true";
	}

	/**
	 * f0 -> "false"
	 */
	public String visit(FalseLiteral n, String argu) throws Exception {
		return "false";
	}

	/**
	 * f0 -> <IDENTIFIER>
	 */
	public String visit(Identifier n, String argu) throws Exception {
		return n.f0.toString();
	}

	/**
	 * f0 -> "this"
	 */
	public String visit(ThisExpression n, String argu) throws Exception {
		return "this";
	}

	/**
	 * f0 -> "new"
	 * f1 -> "int"
	 * f2 -> "["
	 * f3 -> Expression()
	 * f4 -> "]"
	 */
	public String visit(ArrayAllocationExpression n, String argu) throws Exception {




		return n.f3.accept(this, argu);
	}


	/**
	 * f0 -> "new"
	 * f1 -> Identifier()
	 * f2 -> "("
	 * f3 -> ")"
	 */
	public String visit(AllocationExpression n, String argu) throws Exception {




		return n.f1.accept(this, argu);
	}

	/**
	 * f0 -> "!"
	 * f1 -> Clause()
	 */
	public String visit(NotExpression n, String argu) throws Exception {




		return n.f1.accept(this, argu);
	}

	/**
	 * f0 -> "("
	 * f1 -> Expression()
	 * f2 -> ")"
	 */
	public String visit(BracketExpression n, String argu) throws Exception {





		return n.f1.accept(this, argu);
	}

}
