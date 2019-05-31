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
%_0 = load i8*, i8** %_7
%_1 = bitcast i8* %_0 to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 0
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i32 (i8*)*
%_6 = call i32 %_5(i8* %_0)

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
%_2 = getelementptr i8, i8* %this, i32 12
%_3 = bitcast i8* %_2 to i32*
%_4 = getelementptr i8, i8* %this, i32 16
%_5 = bitcast i8* %_4 to i1*
%_6 = load i1, i1* true
	ret i1 %_6
}
define i32 @Element.GetAge(i8* %this) {
%_1 = getelementptr i8, i8* %this, i32 8
%_2 = bitcast i8* %_1 to i32*
%_0 = load i32, i32* %_2
	ret i32 %_0
}
define i32 @Element.GetSalary(i8* %this) {
%_1 = getelementptr i8, i8* %this, i32 12
%_2 = bitcast i8* %_1 to i32*
%_0 = load i32, i32* %_2
	ret i32 %_0
}
define i1 @Element.GetMarried(i8* %this) {
%_1 = getelementptr i8, i8* %this, i32 16
%_2 = bitcast i8* %_1 to i1*
%_0 = load i1, i1* %_2
	ret i1 %_0
}
define i1 @Element.Equal(i8* %this, i8* %.other) {
	%other = alloca i8*
	store i8* %.other, i8** %other
	%ret_val = alloca i1
	%aux01 = alloca i32
	%aux02 = alloca i32
	%nt = alloca i32
%_0 = load i8*, i8** %other
%_1 = bitcast i8* %_0 to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 1
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i32 (i8*)*
%_6 = call i32 %_5(i8* %_0)
%_9 = bitcast i8* %this to i8***
%_10 = load i8**, i8*** %_9
%_11 = getelementptr i8*, i8** %_10, i32 5
%_12 = load i8*, i8** %_11
%_13 = bitcast i8* %_12 to i1 (i8*,i32,i32)*
%_15 = getelementptr i8, i8* %this, i32 8
%_16 = bitcast i8* %_15 to i32*
%_14 = call i1 %_13(i8* %this, i32 %aux01, i32 %_16)
%_7 = xor i1 1, %_14%_17 = load i8*, i8** %other
%_18 = bitcast i8* %_17 to i8***
%_19 = load i8**, i8*** %_18
%_20 = getelementptr i8*, i8** %_19, i32 2
%_21 = load i8*, i8** %_20
%_22 = bitcast i8* %_21 to i32 (i8*)*
%_23 = call i32 %_22(i8* %_17)
%_26 = bitcast i8* %this to i8***
%_27 = load i8**, i8*** %_26
%_28 = getelementptr i8*, i8** %_27, i32 5
%_29 = load i8*, i8** %_28
%_30 = bitcast i8* %_29 to i1 (i8*,i32,i32)*
%_32 = getelementptr i8, i8* %this, i32 12
%_33 = bitcast i8* %_32 to i32*
%_31 = call i1 %_30(i8* %this, i32 %aux02, i32 %_33)
%_24 = xor i1 1, %_31%_34 = getelementptr i8, i8* %this, i32 16
%_35 = bitcast i8* %_34 to i1*
%_37 = load i8*, i8** %other
%_38 = bitcast i8* %_37 to i8***
%_39 = load i8**, i8*** %_38
%_40 = getelementptr i8*, i8** %_39, i32 3
%_41 = load i8*, i8** %_40
%_42 = bitcast i8* %_41 to i1 (i8*)*
%_43 = call i1 %_42(i8* %_37)
%_36 = xor i1 1, %_43%_44 = load i8*, i8** %other
%_45 = bitcast i8* %_44 to i8***
%_46 = load i8**, i8*** %_45
%_47 = getelementptr i8*, i8** %_46, i32 3
%_48 = load i8*, i8** %_47
%_49 = bitcast i8* %_48 to i1 (i8*)*
%_50 = call i1 %_49(i8* %_44)
%_51 = load i1, i1* %ret_val
	ret i1 %_51
}
define i1 @Element.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%retval = alloca i1
	%aux02 = alloca i32
%_0 = xor i1 1, null%_1 = load i1, i1* %retval
	ret i1 %_1
}
define i1 @List.Init(i8* %this) {
%_0 = getelementptr i8, i8* %this, i32 24
%_1 = bitcast i8* %_0 to i1*
%_2 = load i1, i1* true
	ret i1 %_2
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
%_2 = getelementptr i8, i8* %this, i32 8
%_3 = bitcast i8* %_2 to i8**
%_4 = getelementptr i8, i8* %this, i32 16
%_5 = bitcast i8* %_4 to i8**
%_6 = load i1, i1* true
	ret i1 %_6
}
define i8* @List.Insert(i8* %this, i8* %.new_elem) {
	%new_elem = alloca i8*
	store i8* %.new_elem, i8** %new_elem
	%ret_val = alloca i1
	%aux03 = alloca i8*
	%aux02 = alloca i8*
%_0 = call i8* @calloc(i32 1, i32 25)
%_1 = bitcast i8* %_0 to i8***
%_2 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
store i8** %_2,i8*** %_1
%_3 = load i8*, i8** %aux02
%_4 = bitcast i8* %_3 to i8***
%_5 = load i8**, i8*** %_4
%_6 = getelementptr i8*, i8** %_5, i32 1
%_7 = load i8*, i8** %_6
%_8 = bitcast i8* %_7 to i1 (i8*,i8*,i8*,i1)*
%_9 = call i1 %_8(i8* %_3, i8* %new_elem, i8* %aux03, i1 false)
%_10 = load i8*, i8** %aux02
	ret i8* %_10
}
define i1 @List.SetNext(i8* %this, i8* %.v_next) {
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
%_0 = getelementptr i8, i8* %this, i32 16
%_1 = bitcast i8* %_0 to i8**
%_2 = load i1, i1* true
	ret i1 %_2
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
%_0 = getelementptr i8, i8* %this, i32 24
%_1 = bitcast i8* %_0 to i1*
%_2 = getelementptr i8, i8* %this, i32 8
%_3 = bitcast i8* %_2 to i8**
%_4 = xor i1 1, %var_end%_5 = xor i1 1, %ret_val%_6 = load i8*, i8** %e
%_7 = bitcast i8* %_6 to i8***
%_8 = load i8**, i8*** %_7
%_9 = getelementptr i8*, i8** %_8, i32 4
%_10 = load i8*, i8** %_9
%_11 = bitcast i8* %_10 to i1 (i8*,i8*)*
%_12 = call i1 %_11(i8* %_6, i8* %var_elem)
%_13 = load i8*, i8** %aux01
%_14 = bitcast i8* %_13 to i8***
%_15 = load i8**, i8*** %_14
%_16 = getelementptr i8*, i8** %_15, i32 8
%_17 = load i8*, i8** %_16
%_18 = bitcast i8* %_17 to i8* (i8*)*
%_19 = call i8* %_18(i8* %_13)
%_20 = load i8*, i8** %prev
%_21 = bitcast i8* %_20 to i8***
%_22 = load i8**, i8*** %_21
%_23 = getelementptr i8*, i8** %_22, i32 3
%_24 = load i8*, i8** %_23
%_25 = bitcast i8* %_24 to i1 (i8*,i8*)*
%_27 = load i8*, i8** %aux01
%_28 = bitcast i8* %_27 to i8***
%_29 = load i8**, i8*** %_28
%_30 = getelementptr i8*, i8** %_29, i32 8
%_31 = load i8*, i8** %_30
%_32 = bitcast i8* %_31 to i8* (i8*)*
%_33 = call i8* %_32(i8* %_27)
%_26 = call i1 %_25(i8* %_20, i8* %_33)
%_34 = xor i1 1, %ret_val%_35 = load i8*, i8** %aux01
%_36 = bitcast i8* %_35 to i8***
%_37 = load i8**, i8*** %_36
%_38 = getelementptr i8*, i8** %_37, i32 8
%_39 = load i8*, i8** %_38
%_40 = bitcast i8* %_39 to i8* (i8*)*
%_41 = call i8* %_40(i8* %_35)
%_42 = load i8*, i8** %aux01
%_43 = bitcast i8* %_42 to i8***
%_44 = load i8**, i8*** %_43
%_45 = getelementptr i8*, i8** %_44, i32 6
%_46 = load i8*, i8** %_45
%_47 = bitcast i8* %_46 to i1 (i8*)*
%_48 = call i1 %_47(i8* %_42)
%_49 = load i8*, i8** %aux01
%_50 = bitcast i8* %_49 to i8***
%_51 = load i8**, i8*** %_50
%_52 = getelementptr i8*, i8** %_51, i32 7
%_53 = load i8*, i8** %_52
%_54 = bitcast i8* %_53 to i8* (i8*)*
%_55 = call i8* %_54(i8* %_49)
%_56 = load i8*, i8** %my_head
	ret i8* %_56
}
define i32 @List.Search(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e
	%int_ret_val = alloca i32
	%aux01 = alloca i8*
	%var_elem = alloca i8*
	%var_end = alloca i1
	%nt = alloca i32
%_0 = getelementptr i8, i8* %this, i32 24
%_1 = bitcast i8* %_0 to i1*
%_2 = getelementptr i8, i8* %this, i32 8
%_3 = bitcast i8* %_2 to i8**
%_4 = xor i1 1, %var_end%_5 = load i8*, i8** %e
%_6 = bitcast i8* %_5 to i8***
%_7 = load i8**, i8*** %_6
%_8 = getelementptr i8*, i8** %_7, i32 4
%_9 = load i8*, i8** %_8
%_10 = bitcast i8* %_9 to i1 (i8*,i8*)*
%_11 = call i1 %_10(i8* %_5, i8* %var_elem)
%_12 = load i8*, i8** %aux01
%_13 = bitcast i8* %_12 to i8***
%_14 = load i8**, i8*** %_13
%_15 = getelementptr i8*, i8** %_14, i32 8
%_16 = load i8*, i8** %_15
%_17 = bitcast i8* %_16 to i8* (i8*)*
%_18 = call i8* %_17(i8* %_12)
%_19 = load i8*, i8** %aux01
%_20 = bitcast i8* %_19 to i8***
%_21 = load i8**, i8*** %_20
%_22 = getelementptr i8*, i8** %_21, i32 6
%_23 = load i8*, i8** %_22
%_24 = bitcast i8* %_23 to i1 (i8*)*
%_25 = call i1 %_24(i8* %_19)
%_26 = load i8*, i8** %aux01
%_27 = bitcast i8* %_26 to i8***
%_28 = load i8**, i8*** %_27
%_29 = getelementptr i8*, i8** %_28, i32 7
%_30 = load i8*, i8** %_29
%_31 = bitcast i8* %_30 to i8* (i8*)*
%_32 = call i8* %_31(i8* %_26)
%_33 = load i32, i32* %int_ret_val
	ret i32 %_33
}
define i1 @List.GetEnd(i8* %this) {
%_1 = getelementptr i8, i8* %this, i32 24
%_2 = bitcast i8* %_1 to i1*
%_0 = load i1, i1* %_2
	ret i1 %_0
}
define i8* @List.GetElem(i8* %this) {
%_1 = getelementptr i8, i8* %this, i32 8
%_2 = bitcast i8* %_1 to i8**
%_0 = load i8*, i8** %_2
	ret i8* %_0
}
define i8* @List.GetNext(i8* %this) {
%_1 = getelementptr i8, i8* %this, i32 16
%_2 = bitcast i8* %_1 to i8**
%_0 = load i8*, i8** %_2
	ret i8* %_0
}
define i1 @List.Print(i8* %this) {
	%aux01 = alloca i8*
	%var_end = alloca i1
	%var_elem = alloca i8*
%_0 = getelementptr i8, i8* %this, i32 24
%_1 = bitcast i8* %_0 to i1*
%_2 = getelementptr i8, i8* %this, i32 8
%_3 = bitcast i8* %_2 to i8**
%_4 = xor i1 1, %var_end%_5 = load i8*, i8** %var_elem
%_6 = bitcast i8* %_5 to i8***
%_7 = load i8**, i8*** %_6
%_8 = getelementptr i8*, i8** %_7, i32 1
%_9 = load i8*, i8** %_8
%_10 = bitcast i8* %_9 to i32 (i8*)*
%_11 = call i32 %_10(i8* %_5)
%_12 = load i8*, i8** %aux01
%_13 = bitcast i8* %_12 to i8***
%_14 = load i8**, i8*** %_13
%_15 = getelementptr i8*, i8** %_14, i32 8
%_16 = load i8*, i8** %_15
%_17 = bitcast i8* %_16 to i8* (i8*)*
%_18 = call i8* %_17(i8* %_12)
%_19 = load i8*, i8** %aux01
%_20 = bitcast i8* %_19 to i8***
%_21 = load i8**, i8*** %_20
%_22 = getelementptr i8*, i8** %_21, i32 6
%_23 = load i8*, i8** %_22
%_24 = bitcast i8* %_23 to i1 (i8*)*
%_25 = call i1 %_24(i8* %_19)
%_26 = load i8*, i8** %aux01
%_27 = bitcast i8* %_26 to i8***
%_28 = load i8**, i8*** %_27
%_29 = getelementptr i8*, i8** %_28, i32 7
%_30 = load i8*, i8** %_29
%_31 = bitcast i8* %_30 to i8* (i8*)*
%_32 = call i8* %_31(i8* %_26)
%_33 = load i1, i1* true
	ret i1 %_33
}
define i32 @LL.Start(i8* %this) {
	%head = alloca i8*
	%last_elem = alloca i8*
	%aux01 = alloca i1
	%el01 = alloca i8*
	%el02 = alloca i8*
	%el03 = alloca i8*
%_0 = call i8* @calloc(i32 1, i32 25)
%_1 = bitcast i8* %_0 to i8***
%_2 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
store i8** %_2,i8*** %_1
%_3 = load i8*, i8** %last_elem
%_4 = bitcast i8* %_3 to i8***
%_5 = load i8**, i8*** %_4
%_6 = getelementptr i8*, i8** %_5, i32 0
%_7 = load i8*, i8** %_6
%_8 = bitcast i8* %_7 to i1 (i8*)*
%_9 = call i1 %_8(i8* %_3)
%_10 = load i8*, i8** %head
%_11 = bitcast i8* %_10 to i8***
%_12 = load i8**, i8*** %_11
%_13 = getelementptr i8*, i8** %_12, i32 0
%_14 = load i8*, i8** %_13
%_15 = bitcast i8* %_14 to i1 (i8*)*
%_16 = call i1 %_15(i8* %_10)
%_17 = load i8*, i8** %head
%_18 = bitcast i8* %_17 to i8***
%_19 = load i8**, i8*** %_18
%_20 = getelementptr i8*, i8** %_19, i32 9
%_21 = load i8*, i8** %_20
%_22 = bitcast i8* %_21 to i1 (i8*)*
%_23 = call i1 %_22(i8* %_17)
%_24 = call i8* @calloc(i32 1, i32 17)
%_25 = bitcast i8* %_24 to i8***
%_26 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
store i8** %_26,i8*** %_25
%_27 = load i8*, i8** %el01
%_28 = bitcast i8* %_27 to i8***
%_29 = load i8**, i8*** %_28
%_30 = getelementptr i8*, i8** %_29, i32 0
%_31 = load i8*, i8** %_30
%_32 = bitcast i8* %_31 to i1 (i8*,i32,i32,i1)*
%_33 = call i1 %_32(i8* %_27, i32 25, i32 37000, i1 false)
%_34 = load i8*, i8** %head
%_35 = bitcast i8* %_34 to i8***
%_36 = load i8**, i8*** %_35
%_37 = getelementptr i8*, i8** %_36, i32 2
%_38 = load i8*, i8** %_37
%_39 = bitcast i8* %_38 to i8* (i8*,i8*)*
%_40 = call i8* %_39(i8* %_34, i8* %el01)
%_41 = load i8*, i8** %head
%_42 = bitcast i8* %_41 to i8***
%_43 = load i8**, i8*** %_42
%_44 = getelementptr i8*, i8** %_43, i32 9
%_45 = load i8*, i8** %_44
%_46 = bitcast i8* %_45 to i1 (i8*)*
%_47 = call i1 %_46(i8* %_41)
%_48 = call i8* @calloc(i32 1, i32 17)
%_49 = bitcast i8* %_48 to i8***
%_50 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
store i8** %_50,i8*** %_49
%_51 = load i8*, i8** %el01
%_52 = bitcast i8* %_51 to i8***
%_53 = load i8**, i8*** %_52
%_54 = getelementptr i8*, i8** %_53, i32 0
%_55 = load i8*, i8** %_54
%_56 = bitcast i8* %_55 to i1 (i8*,i32,i32,i1)*
%_57 = call i1 %_56(i8* %_51, i32 39, i32 42000, i1 true)
%_58 = load i8*, i8** %head
%_59 = bitcast i8* %_58 to i8***
%_60 = load i8**, i8*** %_59
%_61 = getelementptr i8*, i8** %_60, i32 2
%_62 = load i8*, i8** %_61
%_63 = bitcast i8* %_62 to i8* (i8*,i8*)*
%_64 = call i8* %_63(i8* %_58, i8* %el01)
%_65 = load i8*, i8** %head
%_66 = bitcast i8* %_65 to i8***
%_67 = load i8**, i8*** %_66
%_68 = getelementptr i8*, i8** %_67, i32 9
%_69 = load i8*, i8** %_68
%_70 = bitcast i8* %_69 to i1 (i8*)*
%_71 = call i1 %_70(i8* %_65)
%_72 = call i8* @calloc(i32 1, i32 17)
%_73 = bitcast i8* %_72 to i8***
%_74 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
store i8** %_74,i8*** %_73
%_75 = load i8*, i8** %el01
%_76 = bitcast i8* %_75 to i8***
%_77 = load i8**, i8*** %_76
%_78 = getelementptr i8*, i8** %_77, i32 0
%_79 = load i8*, i8** %_78
%_80 = bitcast i8* %_79 to i1 (i8*,i32,i32,i1)*
%_81 = call i1 %_80(i8* %_75, i32 22, i32 34000, i1 false)
%_82 = load i8*, i8** %head
%_83 = bitcast i8* %_82 to i8***
%_84 = load i8**, i8*** %_83
%_85 = getelementptr i8*, i8** %_84, i32 2
%_86 = load i8*, i8** %_85
%_87 = bitcast i8* %_86 to i8* (i8*,i8*)*
%_88 = call i8* %_87(i8* %_82, i8* %el01)
%_89 = load i8*, i8** %head
%_90 = bitcast i8* %_89 to i8***
%_91 = load i8**, i8*** %_90
%_92 = getelementptr i8*, i8** %_91, i32 9
%_93 = load i8*, i8** %_92
%_94 = bitcast i8* %_93 to i1 (i8*)*
%_95 = call i1 %_94(i8* %_89)
%_96 = call i8* @calloc(i32 1, i32 17)
%_97 = bitcast i8* %_96 to i8***
%_98 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
store i8** %_98,i8*** %_97
%_99 = load i8*, i8** %el03
%_100 = bitcast i8* %_99 to i8***
%_101 = load i8**, i8*** %_100
%_102 = getelementptr i8*, i8** %_101, i32 0
%_103 = load i8*, i8** %_102
%_104 = bitcast i8* %_103 to i1 (i8*,i32,i32,i1)*
%_105 = call i1 %_104(i8* %_99, i32 27, i32 34000, i1 false)
%_106 = load i8*, i8** %head
%_107 = bitcast i8* %_106 to i8***
%_108 = load i8**, i8*** %_107
%_109 = getelementptr i8*, i8** %_108, i32 5
%_110 = load i8*, i8** %_109
%_111 = bitcast i8* %_110 to i32 (i8*,i8*)*
%_112 = call i32 %_111(i8* %_106, i8* %el02)
%_113 = load i8*, i8** %head
%_114 = bitcast i8* %_113 to i8***
%_115 = load i8**, i8*** %_114
%_116 = getelementptr i8*, i8** %_115, i32 5
%_117 = load i8*, i8** %_116
%_118 = bitcast i8* %_117 to i32 (i8*,i8*)*
%_119 = call i32 %_118(i8* %_113, i8* %el03)
%_120 = call i8* @calloc(i32 1, i32 17)
%_121 = bitcast i8* %_120 to i8***
%_122 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
store i8** %_122,i8*** %_121
%_123 = load i8*, i8** %el01
%_124 = bitcast i8* %_123 to i8***
%_125 = load i8**, i8*** %_124
%_126 = getelementptr i8*, i8** %_125, i32 0
%_127 = load i8*, i8** %_126
%_128 = bitcast i8* %_127 to i1 (i8*,i32,i32,i1)*
%_129 = call i1 %_128(i8* %_123, i32 28, i32 35000, i1 false)
%_130 = load i8*, i8** %head
%_131 = bitcast i8* %_130 to i8***
%_132 = load i8**, i8*** %_131
%_133 = getelementptr i8*, i8** %_132, i32 2
%_134 = load i8*, i8** %_133
%_135 = bitcast i8* %_134 to i8* (i8*,i8*)*
%_136 = call i8* %_135(i8* %_130, i8* %el01)
%_137 = load i8*, i8** %head
%_138 = bitcast i8* %_137 to i8***
%_139 = load i8**, i8*** %_138
%_140 = getelementptr i8*, i8** %_139, i32 9
%_141 = load i8*, i8** %_140
%_142 = bitcast i8* %_141 to i1 (i8*)*
%_143 = call i1 %_142(i8* %_137)
%_144 = load i8*, i8** %head
%_145 = bitcast i8* %_144 to i8***
%_146 = load i8**, i8*** %_145
%_147 = getelementptr i8*, i8** %_146, i32 4
%_148 = load i8*, i8** %_147
%_149 = bitcast i8* %_148 to i8* (i8*,i8*)*
%_150 = call i8* %_149(i8* %_144, i8* %el02)
%_151 = load i8*, i8** %head
%_152 = bitcast i8* %_151 to i8***
%_153 = load i8**, i8*** %_152
%_154 = getelementptr i8*, i8** %_153, i32 9
%_155 = load i8*, i8** %_154
%_156 = bitcast i8* %_155 to i1 (i8*)*
%_157 = call i1 %_156(i8* %_151)
%_158 = load i8*, i8** %head
%_159 = bitcast i8* %_158 to i8***
%_160 = load i8**, i8*** %_159
%_161 = getelementptr i8*, i8** %_160, i32 4
%_162 = load i8*, i8** %_161
%_163 = bitcast i8* %_162 to i8* (i8*,i8*)*
%_164 = call i8* %_163(i8* %_158, i8* %el01)
%_165 = load i8*, i8** %head
%_166 = bitcast i8* %_165 to i8***
%_167 = load i8**, i8*** %_166
%_168 = getelementptr i8*, i8** %_167, i32 9
%_169 = load i8*, i8** %_168
%_170 = bitcast i8* %_169 to i1 (i8*)*
%_171 = call i1 %_170(i8* %_165)
%_172 = load i32, i32* 0
	ret i32 %_172
}
