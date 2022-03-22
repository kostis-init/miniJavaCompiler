@.LinkedList_vtable = global [0 x i8*] []
@.Element_vtable = global [6 x i8*] [i8* bitcast (i1 (i8*,i32,i32,i1)* @Element.Init to i8*),i8* bitcast (i32 (i8*)* @Element.GetAge to i8*),i8* bitcast (i32 (i8*)* @Element.GetSalary to i8*),i8* bitcast (i1 (i8*)* @Element.GetMarried to i8*),i8* bitcast (i1 (i8*,i8*)* @Element.Equal to i8*),i8* bitcast (i1 (i8*,i32,i32)* @Element.Compare to i8*)]
@.List_vtable = global [10 x i8*] [i8* bitcast (i1 (i8*)* @List.Init to i8*),i8* bitcast (i1 (i8*,i8*,i8*,i1)* @List.InitNew to i8*),i8* bitcast (i8* (i8*,i8*)* @List.Insert to i8*),i8* bitcast (i1 (i8*,i8*)* @List.SetNext to i8*),i8* bitcast (i8* (i8*,i8*)* @List.Delete to i8*),i8* bitcast (i32 (i8*,i8*)* @List.Search to i8*),i8* bitcast (i1 (i8*)* @List.GetEnd to i8*),i8* bitcast (i8* (i8*)* @List.GetElem to i8*),i8* bitcast (i8* (i8*)* @List.GetNext to i8*),i8* bitcast (i1 (i8*)* @List.Print to i8*)]
@.LL_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @LL.Start to i8*)]


declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)

@_cint = constant [4 x i8] c"%d\0a\00"
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00"
define void @print_int(i32 %i) {
	%_str = bitcast [4 x i8]* @_cint to i8*
	call i32 (i8*, ...) @printf(i8* %_str, i32 %i)
	ret void
}

define void @throw_oob() {
	%_str = bitcast [15 x i8]* @_cOOB to i8*
	call i32 (i8*, ...) @printf(i8* %_str)
	call void @exit(i32 1)
	ret void
}

define i32 @main() {
	%_7 = call i8* @calloc(i32 1, i32 8)
	%_8 = bitcast i8* %_7 to i8***
	%_9 = getelementptr [1 x i8*], [1 x i8*]* @.LL_vtable, i32 0, i32 0
	store i8** %_9,i8*** %_8
	%_1 = bitcast i8* %_7 to i8***
	%_2 = load i8**, i8*** %_1
	%_3 = getelementptr i8*, i8** %_2, i32 0
	%_4 = load i8*, i8** %_3
	%_5 = bitcast i8* %_4 to i32 (i8*)*
	%_6 = call i32 %_5(i8* %_7)
	call void (i32) @print_int(i32 %_6)

	ret i32 0
}
define i1 @Element.Init(i8* %this, i32 %.v_Age, i32 %.v_Salary, i1 %.v_Married) {
	%v_Age = alloca i32
	store i32 %.v_Age, i32* %v_Age
	%v_Salary = alloca i32
	store i32 %.v_Salary, i32* %v_Salary
	%v_Married = alloca i1
	store i1 %.v_Married, i1* %v_Married
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i32*
	%_3 = load i32, i32* %v_Age
	store i32 %_3, i32* %_1	%_4 = getelementptr i8, i8* %this, i32 12
	%_5 = bitcast i8* %_4 to i32*
	%_7 = load i32, i32* %v_Salary
	store i32 %_7, i32* %_5	%_8 = getelementptr i8, i8* %this, i32 16
	%_9 = bitcast i8* %_8 to i1*
	%_11 = load i1, i1* %v_Married
	store i1 %_11, i1* %_9
	ret i1 1
}
define i32 @Element.GetAge(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1

	ret i32 %_2
}
define i32 @Element.GetSalary(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 12
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1

	ret i32 %_2
}
define i1 @Element.GetMarried(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1

	ret i1 %_2
}
define i1 @Element.Equal(i8* %this, i8* %.other) {
	%other = alloca i8*
	store i8* %.other, i8** %other
	%ret_val = alloca i1
	%aux01 = alloca i32
	%aux02 = alloca i32
	%nt = alloca i32
	store i1 1, i1* %ret_val	%_13 = load i8*, i8** %other
	%_7 = bitcast i8* %_13 to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 1
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*)*
	%_12 = call i32 %_11(i8* %_13)
	store i32 %_12, i32* %aux01	%_16 = bitcast i8* %this to i8***
	%_17 = load i8**, i8*** %_16
	%_18 = getelementptr i8*, i8** %_17, i32 5
	%_19 = load i8*, i8** %_18
	%_20 = bitcast i8* %_19 to i1 (i8*,i32,i32)*
	%_22 = load i32, i32* %aux01
	%_23 = getelementptr i8, i8* %this, i32 8
	%_24 = bitcast i8* %_23 to i32*
	%_25 = load i32, i32* %_24
	%_21 = call i1 %_20(i8* %this, i32 %_22, i32 %_25)
	%_14 = xor i1 1, %_21	br i1 %_14, label %if0, label %if1

if0:
	store i1 0, i1* %ret_val	br label %if2

if1:
	%_35 = load i8*, i8** %other
	%_29 = bitcast i8* %_35 to i8***
	%_30 = load i8**, i8*** %_29
	%_31 = getelementptr i8*, i8** %_30, i32 2
	%_32 = load i8*, i8** %_31
	%_33 = bitcast i8* %_32 to i32 (i8*)*
	%_34 = call i32 %_33(i8* %_35)
	store i32 %_34, i32* %aux02	%_38 = bitcast i8* %this to i8***
	%_39 = load i8**, i8*** %_38
	%_40 = getelementptr i8*, i8** %_39, i32 5
	%_41 = load i8*, i8** %_40
	%_42 = bitcast i8* %_41 to i1 (i8*,i32,i32)*
	%_44 = load i32, i32* %aux02
	%_45 = getelementptr i8, i8* %this, i32 12
	%_46 = bitcast i8* %_45 to i32*
	%_47 = load i32, i32* %_46
	%_43 = call i1 %_42(i8* %this, i32 %_44, i32 %_47)
	%_36 = xor i1 1, %_43	br i1 %_36, label %if3, label %if4

if3:
	store i1 0, i1* %ret_val	br label %if5

if4:
	%_49 = getelementptr i8, i8* %this, i32 16
	%_50 = bitcast i8* %_49 to i1*
	%_51 = load i1, i1* %_50
	br i1 %_51, label %if6, label %if7

if6:
	%_60 = load i8*, i8** %other
	%_54 = bitcast i8* %_60 to i8***
	%_55 = load i8**, i8*** %_54
	%_56 = getelementptr i8*, i8** %_55, i32 3
	%_57 = load i8*, i8** %_56
	%_58 = bitcast i8* %_57 to i1 (i8*)*
	%_59 = call i1 %_58(i8* %_60)
	%_52 = xor i1 1, %_59	br i1 %_52, label %if9, label %if10

if9:
	store i1 0, i1* %ret_val	br label %if11

if10:
	store i32 0, i32* %nt	br label %if11

if11:
	br label %if8

if7:
	%_70 = load i8*, i8** %other
	%_64 = bitcast i8* %_70 to i8***
	%_65 = load i8**, i8*** %_64
	%_66 = getelementptr i8*, i8** %_65, i32 3
	%_67 = load i8*, i8** %_66
	%_68 = bitcast i8* %_67 to i1 (i8*)*
	%_69 = call i1 %_68(i8* %_70)
	br i1 %_69, label %if12, label %if13

if12:
	store i1 0, i1* %ret_val	br label %if14

if13:
	store i32 0, i32* %nt	br label %if14

if14:
	br label %if8

if8:
	br label %if5

if5:
	br label %if2

if2:
	%_73 = load i1, i1* %ret_val

	ret i1 %_73
}
define i1 @Element.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%retval = alloca i1
	%aux02 = alloca i32
	store i1 0, i1* %retval	%_5 = load i32, i32* %num2
	%_4 = add i32 %_5, 1	store i32 %_4, i32* %aux02	%_7 = load i32, i32* %num1
	%_8 = load i32, i32* %num2
	%_6 = icmp slt i32 %_7, %_8	br i1 %_6, label %if0, label %if1

if0:
	store i1 0, i1* %retval	br label %if2

if1:
	%_12 = load i32, i32* %num1
	%_13 = load i32, i32* %aux02
	%_11 = icmp slt i32 %_12, %_13	%_10 = xor i1 1, %_11	br i1 %_10, label %if3, label %if4

if3:
	store i1 0, i1* %retval	br label %if5

if4:
	store i1 1, i1* %retval	br label %if5

if5:
	br label %if2

if2:
	%_16 = load i1, i1* %retval

	ret i1 %_16
}
define i1 @List.Init(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i1*
	store i1 1, i1* %_1
	ret i1 1
}
define i1 @List.InitNew(i8* %this, i8* %.v_elem, i8* %.v_next, i1 %.v_end) {
	%v_elem = alloca i8*
	store i8* %.v_elem, i8** %v_elem
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
	%v_end = alloca i1
	store i1 %.v_end, i1* %v_end
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i1*
	%_3 = load i1, i1* %v_end
	store i1 %_3, i1* %_1	%_4 = getelementptr i8, i8* %this, i32 8
	%_5 = bitcast i8* %_4 to i8**
	%_7 = load i8*, i8** %v_elem
	store i8* %_7, i8** %_5	%_8 = getelementptr i8, i8* %this, i32 16
	%_9 = bitcast i8* %_8 to i8**
	%_11 = load i8*, i8** %v_next
	store i8* %_11, i8** %_9
	ret i1 1
}
define i8* @List.Insert(i8* %this, i8* %.new_elem) {
	%new_elem = alloca i8*
	store i8* %.new_elem, i8** %new_elem
	%ret_val = alloca i1
	%aux03 = alloca i8*
	%aux02 = alloca i8*
	store i8* %this, i8** %aux03	%_5 = call i8* @calloc(i32 1, i32 25)
	%_6 = bitcast i8* %_5 to i8***
	%_7 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
	store i8** %_7,i8*** %_6
	store i8* %_5, i8** %aux02	%_16 = load i8*, i8** %aux02
	%_10 = bitcast i8* %_16 to i8***
	%_11 = load i8**, i8*** %_10
	%_12 = getelementptr i8*, i8** %_11, i32 1
	%_13 = load i8*, i8** %_12
	%_14 = bitcast i8* %_13 to i1 (i8*,i8*,i8*,i1)*
	%_17 = load i8*, i8** %new_elem
	%_18 = load i8*, i8** %aux03
	%_15 = call i1 %_14(i8* %_16, i8* %_17, i8* %_18, i1 0)
	store i1 %_15, i1* %ret_val	%_19 = load i8*, i8** %aux02

	ret i8* %_19
}
define i1 @List.SetNext(i8* %this, i8* %.v_next) {
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i8**
	%_3 = load i8*, i8** %v_next
	store i8* %_3, i8** %_1
	ret i1 1
}
define i8* @List.Delete(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e
	%my_head = alloca i8*
	%ret_val = alloca i1
	%aux05 = alloca i1
	%aux01 = alloca i8*
	%prev = alloca i8*
	%var_end = alloca i1
	%var_elem = alloca i8*
	%aux04 = alloca i32
	%nt = alloca i32
	store i8* %this, i8** %my_head	store i1 0, i1* %ret_val	%_12 = sub i32 0, 1	store i32 %_12, i32* %aux04	store i8* %this, i8** %aux01	store i8* %this, i8** %prev	%_16 = getelementptr i8, i8* %this, i32 24
	%_17 = bitcast i8* %_16 to i1*
	%_18 = load i1, i1* %_17
	store i1 %_18, i1* %var_end	%_20 = getelementptr i8, i8* %this, i32 8
	%_21 = bitcast i8* %_20 to i8**
	%_22 = load i8*, i8** %_21
	store i8* %_22, i8** %var_elem	br label %loop0

loop0:
	%_25 = load i1, i1* %var_end
	%_24 = xor i1 1, %_25	br label %andClause0

andClause0:
	br i1 %_24, label %andClause1, label %andClause3

andClause1:
	%_27 = load i1, i1* %ret_val
	%_26 = xor i1 1, %_27	br label %andClause2

andClause2:
	br label %andClause3

andClause3:
	%_23 = phi i1 [ 0, %andClause0 ], [ %_26, %andClause2 ]
	br i1 %_23, label %loop1, label %loop2

loop1:
	%_35 = load i8*, i8** %e
	%_29 = bitcast i8* %_35 to i8***
	%_30 = load i8**, i8*** %_29
	%_31 = getelementptr i8*, i8** %_30, i32 4
	%_32 = load i8*, i8** %_31
	%_33 = bitcast i8* %_32 to i1 (i8*,i8*)*
	%_36 = load i8*, i8** %var_elem
	%_34 = call i1 %_33(i8* %_35, i8* %_36)
	br i1 %_34, label %if0, label %if1

if0:
	store i1 1, i1* %ret_val	%_39 = load i32, i32* %aux04
	%_38 = icmp slt i32 %_39, 0	br i1 %_38, label %if3, label %if4

if3:
	%_48 = load i8*, i8** %aux01
	%_42 = bitcast i8* %_48 to i8***
	%_43 = load i8**, i8*** %_42
	%_44 = getelementptr i8*, i8** %_43, i32 8
	%_45 = load i8*, i8** %_44
	%_46 = bitcast i8* %_45 to i8* (i8*)*
	%_47 = call i8* %_46(i8* %_48)
	store i8* %_47, i8** %my_head	br label %if5

if4:
	%_49 = sub i32 0, 555	call void (i32) @print_int(i32 %_49)
	%_58 = load i8*, i8** %prev
	%_52 = bitcast i8* %_58 to i8***
	%_53 = load i8**, i8*** %_52
	%_54 = getelementptr i8*, i8** %_53, i32 3
	%_55 = load i8*, i8** %_54
	%_56 = bitcast i8* %_55 to i1 (i8*,i8*)*
	%_66 = load i8*, i8** %aux01
	%_60 = bitcast i8* %_66 to i8***
	%_61 = load i8**, i8*** %_60
	%_62 = getelementptr i8*, i8** %_61, i32 8
	%_63 = load i8*, i8** %_62
	%_64 = bitcast i8* %_63 to i8* (i8*)*
	%_65 = call i8* %_64(i8* %_66)
	%_57 = call i1 %_56(i8* %_58, i8* %_65)
	store i1 %_57, i1* %aux05	%_67 = sub i32 0, 555	call void (i32) @print_int(i32 %_67)
	br label %if5

if5:
	br label %if2

if1:
	store i32 0, i32* %nt	br label %if2

if2:
	%_70 = load i1, i1* %ret_val
	%_69 = xor i1 1, %_70	br i1 %_69, label %if6, label %if7

if6:
	%_72 = load i8*, i8** %aux01
	store i8* %_72, i8** %prev	%_81 = load i8*, i8** %aux01
	%_75 = bitcast i8* %_81 to i8***
	%_76 = load i8**, i8*** %_75
	%_77 = getelementptr i8*, i8** %_76, i32 8
	%_78 = load i8*, i8** %_77
	%_79 = bitcast i8* %_78 to i8* (i8*)*
	%_80 = call i8* %_79(i8* %_81)
	store i8* %_80, i8** %aux01	%_90 = load i8*, i8** %aux01
	%_84 = bitcast i8* %_90 to i8***
	%_85 = load i8**, i8*** %_84
	%_86 = getelementptr i8*, i8** %_85, i32 6
	%_87 = load i8*, i8** %_86
	%_88 = bitcast i8* %_87 to i1 (i8*)*
	%_89 = call i1 %_88(i8* %_90)
	store i1 %_89, i1* %var_end	%_99 = load i8*, i8** %aux01
	%_93 = bitcast i8* %_99 to i8***
	%_94 = load i8**, i8*** %_93
	%_95 = getelementptr i8*, i8** %_94, i32 7
	%_96 = load i8*, i8** %_95
	%_97 = bitcast i8* %_96 to i8* (i8*)*
	%_98 = call i8* %_97(i8* %_99)
	store i8* %_98, i8** %var_elem	store i32 1, i32* %aux04	br label %if8

if7:
	store i32 0, i32* %nt	br label %if8

if8:
	br label %loop0

loop2:
	%_102 = load i8*, i8** %my_head

	ret i8* %_102
}
define i32 @List.Search(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e
	%int_ret_val = alloca i32
	%aux01 = alloca i8*
	%var_elem = alloca i8*
	%var_end = alloca i1
	%nt = alloca i32
	store i32 0, i32* %int_ret_val	store i8* %this, i8** %aux01	%_8 = getelementptr i8, i8* %this, i32 24
	%_9 = bitcast i8* %_8 to i1*
	%_10 = load i1, i1* %_9
	store i1 %_10, i1* %var_end	%_12 = getelementptr i8, i8* %this, i32 8
	%_13 = bitcast i8* %_12 to i8**
	%_14 = load i8*, i8** %_13
	store i8* %_14, i8** %var_elem	br label %loop0

loop0:
	%_16 = load i1, i1* %var_end
	%_15 = xor i1 1, %_16	br i1 %_15, label %loop1, label %loop2

loop1:
	%_24 = load i8*, i8** %e
	%_18 = bitcast i8* %_24 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 4
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i1 (i8*,i8*)*
	%_25 = load i8*, i8** %var_elem
	%_23 = call i1 %_22(i8* %_24, i8* %_25)
	br i1 %_23, label %if0, label %if1

if0:
	store i32 1, i32* %int_ret_val	br label %if2

if1:
	store i32 0, i32* %nt	br label %if2

if2:
	%_36 = load i8*, i8** %aux01
	%_30 = bitcast i8* %_36 to i8***
	%_31 = load i8**, i8*** %_30
	%_32 = getelementptr i8*, i8** %_31, i32 8
	%_33 = load i8*, i8** %_32
	%_34 = bitcast i8* %_33 to i8* (i8*)*
	%_35 = call i8* %_34(i8* %_36)
	store i8* %_35, i8** %aux01	%_45 = load i8*, i8** %aux01
	%_39 = bitcast i8* %_45 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 6
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i1 (i8*)*
	%_44 = call i1 %_43(i8* %_45)
	store i1 %_44, i1* %var_end	%_54 = load i8*, i8** %aux01
	%_48 = bitcast i8* %_54 to i8***
	%_49 = load i8**, i8*** %_48
	%_50 = getelementptr i8*, i8** %_49, i32 7
	%_51 = load i8*, i8** %_50
	%_52 = bitcast i8* %_51 to i8* (i8*)*
	%_53 = call i8* %_52(i8* %_54)
	store i8* %_53, i8** %var_elem	br label %loop0

loop2:
	%_55 = load i32, i32* %int_ret_val

	ret i32 %_55
}
define i1 @List.GetEnd(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1

	ret i1 %_2
}
define i8* @List.GetElem(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1

	ret i8* %_2
}
define i8* @List.GetNext(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1

	ret i8* %_2
}
define i1 @List.Print(i8* %this) {
	%aux01 = alloca i8*
	%var_end = alloca i1
	%var_elem = alloca i8*
	store i8* %this, i8** %aux01	%_5 = getelementptr i8, i8* %this, i32 24
	%_6 = bitcast i8* %_5 to i1*
	%_7 = load i1, i1* %_6
	store i1 %_7, i1* %var_end	%_9 = getelementptr i8, i8* %this, i32 8
	%_10 = bitcast i8* %_9 to i8**
	%_11 = load i8*, i8** %_10
	store i8* %_11, i8** %var_elem	br label %loop0

loop0:
	%_13 = load i1, i1* %var_end
	%_12 = xor i1 1, %_13	br i1 %_12, label %loop1, label %loop2

loop1:
	%_21 = load i8*, i8** %var_elem
	%_15 = bitcast i8* %_21 to i8***
	%_16 = load i8**, i8*** %_15
	%_17 = getelementptr i8*, i8** %_16, i32 1
	%_18 = load i8*, i8** %_17
	%_19 = bitcast i8* %_18 to i32 (i8*)*
	%_20 = call i32 %_19(i8* %_21)
	call void (i32) @print_int(i32 %_20)
	%_30 = load i8*, i8** %aux01
	%_24 = bitcast i8* %_30 to i8***
	%_25 = load i8**, i8*** %_24
	%_26 = getelementptr i8*, i8** %_25, i32 8
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i8* (i8*)*
	%_29 = call i8* %_28(i8* %_30)
	store i8* %_29, i8** %aux01	%_39 = load i8*, i8** %aux01
	%_33 = bitcast i8* %_39 to i8***
	%_34 = load i8**, i8*** %_33
	%_35 = getelementptr i8*, i8** %_34, i32 6
	%_36 = load i8*, i8** %_35
	%_37 = bitcast i8* %_36 to i1 (i8*)*
	%_38 = call i1 %_37(i8* %_39)
	store i1 %_38, i1* %var_end	%_48 = load i8*, i8** %aux01
	%_42 = bitcast i8* %_48 to i8***
	%_43 = load i8**, i8*** %_42
	%_44 = getelementptr i8*, i8** %_43, i32 7
	%_45 = load i8*, i8** %_44
	%_46 = bitcast i8* %_45 to i8* (i8*)*
	%_47 = call i8* %_46(i8* %_48)
	store i8* %_47, i8** %var_elem	br label %loop0

loop2:

	ret i1 1
}
define i32 @LL.Start(i8* %this) {
	%head = alloca i8*
	%last_elem = alloca i8*
	%aux01 = alloca i1
	%el01 = alloca i8*
	%el02 = alloca i8*
	%el03 = alloca i8*
	%_7 = call i8* @calloc(i32 1, i32 25)
	%_8 = bitcast i8* %_7 to i8***
	%_9 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
	store i8** %_9,i8*** %_8
	store i8* %_7, i8** %last_elem	%_18 = load i8*, i8** %last_elem
	%_12 = bitcast i8* %_18 to i8***
	%_13 = load i8**, i8*** %_12
	%_14 = getelementptr i8*, i8** %_13, i32 0
	%_15 = load i8*, i8** %_14
	%_16 = bitcast i8* %_15 to i1 (i8*)*
	%_17 = call i1 %_16(i8* %_18)
	store i1 %_17, i1* %aux01	%_20 = load i8*, i8** %last_elem
	store i8* %_20, i8** %head	%_29 = load i8*, i8** %head
	%_23 = bitcast i8* %_29 to i8***
	%_24 = load i8**, i8*** %_23
	%_25 = getelementptr i8*, i8** %_24, i32 0
	%_26 = load i8*, i8** %_25
	%_27 = bitcast i8* %_26 to i1 (i8*)*
	%_28 = call i1 %_27(i8* %_29)
	store i1 %_28, i1* %aux01	%_38 = load i8*, i8** %head
	%_32 = bitcast i8* %_38 to i8***
	%_33 = load i8**, i8*** %_32
	%_34 = getelementptr i8*, i8** %_33, i32 9
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i1 (i8*)*
	%_37 = call i1 %_36(i8* %_38)
	store i1 %_37, i1* %aux01	%_40 = call i8* @calloc(i32 1, i32 17)
	%_41 = bitcast i8* %_40 to i8***
	%_42 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_42,i8*** %_41
	store i8* %_40, i8** %el01	%_51 = load i8*, i8** %el01
	%_45 = bitcast i8* %_51 to i8***
	%_46 = load i8**, i8*** %_45
	%_47 = getelementptr i8*, i8** %_46, i32 0
	%_48 = load i8*, i8** %_47
	%_49 = bitcast i8* %_48 to i1 (i8*,i32,i32,i1)*
	%_50 = call i1 %_49(i8* %_51, i32 25, i32 37000, i1 0)
	store i1 %_50, i1* %aux01	%_60 = load i8*, i8** %head
	%_54 = bitcast i8* %_60 to i8***
	%_55 = load i8**, i8*** %_54
	%_56 = getelementptr i8*, i8** %_55, i32 2
	%_57 = load i8*, i8** %_56
	%_58 = bitcast i8* %_57 to i8* (i8*,i8*)*
	%_61 = load i8*, i8** %el01
	%_59 = call i8* %_58(i8* %_60, i8* %_61)
	store i8* %_59, i8** %head	%_70 = load i8*, i8** %head
	%_64 = bitcast i8* %_70 to i8***
	%_65 = load i8**, i8*** %_64
	%_66 = getelementptr i8*, i8** %_65, i32 9
	%_67 = load i8*, i8** %_66
	%_68 = bitcast i8* %_67 to i1 (i8*)*
	%_69 = call i1 %_68(i8* %_70)
	store i1 %_69, i1* %aux01	call void (i32) @print_int(i32 10000000)
	%_72 = call i8* @calloc(i32 1, i32 17)
	%_73 = bitcast i8* %_72 to i8***
	%_74 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_74,i8*** %_73
	store i8* %_72, i8** %el01	%_83 = load i8*, i8** %el01
	%_77 = bitcast i8* %_83 to i8***
	%_78 = load i8**, i8*** %_77
	%_79 = getelementptr i8*, i8** %_78, i32 0
	%_80 = load i8*, i8** %_79
	%_81 = bitcast i8* %_80 to i1 (i8*,i32,i32,i1)*
	%_82 = call i1 %_81(i8* %_83, i32 39, i32 42000, i1 1)
	store i1 %_82, i1* %aux01	%_85 = load i8*, i8** %el01
	store i8* %_85, i8** %el02	%_94 = load i8*, i8** %head
	%_88 = bitcast i8* %_94 to i8***
	%_89 = load i8**, i8*** %_88
	%_90 = getelementptr i8*, i8** %_89, i32 2
	%_91 = load i8*, i8** %_90
	%_92 = bitcast i8* %_91 to i8* (i8*,i8*)*
	%_95 = load i8*, i8** %el01
	%_93 = call i8* %_92(i8* %_94, i8* %_95)
	store i8* %_93, i8** %head	%_104 = load i8*, i8** %head
	%_98 = bitcast i8* %_104 to i8***
	%_99 = load i8**, i8*** %_98
	%_100 = getelementptr i8*, i8** %_99, i32 9
	%_101 = load i8*, i8** %_100
	%_102 = bitcast i8* %_101 to i1 (i8*)*
	%_103 = call i1 %_102(i8* %_104)
	store i1 %_103, i1* %aux01	call void (i32) @print_int(i32 10000000)
	%_106 = call i8* @calloc(i32 1, i32 17)
	%_107 = bitcast i8* %_106 to i8***
	%_108 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_108,i8*** %_107
	store i8* %_106, i8** %el01	%_117 = load i8*, i8** %el01
	%_111 = bitcast i8* %_117 to i8***
	%_112 = load i8**, i8*** %_111
	%_113 = getelementptr i8*, i8** %_112, i32 0
	%_114 = load i8*, i8** %_113
	%_115 = bitcast i8* %_114 to i1 (i8*,i32,i32,i1)*
	%_116 = call i1 %_115(i8* %_117, i32 22, i32 34000, i1 0)
	store i1 %_116, i1* %aux01	%_126 = load i8*, i8** %head
	%_120 = bitcast i8* %_126 to i8***
	%_121 = load i8**, i8*** %_120
	%_122 = getelementptr i8*, i8** %_121, i32 2
	%_123 = load i8*, i8** %_122
	%_124 = bitcast i8* %_123 to i8* (i8*,i8*)*
	%_127 = load i8*, i8** %el01
	%_125 = call i8* %_124(i8* %_126, i8* %_127)
	store i8* %_125, i8** %head	%_136 = load i8*, i8** %head
	%_130 = bitcast i8* %_136 to i8***
	%_131 = load i8**, i8*** %_130
	%_132 = getelementptr i8*, i8** %_131, i32 9
	%_133 = load i8*, i8** %_132
	%_134 = bitcast i8* %_133 to i1 (i8*)*
	%_135 = call i1 %_134(i8* %_136)
	store i1 %_135, i1* %aux01	%_138 = call i8* @calloc(i32 1, i32 17)
	%_139 = bitcast i8* %_138 to i8***
	%_140 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_140,i8*** %_139
	store i8* %_138, i8** %el03	%_149 = load i8*, i8** %el03
	%_143 = bitcast i8* %_149 to i8***
	%_144 = load i8**, i8*** %_143
	%_145 = getelementptr i8*, i8** %_144, i32 0
	%_146 = load i8*, i8** %_145
	%_147 = bitcast i8* %_146 to i1 (i8*,i32,i32,i1)*
	%_148 = call i1 %_147(i8* %_149, i32 27, i32 34000, i1 0)
	store i1 %_148, i1* %aux01	%_157 = load i8*, i8** %head
	%_151 = bitcast i8* %_157 to i8***
	%_152 = load i8**, i8*** %_151
	%_153 = getelementptr i8*, i8** %_152, i32 5
	%_154 = load i8*, i8** %_153
	%_155 = bitcast i8* %_154 to i32 (i8*,i8*)*
	%_158 = load i8*, i8** %el02
	%_156 = call i32 %_155(i8* %_157, i8* %_158)
	call void (i32) @print_int(i32 %_156)
	%_166 = load i8*, i8** %head
	%_160 = bitcast i8* %_166 to i8***
	%_161 = load i8**, i8*** %_160
	%_162 = getelementptr i8*, i8** %_161, i32 5
	%_163 = load i8*, i8** %_162
	%_164 = bitcast i8* %_163 to i32 (i8*,i8*)*
	%_167 = load i8*, i8** %el03
	%_165 = call i32 %_164(i8* %_166, i8* %_167)
	call void (i32) @print_int(i32 %_165)
	call void (i32) @print_int(i32 10000000)
	%_169 = call i8* @calloc(i32 1, i32 17)
	%_170 = bitcast i8* %_169 to i8***
	%_171 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_171,i8*** %_170
	store i8* %_169, i8** %el01	%_180 = load i8*, i8** %el01
	%_174 = bitcast i8* %_180 to i8***
	%_175 = load i8**, i8*** %_174
	%_176 = getelementptr i8*, i8** %_175, i32 0
	%_177 = load i8*, i8** %_176
	%_178 = bitcast i8* %_177 to i1 (i8*,i32,i32,i1)*
	%_179 = call i1 %_178(i8* %_180, i32 28, i32 35000, i1 0)
	store i1 %_179, i1* %aux01	%_189 = load i8*, i8** %head
	%_183 = bitcast i8* %_189 to i8***
	%_184 = load i8**, i8*** %_183
	%_185 = getelementptr i8*, i8** %_184, i32 2
	%_186 = load i8*, i8** %_185
	%_187 = bitcast i8* %_186 to i8* (i8*,i8*)*
	%_190 = load i8*, i8** %el01
	%_188 = call i8* %_187(i8* %_189, i8* %_190)
	store i8* %_188, i8** %head	%_199 = load i8*, i8** %head
	%_193 = bitcast i8* %_199 to i8***
	%_194 = load i8**, i8*** %_193
	%_195 = getelementptr i8*, i8** %_194, i32 9
	%_196 = load i8*, i8** %_195
	%_197 = bitcast i8* %_196 to i1 (i8*)*
	%_198 = call i1 %_197(i8* %_199)
	store i1 %_198, i1* %aux01	call void (i32) @print_int(i32 2220000)
	%_208 = load i8*, i8** %head
	%_202 = bitcast i8* %_208 to i8***
	%_203 = load i8**, i8*** %_202
	%_204 = getelementptr i8*, i8** %_203, i32 4
	%_205 = load i8*, i8** %_204
	%_206 = bitcast i8* %_205 to i8* (i8*,i8*)*
	%_209 = load i8*, i8** %el02
	%_207 = call i8* %_206(i8* %_208, i8* %_209)
	store i8* %_207, i8** %head	%_218 = load i8*, i8** %head
	%_212 = bitcast i8* %_218 to i8***
	%_213 = load i8**, i8*** %_212
	%_214 = getelementptr i8*, i8** %_213, i32 9
	%_215 = load i8*, i8** %_214
	%_216 = bitcast i8* %_215 to i1 (i8*)*
	%_217 = call i1 %_216(i8* %_218)
	store i1 %_217, i1* %aux01	call void (i32) @print_int(i32 33300000)
	%_227 = load i8*, i8** %head
	%_221 = bitcast i8* %_227 to i8***
	%_222 = load i8**, i8*** %_221
	%_223 = getelementptr i8*, i8** %_222, i32 4
	%_224 = load i8*, i8** %_223
	%_225 = bitcast i8* %_224 to i8* (i8*,i8*)*
	%_228 = load i8*, i8** %el01
	%_226 = call i8* %_225(i8* %_227, i8* %_228)
	store i8* %_226, i8** %head	%_237 = load i8*, i8** %head
	%_231 = bitcast i8* %_237 to i8***
	%_232 = load i8**, i8*** %_231
	%_233 = getelementptr i8*, i8** %_232, i32 9
	%_234 = load i8*, i8** %_233
	%_235 = bitcast i8* %_234 to i1 (i8*)*
	%_236 = call i1 %_235(i8* %_237)
	store i1 %_236, i1* %aux01	call void (i32) @print_int(i32 44440000)

	ret i32 0
}
