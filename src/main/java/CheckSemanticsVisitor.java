import syntaxtree.*;
import visitor.GJNoArguDepthFirst;

import java.util.Stack;

public class CheckSemanticsVisitor extends GJNoArguDepthFirst<Entry> {
    
    private SymbolTable symbolTable;
    private FunctionContent currentFunctionContent;
    private ClassContent currentClassContent;
    private boolean identifierIsVariable;
    
    public CheckSemanticsVisitor(SymbolTable symbolTable) {
        this.symbolTable = symbolTable;
        this.currentFunctionContent = null;
        this.currentClassContent = null;
    }
    
    private Entry getIdentifierEntry(String name) throws Exception{
        Entry _ret = currentFunctionContent.getVariableEntry(name);
        if (_ret != null) return _ret;
        
        _ret = currentClassContent.getVariableEntry(name);
        
        if (_ret == null){
            throw new Exception("this variable has not been declared");
        }
        return _ret;
    }
    
    private FunctionContent getFunctionContent(String name){
        return currentClassContent.getFunctionSuper(name);
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
    public Entry visit(MainClass n) throws Exception{
        Entry _ret=null;
        //set the current contents
        this.currentFunctionContent = symbolTable.getMainClass().getFunction("main");
        this.currentClassContent = symbolTable.getClassContent(n.f1.accept(this).getName());
        
        //visit the statements to check semantics
        if (n.f15.present()){
            n.f15.accept(this);
        }
        return _ret;
    }
    
    /**
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "{"
     * f3 -> ( VarDeclaration() )*
     * f4 -> ( MethodDeclaration() )*
     * f5 -> "}"
     */
    public Entry visit(ClassDeclaration n) throws Exception{
        Entry _ret=null;
        
        //set the current class content
        this.currentClassContent = symbolTable.getClassContent(n.f1.accept(this).getName());
        //visit method declaration
        if (n.f4.present()){
            n.f4.accept(this);
        }
        return _ret;
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
    public Entry visit(ClassExtendsDeclaration n) throws Exception{
        Entry _ret=null;
    
        this.identifierIsVariable = false;
        //set the current class content
        this.currentClassContent = symbolTable.getClassContent(n.f1.accept(this).getName());
        //visit method declaration
        if (n.f6.present()){
            n.f6.accept(this);
        }
        
        return _ret;
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
    public Entry visit(MethodDeclaration n) throws Exception{
        Entry _ret=null;
        
        this.identifierIsVariable = false;
        //set current function content
        this.currentFunctionContent = this.currentClassContent.getFunction(n.f2.accept(this).getName());
        
        //visit statement
        if (n.f8.present()){
            n.f8.accept(this);
        }
        
        //visit expression
        String type = n.f10.accept(this).getType();
        if (type == null) {
        	throw new Exception("error, identifier in return expression has not been declared");
        }
        if (type != this.currentFunctionContent.getType()) {
        	throw new Exception("error, function " + this.currentFunctionContent.getName() + " has different return type than its return expression");
        }
        
        return _ret;
    }
    
    
    /**
     * f0 -> "{"
     * f1 -> ( Statement() )*
     * f2 -> "}"
     */
    public Entry visit(Block n) throws Exception{
        return n.f1.accept(this);
    }
    
    /**
     * f0 -> Identifier()
     * f1 -> "="
     * f2 -> Expression()
     * f3 -> ";"
     */
    public Entry visit(AssignmentStatement n) throws Exception{
        Entry _ret=null;
        
        //check that f2 type is same type or subtype of f0
        this.identifierIsVariable = true;
        String identifierType = getIdentifierEntry(n.f0.accept(this).getName()).getType();
        String expressionType = n.f2.accept(this).getType();
     
        if (identifierType.equals(expressionType)) {
        	return _ret;
        }
        
        if(identifierType == null || expressionType == null) {
        	throw new Exception("error, identifier in assignment statement has not been declared");
        }
        //error if f2 or f0 is int[],int,boolean
        if (identifierType.equals("int") || identifierType.equals("int[]")
        	|| identifierType.equals("boolean") || expressionType.equals("int")
        	|| expressionType.equals("int[]") || expressionType.equals("boolean")) {
        	throw new Exception("error, assignment statement has incompatible types");
        }
        //check if f2 extends f0
        if (symbolTable.getClassContent(expressionType).hasSuperClass(identifierType)) {
        	return _ret;
        }
        throw new Exception("error, assignment statement has incompatible types");
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
    public Entry visit(ArrayAssignmentStatement n) throws Exception{
        Entry _ret=null;
        this.identifierIsVariable = true;

        //check that f0 has type int[]
        String type = n.f0.accept(this).getType();
        if(type == null) {
        	throw new Exception("error, identifier has not been declared");
        }
        if(type != "int[]") {
        	throw new Exception("error, identifier is not of type int[]");
        }
        
        //check that f2 has type int
        type = n.f2.accept(this).getType();
        if(type == null) {
        	throw new Exception("error, identifier has not been declared");
        }
        if(type != "int") {
        	throw new Exception("error, identifier in array assignment is not of type int");
        }
        
        //check that f5 has type int
        type = n.f5.accept(this).getType();
        if(type == null) {
        	throw new Exception("error, identifier has not been declared");
        }
        if(type != "int") {
        	throw new Exception("error, identifier in array assignment is not of type int");
        }
        
        return _ret;
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
    public Entry visit(IfStatement n) throws Exception{
    	Entry _ret=null;

        
        //check that f2 is boolean
        String type = n.f2.accept(this).getType();
        if (type == null) {
        	throw new Exception("error, expression undefined");
        }
        if (type != "boolean") {
        	throw new Exception("error, expression in while is not boolean");
        }
        
        n.f4.accept(this);
        
        return _ret;
    }
    
    /**
     * f0 -> "while"
     * f1 -> "("
     * f2 -> Expression()
     * f3 -> ")"
     * f4 -> Statement()
     */
    public Entry visit(WhileStatement n) throws Exception{
        Entry _ret=null;

       
        //check that f2 is boolean
        String type = n.f2.accept(this).getType();
        if (type == null) {
        	throw new Exception("error, expression undefined");
        }
        if (type != "boolean") {
        	throw new Exception("error, expression in while is not boolean");
        }
        
        n.f4.accept(this);
        
        return _ret;
    }
    
    /**
     * f0 -> "System.out.println"
     * f1 -> "("
     * f2 -> Expression()
     * f3 -> ")"
     * f4 -> ";"
     */
    public Entry visit(PrintStatement n) throws Exception{
        Entry _ret=null;

        //check that expression is int or boolean
        String type = n.f2.accept(this).getType();
        if (type == null) {
        	throw new Exception("error, identifier has not been declared");
        }
        if (type != "int" && type != "boolean"){
        	throw new Exception("error, println can only accept integers and booleans");
        }
        
        return _ret;
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
    public Entry visit(Expression n) throws Exception{
    	this.identifierIsVariable = true;
        return n.f0.accept(this);
    }
    
    
    /**
     * f0 -> Clause()
     * f1 -> "&&"
     * f2 -> Clause()
     */
    public Entry visit(AndExpression n) throws Exception{
        //check that clauses' type is boolean
        if(!n.f0.accept(this).getType().equals("boolean") || !n.f2.accept(this).getType().equals("boolean")){
            throw new Exception("Error: a clause in AndExpression is not boolean");
        }
        
        return new Entry(null,"boolean");
    }
    
    /**
     * f0 -> PrimaryExpression()
     * f1 -> "<"
     * f2 -> PrimaryExpression()
     */
    public Entry visit(CompareExpression n) throws Exception{
        //check that types are int
        if(!n.f0.accept(this).getType().equals("int") || !n.f2.accept(this).getType().equals("int")){
        	throw new Exception("Error: a PrimaryExpression in CompareExpression is not int");
        }
        
        return new Entry(null,"boolean");
    }
    
    /**
     * f0 -> PrimaryExpression()
     * f1 -> "+"
     * f2 -> PrimaryExpression()
     */
    public Entry visit(PlusExpression n) throws Exception{
        //check that types are int
        if(!n.f0.accept(this).getType().equals("int") || !n.f2.accept(this).getType().equals("int")){
        	throw new Exception("Error: a PrimaryExpression in PlusExpression is not int");
        }
    
        return new Entry(null,"int");
    }
    
    /**
     * f0 -> PrimaryExpression()
     * f1 -> "-"
     * f2 -> PrimaryExpression()
     */
    public Entry visit(MinusExpression n) throws Exception{
        //check that types are int
        if(!n.f0.accept(this).getType().equals("int") || !n.f2.accept(this).getType().equals("int")){
            throw new Exception("Error: a PrimaryExpression in MinusExpression is not int");
        }
    
        return new Entry(null,"int");
    }
    
    /**
     * f0 -> PrimaryExpression()
     * f1 -> "*"
     * f2 -> PrimaryExpression()
     */
    public Entry visit(TimesExpression n) throws Exception{
        //check that types are int
        if(!n.f0.accept(this).getType().equals("int") || !n.f2.accept(this).getType().equals("int")){
            throw new Exception("Error: a PrimaryExpression in TimesExpression is not int");
        }
    
        return new Entry(null,"int");
    }
    
    /**
     * f0 -> PrimaryExpression()
     * f1 -> "["
     * f2 -> PrimaryExpression()
     * f3 -> "]"
     */
    public Entry visit(ArrayLookup n) throws Exception{
        //check that f0 is int[] and f2 is int
        if(!n.f0.accept(this).getType().equals("int[]") || !n.f2.accept(this).getType().equals("int")){
            throw new Exception("Error: index of array is not int or identifier is not defined as int[]");
        }
        
        return new Entry(null,"int");
    }
    
    /**
     * f0 -> PrimaryExpression()
     * f1 -> "."
     * f2 -> "length"
     */
    public Entry visit(ArrayLength n) throws Exception{
    	this.identifierIsVariable = true;
        if(!n.f0.accept(this).getType().equals("int[]")){
            throw new Exception("Error: identifier is not defined as int[]");
        }
        
        return new Entry(null,"int");
    }
    
    
    /**
     * f0 -> PrimaryExpression()
     * f1 -> "."
     * f2 -> Identifier()
     * f3 -> "("
     * f4 -> ( ExpressionList() )?
     * f5 -> ")"
     */
    //The following vars are used for checking parameters' types in calling functions
    private Stack<FunctionContent> matchingFunctions = new Stack<>();
    private Stack<Integer> indexes = new Stack<>();
    private Stack<Boolean> flags = new Stack<>();//true when function's arguments are all checked
    
    public Entry visit(MessageSend n) throws Exception{
        //check that f0 is a variable with type some class, keep it in classContent
    	this.identifierIsVariable = true;
        Entry e = n.f0.accept(this);
        if (!this.symbolTable.getClassTable().containsKey(e.getType())){
        	throw new Exception("Error: invalid expression in MessageSend, a class variable was expected");
        }
        ClassContent classContent = symbolTable.getClassContent(e.getType());
        
        //check that f2 is a member function of class f0 (or its superclasses)
        this.identifierIsVariable = false;
        FunctionContent functionContent = classContent.getFunctionSuper(n.f2.accept(this).getName());
        if (functionContent == null){
            throw new Exception("Error: function is not a member of the class " + classContent.getName());
        }
        
        //check that the ExpressionList is consistent with the declaration
        matchingFunctions.push(functionContent);
        indexes.push(0);flags.push(false);
        if (!n.f4.present()) {
        	if (functionContent.getArguments().size() != 0) {
        		throw new Exception("No parameter given when calling function " + functionContent.getName());
        	}
        }else {
        	if (functionContent.getArguments().size() == 0) {
        		throw new Exception("No parameters are needed when calling function " + functionContent.getName());
        	}
        	n.f4.accept(this);
        	if(flags.peek() == false) {
            	throw new Exception("error, the calling function needs more parameters");
            }
        }
        indexes.pop();
        matchingFunctions.pop();
        flags.pop();
        
        return new Entry(null,functionContent.getType());
    }
    
    /**
     * f0 -> Expression()
     * f1 -> ExpressionTail()
     */
    public Entry visit(ExpressionList n) throws Exception{
    	String type = n.f0.accept(this).getType();
    	//check types and subtypes
    	if ((!type.equals(this.matchingFunctions.peek().getArguments().get(0).getType()))
    		&& !symbolTable.getClassContent(type).hasSuperClass(this.matchingFunctions.peek().getArguments().get(0).getType())) {
        	throw new Exception("error, wrong parameter type, expected " + this.matchingFunctions.peek().getArguments().get(0).getType() + ", but got type " + type);
        }
       
        if(this.matchingFunctions.peek().getArguments().size() == 1) {
        	flags.pop();
        	flags.push(true);
        }
        
        n.f1.accept(this);
        
        return null;
    }
    
    /**
     * f0 -> ( ExpressionTerm() )*
     */
    public Entry visit(ExpressionTail n) throws Exception{
        return n.f0.accept(this);
    }
    
    /**
     * f0 -> ","
     * f1 -> Expression()
     */
    public Entry visit(ExpressionTerm n) throws Exception{
    
    	int temp = indexes.pop();
    	temp++;
    	indexes.push(temp);
    	
    	if (this.matchingFunctions.peek().getArguments().size() <= temp) {
    		throw new Exception("error, wrong parameters number when calling function " + this.matchingFunctions.peek().getName());
    	}
    	if(n.f1.accept(this).getType() == null) {
    		throw new Exception("error, identifier not declared");
    	}
    	if(n.f1.accept(this).getType() != this.matchingFunctions.peek().getArguments().get(indexes.peek()).getType()) {
    		throw new Exception("error, wrong parameter type in calling function " + this.matchingFunctions.peek().getName());
    	}
        
    	if(this.matchingFunctions.peek().getArguments().size() == temp+1) {
        	flags.pop();
        	flags.push(true);
        }
    	
        return null;
    }
    
    /**
     * f0 -> NotExpression()
     *       | PrimaryExpression()
     */
    public Entry visit(Clause n) throws Exception{
        return n.f0.accept(this);
    }
    /**
     * f0 -> "!"
     * f1 -> Clause()
     */
    public Entry visit(NotExpression n) throws Exception{
        //check that f1 is boolean
        if(!n.f1.accept(this).getType().equals("boolean")){
            throw new Exception("Error: an int is required for array allocation");
        }
        
        return new Entry(null,"boolean");
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
    public Entry visit(PrimaryExpression n) throws Exception{
        return n.f0.accept(this);
    }
    
    /**
     * f0 -> <INTEGER_LITERAL>
     */
    public Entry visit(IntegerLiteral n) throws Exception{
        return new Entry(null,"int");
    }
    
    /**
     * f0 -> "true"
     */
    public Entry visit(TrueLiteral n) throws Exception{
        return new Entry(null,"boolean");
    }
    
    /**
     * f0 -> "false"
     */
    public Entry visit(FalseLiteral n) throws Exception{
        return new Entry(null,"boolean");
    }
    
    
    /**
     * f0 -> <IDENTIFIER>
     */
    public Entry visit(Identifier n) throws Exception{
    	
    	String name = n.f0.toString();
    	String type = null;
    	try {
	    	if(identifierIsVariable == true) {
	    		type = this.getIdentifierEntry(name).getType();
	    	}else {
	    		type = this.getFunctionContent(name).getType();
	    	}
    	}catch(Exception ex) {
    		
    	}
    	
        return new Entry(name,type);
    	
    }
    
    /**
     * f0 -> "this"
     */
    public Entry visit(ThisExpression n) throws Exception{
        return new Entry(currentClassContent.getName(),currentClassContent.getName());
    }
    
    /**
     * f0 -> "new"
     * f1 -> "int"
     * f2 -> "["
     * f3 -> Expression()
     * f4 -> "]"
     */
    public Entry visit(ArrayAllocationExpression n) throws Exception{
        
        //check that f3 is int
        if(!n.f3.accept(this).getType().equals("int")){
            throw new Exception("Error: an int is required for array allocation");
        }
    
        return new Entry(null,"int[]");
    }
    
    /**
     * f0 -> "new"
     * f1 -> Identifier()
     * f2 -> "("
     * f3 -> ")"
     */
    public Entry visit(AllocationExpression n) throws Exception{
        
        //check that f1 is a class
        ClassContent classContent = symbolTable.getClassContent(n.f1.accept(this).getName());
        if (classContent == null){
            throw new Exception("Error: attempt to allocate a non-class");
        }
        
        return new Entry(null, classContent.getName());
    }
    
    /**
     * f0 -> "("
     * f1 -> Expression()
     * f2 -> ")"
     */
    public Entry visit(BracketExpression n) throws Exception{
        return n.f1.accept(this);
    }
    
}