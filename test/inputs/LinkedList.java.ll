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
%_0 = call i8* @calloc(i32 1, i32 8)
%_1 = bitcast i8* %_0 to i8***
%_2 = getelementptr [1 x i8*], [1 x i8*]* @.LL_vtable, i32 0, i32 0
store i8** %_2,i8*** %_1

	ret i32 0
}
define i1 @Element.Init(i8* %this, i32 %.v_Age, i32 %.v_Salary, i1 %.v_Married) {
	%v_Age = alloca i32
	store i32 %.v_Age, i32* %v_Age
	%v_Salary = alloca i32
	store i32 %.v_Salary, i32* %v_Salary
	%v_Married = alloca i1
	store i1 %.v_Married, i1* %v_Married
%_0 = load i1, i1* true
	ret i1 %_0
}
define i32 @Element.GetAge(i8* %this) {
%_0 = load i32, i32* Age
	ret i32 %_0
}
define i32 @Element.GetSalary(i8* %this) {
%_0 = load i32, i32* Salary
	ret i32 %_0
}
define i1 @Element.GetMarried(i8* %this) {
%_0 = load i1, i1* Married
	ret i1 %_0
}
define i1 @Element.Equal(i8* %this, i8* %.other) {
	%other = alloca i8*
	store i8* %.other, i8** %other
	%ret_val = alloca i1
	%aux01 = alloca i32
	%aux02 = alloca i32
	%nt = alloca i32
%_0 = xor i1 1, null%_1 = xor i1 1, null%_2 = xor i1 1, null%_3 = load i1, i1* ret_val
	ret i1 %_3
}
define i1 @Element.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%retval = alloca i1
	%aux02 = alloca i32
%_0 = xor i1 1, null%_1 = load i1, i1* retval
	ret i1 %_1
}
define i1 @List.Init(i8* %this) {
%_0 = load i1, i1* true
	ret i1 %_0
}
define i1 @List.InitNew(i8* %this, i8* %.v_elem, i8* %.v_next, i1 %.v_end) {
	%v_elem = alloca i8*
	store i8* %.v_elem, i8** %v_elem
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
	%v_end = alloca i1
	store i1 %.v_end, i1* %v_end
%_0 = load i1, i1* true
	ret i1 %_0
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
%_3 = load i8*, i8** aux02
	ret i8* %_3
}
define i1 @List.SetNext(i8* %this, i8* %.v_next) {
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
%_0 = load i1, i1* true
	ret i1 %_0
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
%_0 = xor i1 1, var_end%_1 = xor i1 1, ret_val%_2 = xor i1 1, ret_val%_3 = load i8*, i8** my_head
	ret i8* %_3
}
define i32 @List.Search(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e
	%int_ret_val = alloca i32
	%aux01 = alloca i8*
	%var_elem = alloca i8*
	%var_end = alloca i1
	%nt = alloca i32
%_0 = xor i1 1, var_end%_1 = load i32, i32* int_ret_val
	ret i32 %_1
}
define i1 @List.GetEnd(i8* %this) {
%_0 = load i1, i1* end
	ret i1 %_0
}
define i8* @List.GetElem(i8* %this) {
%_0 = load i8*, i8** elem
	ret i8* %_0
}
define i8* @List.GetNext(i8* %this) {
%_0 = load i8*, i8** next
	ret i8* %_0
}
define i1 @List.Print(i8* %this) {
	%aux01 = alloca i8*
	%var_end = alloca i1
	%var_elem = alloca i8*
%_0 = xor i1 1, var_end%_1 = load i1, i1* true
	ret i1 %_1
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
%_3 = call i8* @calloc(i32 1, i32 17)
%_4 = bitcast i8* %_3 to i8***
%_5 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
store i8** %_5,i8*** %_4
%_6 = call i8* @calloc(i32 1, i32 17)
%_7 = bitcast i8* %_6 to i8***
%_8 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
store i8** %_8,i8*** %_7
%_9 = call i8* @calloc(i32 1, i32 17)
%_10 = bitcast i8* %_9 to i8***
%_11 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
store i8** %_11,i8*** %_10
%_12 = call i8* @calloc(i32 1, i32 17)
%_13 = bitcast i8* %_12 to i8***
%_14 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
store i8** %_14,i8*** %_13
%_15 = call i8* @calloc(i32 1, i32 17)
%_16 = bitcast i8* %_15 to i8***
%_17 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
store i8** %_17,i8*** %_16
%_18 = load i32, i32* 0
	ret i32 %_18
}
