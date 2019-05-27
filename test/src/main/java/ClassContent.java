import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ClassContent extends Content{
    
    private String name;    //name of this class
    private ClassContent superClass;//class that extends
    private List<Entry> variables;
    private Map<String,FunctionContent> funcTable;
    private int varsOffset;
    private int funcOffset;
    
    public ClassContent(String name, ClassContent superClass) {
        this.name = name;
        this.superClass = superClass;
        this.variables = new ArrayList<>();
        this.funcTable = new LinkedHashMap<>();
        if(superClass != null) {
        	this.varsOffset = superClass.getCurrentOffset();
        	this.funcOffset = superClass.getCurrentFuncOffset();
        }else {
        	this.varsOffset = 0;
        }
    }
    
    public int getCurrentFuncOffset() {
    	return this.funcOffset;
    }
    public void setFuncOffset(int num) {
    	this.funcOffset = num;
    }
    
    public int getCurrentOffset() {
    	return this.varsOffset;
    }
    public void setVarsOffset(int num) {
    	this.varsOffset = num;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public ClassContent getSuperClass() {
        return superClass;
    }
    
    public List<Entry> getVariables() {
        return variables;
    }
    
    public Map<String, FunctionContent> getFuncTable() {
        return funcTable;
    }
    
    public boolean hasSuperClass(String name){
    	
    	if(this.superClass == null)
    		return false;
    	if(this.superClass.getName() == name)
    		return true;
    
    	return this.superClass.hasSuperClass(name);
    }
    
    public FunctionContent getFunction(String name){
        return funcTable.get(name);
    }
    
    public FunctionContent getFunctionSuper(String name){
        if (funcTable.containsKey(name)) return funcTable.get(name);
        if (this.superClass == null) return null;
        return this.superClass.getFunctionSuper(name);
    }
    
    
    
    public Entry getVariableEntry(String name){
        
        for (Entry e: this.variables){
            if (e.getName().equals(name)){
                return e;
            }
        }
        
        //not found, search in superclass
        if (this.superClass == null) return null;
        return this.superClass.getVariableEntry(name);
    }
    
    public void addVariable(Entry variable) throws Exception
    {
        if(this.variables.contains(variable))        {
            throw new Exception("Variable has been defined");
        }
        else        {
            variables.add(variable);
        }
    }
    
    public void addFunction(String name, FunctionContent funcContent) throws Exception
    {
        if(this.funcTable.containsKey(name)){
            throw new Exception("Function overload detected");
        }
        else{
            FunctionContent superContent = this.inSuperFuncTable(name);
            if (superContent == null){   //there is no function with same name in superclasses
                this.funcTable.put(name,funcContent);
            }
            else {
                boolean sameArgs = true;
                if(funcContent.getArguments().size() != superContent.getArguments().size()) sameArgs=false;
                for (int i=0;sameArgs && i<funcContent.getArguments().size();i++)
                    if(funcContent.getArguments().get(i).getType() != superContent.getArguments().get(i).getType())
                        sameArgs = false;
                
                if (sameArgs && funcContent.getType().equals(superContent.getType())) {   //args are the same and return type is the same
                    this.funcTable.put(name, funcContent);
                } else {
                    throw new Exception("Overriding function, with different arguments or return type");
                }
            }
        }
    }
    
    //checks if a function with this name exists in superclasses
    public FunctionContent inSuperFuncTable(String name)
    {
        if (this.superClass != null){
            if (this.superClass.getFuncTable().containsKey(name)){
                return this.superClass.getFuncTable().get(name);
            }
            else{
                return this.superClass.inSuperFuncTable(name);
            }
        }
        else{
            return null;
        }
    }
    
    
    //for debug
    public void print(){
        System.out.println("My name is " + this.name);
        if(this.superClass!=null) {
            System.out.println("My superClass:");
            System.out.println("==========");
            this.superClass.print();
            System.out.println("==========");
        }
        else{
            System.out.println("I don't have a super class");
        }
        System.out.println("My variables are:");
        for (Entry e: this.variables){
            System.out.println("\tName: " + e.getName() + ", Type: " + e.getType());
        }
        
        System.out.println("My functions' info is:");
        for (Map.Entry<String, FunctionContent> entry : funcTable.entrySet()) {
            System.out.println("Function: " + entry.getKey());
            entry.getValue().print();
            System.out.println("End of function: " + entry.getKey() + "\n");
        }
    }
    
    
}
