public abstract class Content {
    public void addVariable(Entry variable) throws Exception{}
    public void addFunction(String name, FunctionContent funcContent) throws Exception{}
    public void addArgument(Entry arg) throws Exception{}
    public void print(){}
    public int getCurrentOffset() {return 0;}
    public void setVarsOffset(int num) {}
    public int getCurrentFuncOffset() {return 0;}
    public void setFuncOffset(int num) {}
    
}
