import java.util.Objects;

public class Entry
{
	private String name;//name of variable
	private String type;//type of variable
    private int offset = 0;
    
    public Entry(String name, String type) {
        this.name = name;
        this.type = type;
    }
    
    public Entry(String name, String type, int offset) {
        this.name = name;
        this.type = type;
        this.offset = offset;
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
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Entry entry = (Entry) o;
        return this.name.equals(entry.getName());
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(name);
    }
}
