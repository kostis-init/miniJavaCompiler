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
import syntaxtree.NodeList;
import syntaxtree.NodeListOptional;
import syntaxtree.NodeOptional;
import syntaxtree.NodeSequence;
import syntaxtree.NodeToken;
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

public class LLVMVisitor extends GJDepthFirst<Info, Info> {

	
	private PrintWriter writer;
	private SymbolTable symbolTable;
	
	public LLVMVisitor(SymbolTable symbolTable, String filename) throws FileNotFoundException {
		this.writer = new PrintWriter(filename);
		this.symbolTable = symbolTable;
	}
	
	private void emit(String s) {
		this.writer.print(s);
		this.writer.flush();
	}
	
	//emit vTable and helper methods
	public Info visit(Goal n, Info argu) throws Exception {
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
			emit(str + "]\n\n\n");
		}
		emit("declare i8* @calloc(i32, i32)\r\n" + 
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
		
		return super.visit(n, argu);
	}

	@Override
	public Info visit(MainClass n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(TypeDeclaration n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(ClassDeclaration n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(ClassExtendsDeclaration n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(VarDeclaration n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(MethodDeclaration n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(FormalParameterList n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(FormalParameter n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(FormalParameterTail n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(FormalParameterTerm n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(Type n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(ArrayType n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(BooleanType n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(IntegerType n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(Statement n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(Block n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(AssignmentStatement n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(ArrayAssignmentStatement n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(IfStatement n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(WhileStatement n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(PrintStatement n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(Expression n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(AndExpression n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(CompareExpression n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(PlusExpression n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(MinusExpression n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(TimesExpression n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(ArrayLookup n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(ArrayLength n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(MessageSend n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(ExpressionList n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(ExpressionTail n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(ExpressionTerm n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(Clause n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(PrimaryExpression n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(IntegerLiteral n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(TrueLiteral n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(FalseLiteral n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(Identifier n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(ThisExpression n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(ArrayAllocationExpression n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(AllocationExpression n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(NotExpression n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

	@Override
	public Info visit(BracketExpression n, Info argu) throws Exception {
		// TODO Auto-generated method stub
		return super.visit(n, argu);
	}

}
