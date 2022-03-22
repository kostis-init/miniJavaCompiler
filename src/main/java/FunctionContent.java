import java.util.ArrayList;
import java.util.List;

public class FunctionContent extends Content{
    
    private String name;    //name of this function
    private String type;    //return type
    private List<Entry> arguments;
    private List<Entry> variables;
    private int offset = 0;
    private ClassContent realClass;
    
    public ClassContent getRealClass() {
		return realClass;
	}

    
	public void setRealClass(ClassContent currentClass) {
		
		this.realClass = currentClass.setReal(this);
		
	}

	public FunctionContent(String name, String type, ClassContent clazz) {
        this.name = name;
        this.type = type;
        this.realClass = clazz;
        this.variables = new ArrayList<>();
        this.arguments = new ArrayList<>();
    }
    
    public int getOffset() {
    	return this.offset;
    }
    
    public void setOffset(int num) {
    	this.offset = num;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getType() {
        return type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    
    public List<Entry> getVariables() {
        return variables;
    }
    public List<Entry> getArguments() {
        return arguments;
    }
    
    public Entry getVariableEntry(String name){
        
        for (Entry e: this.arguments){
            if (e.getName().equals(name)){
                return e;
            }
        }
        
        for (Entry e: this.variables){
            if (e.getName().equals(name)){
                return e;
            }
        }
        return null;
    }
    
    public void addArgument(Entry arg) throws Exception
    {
        if(this.arguments.contains(arg)) {
            throw new Exception("Argument already exists in args list");
        }
        else {
            arguments.add(arg);
        }
    }
    
    public void addVariable(Entry variable) throws Exception
    {
        if(this.variables.contains(variable) || this.arguments.contains(variable)) {
            throw new Exception("Variable already exists");
        }
        else {
            variables.add(variable);
        }
    }
    
    //for debug
    public void print(){
        System.out.println("My name is " + name);
        System.out.println("My return type is " + type);
        System.out.println("My arguments are:");
        for(Entry e: arguments){
            System.out.println("\tName: " + e.getName() + ", Type: " + e.getType());
        }
        System.out.println("My variables are:");
        for (Entry e: variables){
            System.out.println("\tName: " + e.getName() + ", Type: " + e.getType());
        }
    }
}
