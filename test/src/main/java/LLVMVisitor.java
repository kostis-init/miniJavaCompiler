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
	
	

	/**
	 * f0 -> MainClass()
	 * f1 -> ( TypeDeclaration() )*
	 * f2 -> <EOF>
	 */
	//emit vTable and helper methods
	public String visit(Goal n, String argu) throws Exception {
		boolean main = true;
		for (Map.Entry<String, ClassContent> entry : symbolTable.getClassTable().entrySet()) {
			int numFunc = entry.getValue().getFuncTable().size();
			if(main) {numFunc = 0;}
			emit("@."+entry.getKey()+"_vtable = global [" + numFunc + " x i8*] ["	);
			if(main) {main = false; emit("]\n");continue;}

			StringBuilder str = new StringBuilder();
			for(Map.Entry<String, FunctionContent> funcEntry : entry.getValue().getFuncTable().entrySet()) {				
				str.append("i8* bitcast (");
				String type = funcEntry.getValue().getType();
				if(type.equals("int")) {
					str.append("i32");
				} else if(type.equals("boolean")) {
					str.append("i1");
				} else if(type.equals("int[]")) {
					str.append("i32*");
				} else {
					str.append("i8*");
				}
				str.append(" (i8*");
				for(Entry arg : funcEntry.getValue().getArguments()) {
					String type1 = arg.getType();
					if(type1.equals("int")) {
						str.append(",i32");
					} else if(type1.equals("boolean")) {
						str.append(",i1");
					} else if(type1.equals("int[]")) {
						str.append(",i32*");
					} else {
						str.append(",i8*");
					}
				}
				str.append(")* @" + entry.getKey() + "." + funcEntry.getKey() + " to i8*),");				
			}
			//delete last comma
			str = str.deleteCharAt(str.length() - 1);
			emit(str + "]\n");
		}
		emit("\n\ndeclare i8* @calloc(i32, i32)\r\n" + 
				"declare i32 @printf(i8*, ...)\r\n" + 
				"declare void @exit(i32)\r\n" + 
				"\r\n" + 
				"@_cint = constant [4 x i8] c\"%d\\0a\\00\"\r\n" + 
				"@_cOOB = constant [15 x i8] c\"Out of bounds\\0a\\00\"\r\n" + 
				"define void @print_int(i32 %i) {\r\n" + 
				"    %_str = bitcast [4 x i8]* @_cint to i8*\r\n" + 
				"    call i32 (i8*, ...) @printf(i8* %_str, i32 %i)\r\n" + 
				"    ret void\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				"define void @throw_oob() {\r\n" + 
				"    %_str = bitcast [15 x i8]* @_cOOB to i8*\r\n" + 
				"    call i32 (i8*, ...) @printf(i8* %_str)\r\n" + 
				"    call void @exit(i32 1)\r\n" + 
				"    ret void\r\n" + 
				"}");


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


		emit("}\n");

		return null;
	}

	@Override
	public String visit(TypeDeclaration n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(ClassDeclaration n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(ClassExtendsDeclaration n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(VarDeclaration n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(MethodDeclaration n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(FormalParameterList n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(FormalParameter n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(FormalParameterTail n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(FormalParameterTerm n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(Type n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(ArrayType n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(BooleanType n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(IntegerType n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(Statement n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(Block n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(AssignmentStatement n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(ArrayAssignmentStatement n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(IfStatement n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(WhileStatement n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(PrintStatement n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(Expression n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(AndExpression n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(CompareExpression n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(PlusExpression n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(MinusExpression n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(TimesExpression n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(ArrayLookup n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(ArrayLength n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(MessageSend n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(ExpressionList n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(ExpressionTail n, String argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public String visit(ExpressionTerm n, String argu) throws Exception {
		// TODO Auto-generated method stub
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
	 * f0 -> <IDENTIFIER>
	 */
	public String visit(Identifier n, String argu) throws Exception {
		return n.f0.toString();
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

	@Override
	public String visit(TrueLiteral n, String argu) throws Exception {
		return "true";
	}

	@Override
	public String visit(FalseLiteral n, String argu) throws Exception {
		return "false";
	}

	@Override
	public String visit(ThisExpression n, String argu) throws Exception {
		return "this";
	}

}
