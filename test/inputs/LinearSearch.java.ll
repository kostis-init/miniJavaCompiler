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
	%_1 = bitcast i8* %_7 to i8***
	%_2 = load i8**, i8*** %_1
	%_3 = getelementptr i8*, i8** %_2, i32 0
	%_4 = load i8*, i8** %_3
	%_5 = bitcast i8* %_4 to i32 (i8*,i32)*
	%_6 = call i32 %_5(i8* %_7, i32 10)
	call void (i32) @print_int(i32 %_6)

	ret i32 0
}
define i32 @LS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32
	%aux02 = alloca i32
	%_4 = bitcast i8* %this to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 3
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i32 (i8*,i32)*
	%_10 = load i32, i32* %sz
	%_9 = call i32 %_8(i8* %this, i32 %_10)
	store i32 %_9, i32* %aux01	%_13 = bitcast i8* %this to i8***
	%_14 = load i8**, i8*** %_13
	%_15 = getelementptr i8*, i8** %_14, i32 1
	%_16 = load i8*, i8** %_15
	%_17 = bitcast i8* %_16 to i32 (i8*)*
	%_18 = call i32 %_17(i8* %this)
	store i32 %_18, i32* %aux02	call void (i32) @print_int(i32 9999)
	%_20 = bitcast i8* %this to i8***
	%_21 = load i8**, i8*** %_20
	%_22 = getelementptr i8*, i8** %_21, i32 2
	%_23 = load i8*, i8** %_22
	%_24 = bitcast i8* %_23 to i32 (i8*,i32)*
	%_25 = call i32 %_24(i8* %this, i32 8)
	call void (i32) @print_int(i32 %_25)
	%_27 = bitcast i8* %this to i8***
	%_28 = load i8**, i8*** %_27
	%_29 = getelementptr i8*, i8** %_28, i32 2
	%_30 = load i8*, i8** %_29
	%_31 = bitcast i8* %_30 to i32 (i8*,i32)*
	%_32 = call i32 %_31(i8* %this, i32 12)
	call void (i32) @print_int(i32 %_32)
	%_34 = bitcast i8* %this to i8***
	%_35 = load i8**, i8*** %_34
	%_36 = getelementptr i8*, i8** %_35, i32 2
	%_37 = load i8*, i8** %_36
	%_38 = bitcast i8* %_37 to i32 (i8*,i32)*
	%_39 = call i32 %_38(i8* %this, i32 17)
	call void (i32) @print_int(i32 %_39)
	%_41 = bitcast i8* %this to i8***
	%_42 = load i8**, i8*** %_41
	%_43 = getelementptr i8*, i8** %_42, i32 2
	%_44 = load i8*, i8** %_43
	%_45 = bitcast i8* %_44 to i32 (i8*,i32)*
	%_46 = call i32 %_45(i8* %this, i32 50)
	call void (i32) @print_int(i32 %_46)

	ret i32 55
}
define i32 @LS.Print(i8* %this) {
	%j = alloca i32
	store i32 1, i32* %j	br label %loop0

loop0:
	%_3 = load i32, i32* %j
	%_4 = getelementptr i8, i8* %this, i32 16
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5
	%_2 = icmp slt i32 %_3, %_6	br i1 %_2, label %loop1, label %loop2

loop1:
	%_7 = getelementptr i8, i8* %this, i32 8
	%_8 = bitcast i8* %_7 to i32**
	%_9 = load i32*, i32** %_8
	%_10 = load i32, i32* %j
	%_11 = load i32, i32* %_9
	%_12 = icmp ult i32 %_10, %_11
	br i1 %_12, label %oob0, label %oob1

oob0:
	%_13 = add i32 %_10, 1
	%_14 = getelementptr i32, i32* %_9, i32 %_13
	%_15 = load i32, i32* %_14
	br label %oob2
oob1:
call void @throw_oob()
br label %oob2
	call void (i32) @print_int(i32 %_15)
	%_18 = load i32, i32* %j
	%_17 = add i32 %_18, 1	store i32 %_17, i32* %j	br label %loop0

loop2:

	ret i32 0
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
	store i32 1, i32* %j	store i1 0, i1* %ls01	store i32 0, i32* %ifound	br label %loop0

loop0:
	%_10 = load i32, i32* %j
	%_11 = getelementptr i8, i8* %this, i32 16
	%_12 = bitcast i8* %_11 to i32*
	%_13 = load i32, i32* %_12
	%_9 = icmp slt i32 %_10, %_13	br i1 %_9, label %loop1, label %loop2

loop1:
	%_15 = getelementptr i8, i8* %this, i32 8
	%_16 = bitcast i8* %_15 to i32**
	%_17 = load i32*, i32** %_16
	%_18 = load i32, i32* %j
	%_19 = load i32, i32* %_17
	%_20 = icmp ult i32 %_18, %_19
	br i1 %_20, label %oob0, label %oob1

oob0:
	%_21 = add i32 %_18, 1
	%_22 = getelementptr i32, i32* %_17, i32 %_21
	%_23 = load i32, i32* %_22
	br label %oob2
oob1:
call void @throw_oob()
br label %oob2
	store i32 %_23, i32* %aux01	%_26 = load i32, i32* %num
	%_25 = add i32 %_26, 1	store i32 %_25, i32* %aux02	%_28 = load i32, i32* %aux01
	%_29 = load i32, i32* %num
	%_27 = icmp slt i32 %_28, %_29	br i1 %_27, label %if0, label %if1

if0:
	store i32 0, i32* %nt	br label %if2

if1:
	%_33 = load i32, i32* %aux01
	%_34 = load i32, i32* %aux02
	%_32 = icmp slt i32 %_33, %_34	%_31 = xor i1 1, %_32	br i1 %_31, label %if3, label %if4

if3:
	store i32 0, i32* %nt	br label %if5

if4:
	store i1 1, i1* %ls01	store i32 1, i32* %ifound	%_39 = getelementptr i8, i8* %this, i32 16
	%_40 = bitcast i8* %_39 to i32*
	%_41 = load i32, i32* %_40
	store i32 %_41, i32* %j	br label %if5

if5:
	br label %if2

if2:
	%_44 = load i32, i32* %j
	%_43 = add i32 %_44, 1	store i32 %_43, i32* %j	br label %loop0

loop2:
	%_45 = load i32, i32* %ifound

	ret i32 %_45
}
define i32 @LS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%j = alloca i32
	%k = alloca i32
	%aux01 = alloca i32
	%aux02 = alloca i32
	%_4 = getelementptr i8, i8* %this, i32 16
	%_5 = bitcast i8* %_4 to i32*
	%_7 = load i32, i32* %sz
	store i32 %_7, i32* %_5	%_8 = getelementptr i8, i8* %this, i32 8
	%_9 = bitcast i8* %_8 to i32**
	%_16 = load i32, i32* %sz
	%_11 = load i32, i32* %_16
	%_12 = icmp slt i32 %_11, 0
	br i1 %_12, label %arr_alloc0, label %arr_alloc1

arr_alloc0:
call void @throw_oob()
br label %arr_alloc1

arr_alloc1:
%_13 = add i32 %_11, 1
	%_14 = call i8* @calloc(i32 4, i32 %_13)
	%_15 = bitcast i8* %_14 to i32*
	store i32 %_11, i32* %_15
	store i32* %_15, i32** %_9	store i32 1, i32* %j	%_20 = getelementptr i8, i8* %this, i32 16
	%_21 = bitcast i8* %_20 to i32*
	%_22 = load i32, i32* %_21
	%_19 = add i32 %_22, 1	store i32 %_19, i32* %k	br label %loop0

loop0:
	%_24 = load i32, i32* %j
	%_25 = getelementptr i8, i8* %this, i32 16
	%_26 = bitcast i8* %_25 to i32*
	%_27 = load i32, i32* %_26
	%_23 = icmp slt i32 %_24, %_27	br i1 %_23, label %loop1, label %loop2

loop1:
	%_30 = load i32, i32* %j
	%_29 = mul i32 2, %_30	store i32 %_29, i32* %aux01	%_33 = load i32, i32* %k
	%_32 = sub i32 %_33, 3	store i32 %_32, i32* %aux02	%_34 = getelementptr i8, i8* %this, i32 8
	%_35 = bitcast i8* %_34 to i32**
	%_36 = load i32*, i32** %_35
	%_37 = load i32, i32* %j
	%_39 = load i32, i32* %aux01
	%_40 = load i32, i32* %aux02
	%_38 = add i32 %_39, %_40	%_41 = load i32, i32* %_36
	%_42 = icmp ult i32 %_37, %_41
	br i1 %_42, label %oob0, label %oob1

oob0:
	%_43 = add i32 %_37, 1
	%_44 = getelementptr i32, i32* %_36, i32 %_43
	store i32 %_38, i32* %_44
	br label %oob2
oob1:
call void @throw_oob()
br label %oob2
	%_47 = load i32, i32* %j
	%_46 = add i32 %_47, 1	store i32 %_46, i32* %j	%_50 = load i32, i32* %k
	%_49 = sub i32 %_50, 1	store i32 %_49, i32* %k	br label %loop0

loop2:

	ret i32 0
}
