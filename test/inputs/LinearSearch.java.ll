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
%_7 = call i8* @calloc(i32 1, i32 20)
%_8 = bitcast i8* %_7 to i8***
%_9 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 0
store i8** %_9,i8*** %_8
%_0 = load i8*, i8** %_7
%_1 = bitcast i8* %_0 to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 0
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i32 (i8*,i32)*
%_6 = call i32 %_5(i8* %_0, i32 10)

	ret i32 0
}
define i32 @LS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32
	%aux02 = alloca i32
%_1 = bitcast i8* %this to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 3
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i32 (i8*,i32)*
%_6 = call i32 %_5(i8* %this, i32 %sz)
%_8 = bitcast i8* %this to i8***
%_9 = load i8**, i8*** %_8
%_10 = getelementptr i8*, i8** %_9, i32 1
%_11 = load i8*, i8** %_10
%_12 = bitcast i8* %_11 to i32 (i8*)*
%_13 = call i32 %_12(i8* %this)
%_15 = bitcast i8* %this to i8***
%_16 = load i8**, i8*** %_15
%_17 = getelementptr i8*, i8** %_16, i32 2
%_18 = load i8*, i8** %_17
%_19 = bitcast i8* %_18 to i32 (i8*,i32)*
%_20 = call i32 %_19(i8* %this, i32 8)
%_22 = bitcast i8* %this to i8***
%_23 = load i8**, i8*** %_22
%_24 = getelementptr i8*, i8** %_23, i32 2
%_25 = load i8*, i8** %_24
%_26 = bitcast i8* %_25 to i32 (i8*,i32)*
%_27 = call i32 %_26(i8* %this, i32 12)
%_29 = bitcast i8* %this to i8***
%_30 = load i8**, i8*** %_29
%_31 = getelementptr i8*, i8** %_30, i32 2
%_32 = load i8*, i8** %_31
%_33 = bitcast i8* %_32 to i32 (i8*,i32)*
%_34 = call i32 %_33(i8* %this, i32 17)
%_36 = bitcast i8* %this to i8***
%_37 = load i8**, i8*** %_36
%_38 = getelementptr i8*, i8** %_37, i32 2
%_39 = load i8*, i8** %_38
%_40 = bitcast i8* %_39 to i32 (i8*,i32)*
%_41 = call i32 %_40(i8* %this, i32 50)
%_42 = load i32, i32* 55
	ret i32 %_42
}
define i32 @LS.Print(i8* %this) {
	%j = alloca i32
%_0 = getelementptr i8, i8* %this, i32 16
%_1 = bitcast i8* %_0 to i32*
%_2 = getelementptr i8, i8* %this, i32 8
%_3 = bitcast i8* %_2 to i32**
%_4 = load i32, i32* 0
	ret i32 %_4
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
%_0 = getelementptr i8, i8* %this, i32 16
%_1 = bitcast i8* %_0 to i32*
%_2 = getelementptr i8, i8* %this, i32 8
%_3 = bitcast i8* %_2 to i32**
%_4 = xor i1 1, null%_5 = getelementptr i8, i8* %this, i32 16
%_6 = bitcast i8* %_5 to i32*
%_7 = load i32, i32* %ifound
	ret i32 %_7
}
define i32 @LS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%j = alloca i32
	%k = alloca i32
	%aux01 = alloca i32
	%aux02 = alloca i32
%_0 = getelementptr i8, i8* %this, i32 16
%_1 = bitcast i8* %_0 to i32*
%_2 = getelementptr i8, i8* %this, i32 8
%_3 = bitcast i8* %_2 to i32**
%_4 = load i32, i32* %sz
%_5 = icmp slt i32 %_4, 0
br i1 %_5, label %arr_alloc0, label %arr_alloc1

arr_alloc0:
call void @throw_oob()
br label %arr_alloc1

arr_alloc1:
%_6 = add i32 %_4, 1
%_7 = call i8* @calloc(i32 4, i32 %_6)
%_8 = bitcast i8* %_7 to i32*
store i32 %_4, i32* %_8
%_9 = getelementptr i8, i8* %this, i32 16
%_10 = bitcast i8* %_9 to i32*
%_11 = getelementptr i8, i8* %this, i32 16
%_12 = bitcast i8* %_11 to i32*
%_13 = getelementptr i8, i8* %this, i32 8
%_14 = bitcast i8* %_13 to i32**
%_15 = load i32, i32* 0
	ret i32 %_15
}
