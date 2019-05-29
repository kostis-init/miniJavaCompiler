@.LinearSearch_vtable = global [0 x i8*] []
@.LS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @LS.Start to i8*),i8* bitcast (i32 (i8*)* @LS.Print to i8*),i8* bitcast (i32 (i8*,i32)* @LS.Search to i8*),i8* bitcast (i32 (i8*,i32)* @LS.Init to i8*)]


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
%_0 = call i8* @calloc(i32 1, i32 20)
%_1 = bitcast i8* %_0 to i8***
%_2 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 0
store i8** %_2,i8*** %_1

	ret i32 0
}
define i32 @LS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32
	%aux02 = alloca i32
%_0 = load i32, i32* 55
	ret i32 %_0
}
define i32 @LS.Print(i8* %this) {
	%j = alloca i32
%_0 = load i32, i32* 0
	ret i32 %_0
}
define i32 @LS.Search(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%j = alloca i32
	%ls01 = alloca i1
	%ifound = alloca i32
	%aux01 = alloca i32
	%aux02 = alloca i32
	%nt = alloca i32
%_0 = xor i1 1, null%_1 = load i32, i32* ifound
	ret i32 %_1
}
define i32 @LS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%j = alloca i32
	%k = alloca i32
	%aux01 = alloca i32
	%aux02 = alloca i32
%_0 = load i32, i32* sz
%_1 = icmp slt i32 %_0, 0
br i1 %_1, label %arr_alloc0, label %arr_alloc0

arr_alloc0:
call void @throw_oob()
br label %arr_alloc0

arr_alloc0:
%_2 = add i32 %_0, 1
%_3 = call i8* @calloc(i32 4, i32 %_2)
%_4 = bitcast i8* %_3 to i32*
store i32 %_0, i32* %_4
%_5 = load i32, i32* 0
	ret i32 %_5
}
