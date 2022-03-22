import syntaxtree.Goal;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

public class Main {

    public static void main(String[] args) {

        //temporary
        args = new String[]{
                "inputs/TreeVisitor.java",
                "inputs/BinaryTree.java",
                "inputs/BubbleSort.java",
                "inputs/Factorial.java",
                "inputs/LinearSearch.java",
                "inputs/LinkedList.java",
                "inputs/MoreThan4.java",
                "inputs/QuickSort.java"
        };

        if (args.length < 1) {
            System.err.println("Usage: java Main <inputFile1> <inputFile2> ... <inputFileN>");
            System.exit(1);
        }

        for (String arg : args) {
            System.out.println(">>>>>>>>Checking File: " + arg);
            FileInputStream fis = null;
            try {
                SymbolTable symbolTable = new SymbolTable();

                fis = new FileInputStream(arg);

                MiniJavaParser parser = new MiniJavaParser(fis);
                Goal root = parser.Goal();
                System.out.println("Program parsed successfully.");

                /**
                 * Step 1: Parse Declarations
                 * Fill the symbol table with acceptable declarations of:
                 * + classes
                 * + variables in classes
                 * + functions in classes
                 * + variables in functions
                 *
                 * If a non-acceptable declaration exists, an exception is thrown
                 */
                FillSymbolTableVisitor fill = new FillSymbolTableVisitor(symbolTable);
                root.accept(fill);

                /**
                 * Step 2: Check Declarations' Semantics
                 * Check that the types and names in the Symbol Table are valid
                 */
                if (!validTypesAndNames(symbolTable)) {
                    throw new Exception("Something went wrong in type and name checking!");
                }

                /**
                 * Step 3: Check Statements
                 * Check that all the variables are properly used (based on their types)
                 * with the help of the Symbol Table
                 */
                CheckSemanticsVisitor check = new CheckSemanticsVisitor(symbolTable);
                root.accept(check);

                /**
                 * Step 4: Produce LLVM code
                 */
                //TODO: change the output file's name
                LLVMVisitor llvmVisitor = new LLVMVisitor(symbolTable, arg.concat(".ll"));
                root.accept(llvmVisitor, null);

                System.out.println("**********************\nCompilation succesful!\n**********************\n");
            } catch (ParseException | FileNotFoundException ex) {
                System.out.println(ex.getMessage());
            } catch (Exception ex) {
                ex.printStackTrace();
                System.out.println(ex.getMessage());
                System.out.println("Error! The program did not compile!\n");
            } finally {
                try {
                    if (fis != null) fis.close();
                } catch (IOException ex) {
                    System.err.println(ex.getMessage());
                }
            }
        }
    }

    public static boolean validTypesAndNames(SymbolTable symbolTable) throws Exception {

        //typeSet contains the valid types that a variable must be
        ArrayList<String> typeSet = new ArrayList<>();
        typeSet.add("int");
        typeSet.add("int[]");
        typeSet.add("boolean");
        for (Map.Entry<String, ClassContent> entry : symbolTable.getClassTable().entrySet()) {
            typeSet.add(entry.getKey());
        }

        //for each class
        for (Map.Entry<String, ClassContent> entry : symbolTable.getClassTable().entrySet()) {
            ClassContent curClass = entry.getValue();
            //for each variable of the class
            for (Entry var : curClass.getVariables()) {
                if (!typeSet.contains(var.getType())) {
                    throw new Exception("error, invalid declaration in class " + curClass.getName());
                }
            }
            //for each function of the class
            for (Map.Entry<String, FunctionContent> funcEntry : curClass.getFuncTable().entrySet()) {
                FunctionContent curFunc = funcEntry.getValue();

                //for each variable of the function (not for main)
                if (!curFunc.getName().equals("main")) {
                    for (Entry arg : curFunc.getArguments()) {
                        if (!typeSet.contains(arg.getType())) {
                            throw new Exception("error, invalid declaration in function " + curFunc.getName() + " of class " + curClass.getName());
                        }
                    }
                }
                for (Entry var : curFunc.getVariables()) {
                    if (!typeSet.contains(var.getType())) {
                        throw new Exception("error, invalid declaration in function " + curFunc.getName() + " of class " + curClass.getName());
                    }
                }
            }
        }
        return true;
    }
}
