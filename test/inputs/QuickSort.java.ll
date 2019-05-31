@.QuickSort_vtable = global [0 x i8*] []
@.QS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @QS.Start to i8*),i8* bitcast (i32 (i8*,i32,i32)* @QS.Sort to i8*),i8* bitcast (i32 (i8*)* @QS.Print to i8*),i8* bitcast (i32 (i8*,i32)* @QS.Init to i8*)]


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
%_9 = getelementptr [4 x i8*], [4 x i8*]* @.QS_vtable, i32 0, i32 0
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
define i32 @QS.Start(i8* %this, i32 %.sz) {
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
%_14 = getelementptr i8, i8* %this, i32 16
%_15 = bitcast i8* %_14 to i32*
%_17 = bitcast i8* %this to i8***
%_18 = load i8**, i8*** %_17
%_19 = getelementptr i8*, i8** %_18, i32 1
%_20 = load i8*, i8** %_19
%_21 = bitcast i8* %_20 to i32 (i8*,i32,i32)*
%_22 = call i32 %_21(i8* %this, i32 0, i32 %aux01)
%_24 = bitcast i8* %this to i8***
%_25 = load i8**, i8*** %_24
%_26 = getelementptr i8*, i8** %_25, i32 2
%_27 = load i8*, i8** %_26
%_28 = bitcast i8* %_27 to i32 (i8*)*
%_29 = call i32 %_28(i8* %this)
%_30 = load i32, i32* 0
	ret i32 %_30
}
define i32 @QS.Sort(i8* %this, i32 %.left, i32 %.right) {
	%left = alloca i32
	store i32 %.left, i32* %left
	%right = alloca i32
	store i32 %.right, i32* %right
	%v = alloca i32
	%i = alloca i32
	%j = alloca i32
	%nt = alloca i32
	%t = alloca i32
	%cont01 = alloca i1
	%cont02 = alloca i1
	%aux03 = alloca i32
%_0 = getelementptr i8, i8* %this, i32 8
%_1 = bitcast i8* %_0 to i32**
%_2 = getelementptr i8, i8* %this, i32 8
%_3 = bitcast i8* %_2 to i32**
%_4 = xor i1 1, null%_5 = getelementptr i8, i8* %this, i32 8
%_6 = bitcast i8* %_5 to i32**
%_7 = xor i1 1, null%_8 = getelementptr i8, i8* %this, i32 8
%_9 = bitcast i8* %_8 to i32**
%_10 = getelementptr i8, i8* %this, i32 8
%_11 = bitcast i8* %_10 to i32**
%_12 = getelementptr i8, i8* %this, i32 8
%_13 = bitcast i8* %_12 to i32**
%_14 = getelementptr i8, i8* %this, i32 8
%_15 = bitcast i8* %_14 to i32**
%_16 = getelementptr i8, i8* %this, i32 8
%_17 = bitcast i8* %_16 to i32**
%_18 = getelementptr i8, i8* %this, i32 8
%_19 = bitcast i8* %_18 to i32**
%_20 = getelementptr i8, i8* %this, i32 8
%_21 = bitcast i8* %_20 to i32**
%_22 = getelementptr i8, i8* %this, i32 8
%_23 = bitcast i8* %_22 to i32**
%_24 = getelementptr i8, i8* %this, i32 8
%_25 = bitcast i8* %_24 to i32**
%_27 = bitcast i8* %this to i8***
%_28 = load i8**, i8*** %_27
%_29 = getelementptr i8*, i8** %_28, i32 1
%_30 = load i8*, i8** %_29
%_31 = bitcast i8* %_30 to i32 (i8*,i32,i32)*
%_32 = call i32 %_31(i8* %this, i32 %left, i32 null)
%_34 = bitcast i8* %this to i8***
%_35 = load i8**, i8*** %_34
%_36 = getelementptr i8*, i8** %_35, i32 1
%_37 = load i8*, i8** %_36
%_38 = bitcast i8* %_37 to i32 (i8*,i32,i32)*
%_39 = call i32 %_38(i8* %this, i32 null, i32 %right)
%_40 = load i32, i32* 0
	ret i32 %_40
}
define i32 @QS.Print(i8* %this) {
	%j = alloca i32
%_0 = getelementptr i8, i8* %this, i32 16
%_1 = bitcast i8* %_0 to i32*
%_2 = getelementptr i8, i8* %this, i32 8
%_3 = bitcast i8* %_2 to i32**
%_4 = load i32, i32* 0
	ret i32 %_4
}
define i32 @QS.Init(i8* %this, i32 %.sz) {
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
