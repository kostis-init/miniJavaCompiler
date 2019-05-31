@.BubbleSort_vtable = global [0 x i8*] []
@.BBS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @BBS.Start to i8*),i8* bitcast (i32 (i8*)* @BBS.Sort to i8*),i8* bitcast (i32 (i8*)* @BBS.Print to i8*),i8* bitcast (i32 (i8*,i32)* @BBS.Init to i8*)]


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
%_9 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 0
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
define i32 @BBS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32
%_1 = bitcast i8* %this to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 3
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i32 (i8*,i32)*
%_6 = call i32 %_5(i8* %this, i32 %sz)
%_8 = bitcast i8* %this to i8***
%_9 = load i8**, i8*** %_8
%_10 = getelementptr i8*, i8** %_9, i32 2
%_11 = load i8*, i8** %_10
%_12 = bitcast i8* %_11 to i32 (i8*)*
%_13 = call i32 %_12(i8* %this)
%_15 = bitcast i8* %this to i8***
%_16 = load i8**, i8*** %_15
%_17 = getelementptr i8*, i8** %_16, i32 1
%_18 = load i8*, i8** %_17
%_19 = bitcast i8* %_18 to i32 (i8*)*
%_20 = call i32 %_19(i8* %this)
%_22 = bitcast i8* %this to i8***
%_23 = load i8**, i8*** %_22
%_24 = getelementptr i8*, i8** %_23, i32 2
%_25 = load i8*, i8** %_24
%_26 = bitcast i8* %_25 to i32 (i8*)*
%_27 = call i32 %_26(i8* %this)
%_28 = load i32, i32* 0
	ret i32 %_28
}
define i32 @BBS.Sort(i8* %this) {
	%nt = alloca i32
	%i = alloca i32
	%aux02 = alloca i32
	%aux04 = alloca i32
	%aux05 = alloca i32
	%aux06 = alloca i32
	%aux07 = alloca i32
	%j = alloca i32
	%t = alloca i32
%_0 = getelementptr i8, i8* %this, i32 16
%_1 = bitcast i8* %_0 to i32*
%_2 = getelementptr i8, i8* %this, i32 8
%_3 = bitcast i8* %_2 to i32**
%_4 = getelementptr i8, i8* %this, i32 8
%_5 = bitcast i8* %_4 to i32**
%_6 = getelementptr i8, i8* %this, i32 8
%_7 = bitcast i8* %_6 to i32**
%_8 = getelementptr i8, i8* %this, i32 8
%_9 = bitcast i8* %_8 to i32**
%_10 = getelementptr i8, i8* %this, i32 8
%_11 = bitcast i8* %_10 to i32**
%_12 = getelementptr i8, i8* %this, i32 8
%_13 = bitcast i8* %_12 to i32**
%_14 = load i32, i32* 0
	ret i32 %_14
}
define i32 @BBS.Print(i8* %this) {
	%j = alloca i32
%_0 = getelementptr i8, i8* %this, i32 16
%_1 = bitcast i8* %_0 to i32*
%_2 = getelementptr i8, i8* %this, i32 8
%_3 = bitcast i8* %_2 to i32**
%_4 = load i32, i32* 0
	ret i32 %_4
}
define i32 @BBS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
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
%_9 = getelementptr i8, i8* %this, i32 8
%_10 = bitcast i8* %_9 to i32**
%_11 = getelementptr i8, i8* %this, i32 8
%_12 = bitcast i8* %_11 to i32**
%_13 = getelementptr i8, i8* %this, i32 8
%_14 = bitcast i8* %_13 to i32**
%_15 = getelementptr i8, i8* %this, i32 8
%_16 = bitcast i8* %_15 to i32**
%_17 = getelementptr i8, i8* %this, i32 8
%_18 = bitcast i8* %_17 to i32**
%_19 = getelementptr i8, i8* %this, i32 8
%_20 = bitcast i8* %_19 to i32**
%_21 = getelementptr i8, i8* %this, i32 8
%_22 = bitcast i8* %_21 to i32**
%_23 = getelementptr i8, i8* %this, i32 8
%_24 = bitcast i8* %_23 to i32**
%_25 = getelementptr i8, i8* %this, i32 8
%_26 = bitcast i8* %_25 to i32**
%_27 = getelementptr i8, i8* %this, i32 8
%_28 = bitcast i8* %_27 to i32**
%_29 = load i32, i32* 0
	ret i32 %_29
}
