import java.util.LinkedHashMap;
import java.util.Map;

public class SymbolTable
{
	private Map<String, ClassContent> classTable;
	private ClassContent mainClass;
	
	public SymbolTable() {
		this.classTable = new LinkedHashMap<>();
	}
	
	public Map<String, ClassContent> getClassTable() {
		return classTable;
	}
	
	public void addClass(String name,ClassContent classContent) throws Exception
	{
		if (this.classTable.containsKey(name)){
			throw new Exception("Class already defined");
		}
		else{
			this.classTable.put(name,classContent);
		}
	}
	
	public ClassContent getClassContent(String name){
		return classTable.get(name);
	}
	
	public ClassContent getMainClass() {
		return mainClass;
	}
	
	public void setMainClass(ClassContent mainClass) {
		this.mainClass = mainClass;
	}
	
	
	public void printOffsets() {
		System.out.println("OFFSETS:\n");
		boolean skip = true;
		for (Map.Entry<String, ClassContent> entry : classTable.entrySet()) {
			//skip first class
			if(skip) {skip = false; continue;}
			System.out.println("----------Class " + entry.getKey() + "------------");
			System.out.println("---Variables---");
			for(Entry var: entry.getValue().getVariables()) {
				System.out.println(entry.getKey() + "." + var.getName() + ": " + var.getOffset());
			}
			System.out.println("---Methods---");
			for (Map.Entry<String, FunctionContent> funcEntry : entry.getValue().getFuncTable().entrySet()) {
				if(entry.getValue().inSuperFuncTable(funcEntry.getValue().getName()) == null ) {
					System.out.println(entry.getKey() + "." + funcEntry.getValue().getName() + ": " + funcEntry.getValue().getOffset());
				}
			}
			System.out.println();
		}
	}
	
	//for debug
	public void print()
	{
		for (Map.Entry<String, ClassContent> entry : classTable.entrySet()) {
			System.out.println("Class: " + entry.getKey());
			entry.getValue().print();
			System.out.println("\n----------END OF CLASS----------\n");
		}
	}
	
}
