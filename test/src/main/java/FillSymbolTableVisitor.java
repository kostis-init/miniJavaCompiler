import syntaxtree.*;
import visitor.GJNoArguDepthFirst;

import java.util.Map;

public class FillSymbolTableVisitor extends GJNoArguDepthFirst<Object> {
   
   //TODO: throw exceptions (-te in gcc)
   
   private SymbolTable symbolTable;
   private Content currentContent;
   private boolean inClassContent;
   
   public FillSymbolTableVisitor(SymbolTable symbolTable) {
      this.symbolTable = symbolTable;
      this.currentContent = null;
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
   public Object visit(MainClass n) throws Exception{
      Object _ret=null;
   

      FunctionContent functionContent = new FunctionContent("main","void",null);
      String argName = n.f11.accept(this).toString();
      functionContent.addArgument(new Entry(argName,"String[]"));
      this.currentContent = functionContent;

      
      inClassContent = false;
      //visit the declarations to fill the functionContent
      if (n.f14.present()){
    	  n.f14.accept(this);
      }

      String className = n.f1.accept(this).toString();
      ClassContent classContent = new ClassContent(className,null);
      classContent.addFunction("main",functionContent);

      //add the class to symbol table
      symbolTable.addClass(className,classContent);
      symbolTable.setMainClass(classContent);


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
   public Object visit(ClassDeclaration n) throws Exception{
      Object _ret=null;
      
      String className = n.f1.accept(this).toString();
      ClassContent classContent = new ClassContent(className,null);
      
      this.currentContent = classContent;
      
      
      inClassContent = true;
      //visit the declarations to fill the classContent
      if (n.f3.present()){
         n.f3.accept(this);
      }
      inClassContent = false;
      this.currentContent = classContent;
      //visit the method declarations to fill the classContent
      if (n.f4.present()){
         n.f4.accept(this);
      }
      
      symbolTable.addClass(className,classContent);
      
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
   public Object visit(ClassExtendsDeclaration n) throws Exception{
      Object _ret=null;
   
      String className = n.f1.accept(this).toString();
      
      //f3 must already exist in symbol table, otherwise error
      String extendsName = n.f3.accept(this).toString();
      boolean exists = false;
      ClassContent superClass = null;
      for (Map.Entry<String, ClassContent> entry : symbolTable.getClassTable().entrySet()) {
         if(extendsName.equals(entry.getKey())){
            exists = true;
            superClass = entry.getValue();
            break;
         }
      }
      if (!exists || extendsName.equals(className)){
         throw new Exception("error, there is no class \""+ className + "\" to extend");
      }
   
      ClassContent classContent = new ClassContent(className,superClass);
   
      this.currentContent = classContent;
   
      inClassContent = true;
      //visit the declarations to fill the classContent
      if (n.f5.present()){
         n.f5.accept(this);
      }
      inClassContent = false;
      this.currentContent = classContent;
      //visit the method declarations to fill the classContent
      if (n.f6.present()){
         n.f6.accept(this);
      }
   
      symbolTable.addClass(className,classContent);
      
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
   public Object visit(MethodDeclaration n) throws Exception{
      Object _ret=null;
      //only from class declarations we can come here
      ClassContent classContentKeeper = (ClassContent) this.currentContent;
   
      String funcName = n.f2.accept(this).toString();
      String type = n.f1.accept(this).toString();
      FunctionContent functionContent = new FunctionContent(funcName,type,classContentKeeper);

      this.currentContent = functionContent;
      //visit the parameter list to fill the functionContent arguments
      n.f4.accept(this);

      inClassContent = false;
      
      //visit the declarations to fill the functionContent
      if (n.f7.present()){
    	  n.f7.accept(this);
      }

      
      //keep offset (if the function is not overriding another one)
	  if(classContentKeeper.inSuperFuncTable(funcName) == null) {
	      int offset = classContentKeeper.getCurrentFuncOffset();
	      functionContent.setOffset(offset);
	      classContentKeeper.setFuncOffset(offset + 8);
	  }
	  else {
		  functionContent.setOffset(classContentKeeper.getFunctionSuper(funcName).getOffset());
	  }
      //add the function content to the class content
      classContentKeeper.addFunction(funcName,functionContent);
      
      //return to previous content
      this.currentContent = classContentKeeper;
      return _ret;
   }
   
   /**
    * f0 -> Type()
    * f1 -> Identifier()
    */
   public Object visit(FormalParameter n) throws Exception{
      Object _ret=null;
   
      String name = n.f1.accept(this).toString();
      String type = n.f0.accept(this).toString();
   
      this.currentContent.addArgument(new Entry(name,type));
      
      return _ret;
   }

   /**
    * f0 -> <IDENTIFIER>
    */
   public Object visit(Identifier n) throws Exception{
      return n.f0.toString();
   }
   
   /**
    * f0 -> Type()
    * f1 -> Identifier()
    * f2 -> ";"
    */
   public Object visit(VarDeclaration n) throws Exception{
      Object _ret=null;
      
      String name = n.f1.accept(this).toString();
      String type = n.f0.accept(this).toString();
      
      //keep offset
      if (inClassContent) {
    	  int newOffset;
    	  if(type.equals("int"))newOffset = 4;
    	  else if(type.equals("boolean")) newOffset = 1;
    	  else newOffset = 8;
    	  int offset = this.currentContent.getCurrentOffset();
    	  this.currentContent.addVariable(new Entry(name, type, offset));
    	  this.currentContent.setVarsOffset(offset + newOffset);
      }else {
    	  this.currentContent.addVariable(new Entry(name, type));
      }
         
      return _ret;
   }
   
   /**
    * f0 -> ArrayType()
    *       | BooleanType()
    *       | IntegerType()
    *       | Identifier()
    */
   public Object visit(Type n) throws Exception{
      return n.f0.accept(this);
   }
   
   /**
    * f0 -> "int"
    * f1 -> "["
    * f2 -> "]"
    */
   public Object visit(ArrayType n) throws Exception{
      return "int[]";
   }
   
   /**
    * f0 -> "boolean"
    */
   public Object visit(BooleanType n) throws Exception{
      return "boolean";
   }
   
   /**
    * f0 -> "int"
    */
   public Object visit(IntegerType n) throws Exception{
      return "int";
   }
   
}
