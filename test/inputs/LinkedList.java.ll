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

	ret i32 0
}
define i1 @Element.Init(i8* %this, i32 %.v_Age, i32 %.v_Salary, i1 %.v_Married) {
	%v_Age = alloca i32
	store i32 %.v_Age, i32* %v_Age
	%v_Salary = alloca i32
	store i32 %.v_Salary, i32* %v_Salary
	%v_Married = alloca i1
	store i1 %.v_Married, i1* %v_Married

	ret i1 true
}
define i32 @Element.GetAge(i8* %this) {

	ret i32 Age
}
define i32 @Element.GetSalary(i8* %this) {

	ret i32 Salary
}
define i1 @Element.GetMarried(i8* %this) {

	ret i1 Married
}
define i1 @Element.Equal(i8* %this, i8* %.other) {
	%other = alloca i8*
	store i8* %.other, i8** %other
	%ret_val = alloca i1
	%aux01 = alloca i32
	%aux02 = alloca i32
	%nt = alloca i32

	ret i1 ret_val
}
define i1 @Element.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%retval = alloca i1
	%aux02 = alloca i32

	ret i1 retval
}
define i1 @List.Init(i8* %this) {

	ret i1 true
}
define i1 @List.InitNew(i8* %this, i8* %.v_elem, i8* %.v_next, i1 %.v_end) {
	%v_elem = alloca i8*
	store i8* %.v_elem, i8** %v_elem
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
	%v_end = alloca i1
	store i1 %.v_end, i1* %v_end

	ret i1 true
}
define i8* @List.Insert(i8* %this, i8* %.new_elem) {
	%new_elem = alloca i8*
	store i8* %.new_elem, i8** %new_elem
	%ret_val = alloca i1
	%aux03 = alloca i8*
	%aux02 = alloca i8*

	ret i8* aux02
}
define i1 @List.SetNext(i8* %this, i8* %.v_next) {
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next

	ret i1 true
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

	ret i8* my_head
}
define i32 @List.Search(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e
	%int_ret_val = alloca i32
	%aux01 = alloca i8*
	%var_elem = alloca i8*
	%var_end = alloca i1
	%nt = alloca i32

	ret i32 int_ret_val
}
define i1 @List.GetEnd(i8* %this) {

	ret i1 end
}
define i8* @List.GetElem(i8* %this) {

	ret i8* elem
}
define i8* @List.GetNext(i8* %this) {

	ret i8* next
}
define i1 @List.Print(i8* %this) {
	%aux01 = alloca i8*
	%var_end = alloca i1
	%var_elem = alloca i8*

	ret i1 true
}
define i32 @LL.Start(i8* %this) {
	%head = alloca i8*
	%last_elem = alloca i8*
	%aux01 = alloca i1
	%el01 = alloca i8*
	%el02 = alloca i8*
	%el03 = alloca i8*

	ret i32 0
}
