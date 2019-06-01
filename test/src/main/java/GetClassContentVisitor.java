import syntaxtree.AllocationExpression;
import syntaxtree.BracketExpression;
import syntaxtree.Clause;
import syntaxtree.Expression;
import syntaxtree.Identifier;
import syntaxtree.MessageSend;
import syntaxtree.NotExpression;
import syntaxtree.PrimaryExpression;
import syntaxtree.ThisExpression;
import visitor.GJNoArguDepthFirst;

public class GetClassContentVisitor extends GJNoArguDepthFirst<String> {
	
	

    private SymbolTable symbolTable;
    private ClassContent currentClassContent;
    private FunctionContent currentFunctionContent;
    private boolean identifierIsVariable;
    
    public GetClassContentVisitor(SymbolTable symbolTable, ClassContent curC, FunctionContent curF) {
        this.symbolTable = symbolTable;
        this.currentClassContent = curC;
        this.currentFunctionContent = curF;
        this.identifierIsVariable = true;
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
    public String visit(Expression n) throws Exception{
    	this.identifierIsVariable = true;
        return n.f0.accept(this);
    }
    
    
    /**
     * f0 -> PrimaryExpression()
     * f1 -> "."
     * f2 -> Identifier()
     * f3 -> "("
     * f4 -> ( ExpressionList() )?
     * f5 -> ")"
     */
    
    public String visit(MessageSend n) throws Exception{
    	this.identifierIsVariable = true;
    	String clazz = n.f0.accept(this);
    	
        this.identifierIsVariable = false;
        
        this.currentClassContent = symbolTable.getClassContent(clazz);
        
        return n.f2.accept(this);
    }
    
    /**
     * f0 -> NotExpression()
     *       | PrimaryExpression()
     */
    public String visit(Clause n) throws Exception{
        return n.f0.accept(this);
    }
    /**
     * f0 -> "!"
     * f1 -> Clause()
     */
    public String visit(NotExpression n) throws Exception{        
        return n.f1.accept(this);
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
    public String visit(PrimaryExpression n) throws Exception{
        return n.f0.accept(this);
    }
    
    /**
     * f0 -> <IDENTIFIER>
     */
    public String visit(Identifier n) throws Exception{
    	
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
        return type;
    	
    }
    
    /**
     * f0 -> "this"
     */
    public String visit(ThisExpression n) throws Exception{
        return this.currentClassContent.getName();
    }
    
    /**
     * f0 -> "new"
     * f1 -> Identifier()
     * f2 -> "("
     * f3 -> ")"
     */
    public String visit(AllocationExpression n) throws Exception{        
        return n.f1.f0.toString();
    }
    
    /**
     * f0 -> "("
     * f1 -> Expression()
     * f2 -> ")"
     */
    public String visit(BracketExpression n) throws Exception{
        return n.f1.accept(this);
    }
    

}
