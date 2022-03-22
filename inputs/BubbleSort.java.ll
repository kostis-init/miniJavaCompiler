@.BubbleSort_vtable = global [0 x i8*] []
@.BBS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @BBS.Start to i8*),i8* bitcast (i32 (i8*)* @BBS.Sort to i8*),i8* bitcast (i32 (i8*)* @BBS.Print to i8*),i8* bitcast (i32 (i8*,i32,i1)* @BBS.Init to i8*)]


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
	%_1 = bitcast i8* %_7 to i8***
	%_2 = load i8**, i8*** %_1
	%_3 = getelementptr i8*, i8** %_2, i32 0
	%_4 = load i8*, i8** %_3
	%_5 = bitcast i8* %_4 to i32 (i8*,i32)*
	%_6 = call i32 %_5(i8* %_7, i32 10)
	call void (i32) @print_int(i32 %_6)

	ret i32 0
}
define i32 @BBS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32
	%_3 = bitcast i8* %this to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 3
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*,i32,i1)*
	%_8 = call i32 %_7(i8* %this, i32 234, i1 1)
	store i32 %_8, i32* %aux01	%_11 = bitcast i8* %this to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 2
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i32 (i8*)*
	%_16 = call i32 %_15(i8* %this)
	store i32 %_16, i32* %aux01	call void (i32) @print_int(i32 99999)
	%_19 = bitcast i8* %this to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 1
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i32 (i8*)*
	%_24 = call i32 %_23(i8* %this)
	store i32 %_24, i32* %aux01	%_27 = bitcast i8* %this to i8***
	%_28 = load i8**, i8*** %_27
	%_29 = getelementptr i8*, i8** %_28, i32 2
	%_30 = load i8*, i8** %_29
	%_31 = bitcast i8* %_30 to i32 (i8*)*
	%_32 = call i32 %_31(i8* %this)
	store i32 %_32, i32* %aux01
	ret i32 0
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
	%_11 = getelementptr i8, i8* %this, i32 16
	%_12 = bitcast i8* %_11 to i32*
	%_13 = load i32, i32* %_12
	%_10 = sub i32 %_13, 1	store i32 %_10, i32* %i	%_15 = sub i32 0, 1	store i32 %_15, i32* %aux02	br label %loop0

loop0:
	%_17 = load i32, i32* %aux02
	%_18 = load i32, i32* %i
	%_16 = icmp slt i32 %_17, %_18	br i1 %_16, label %loop1, label %loop2

loop1:
	store i32 1, i32* %j	br label %loop3

loop3:
	%_21 = load i32, i32* %j
	%_23 = load i32, i32* %i
	%_22 = add i32 %_23, 1	%_20 = icmp slt i32 %_21, %_22	br i1 %_20, label %loop4, label %loop5

loop4:
	%_26 = load i32, i32* %j
	%_25 = sub i32 %_26, 1	store i32 %_25, i32* %aux07	%_28 = getelementptr i8, i8* %this, i32 8
	%_29 = bitcast i8* %_28 to i32**
	%_30 = load i32*, i32** %_29
	%_31 = load i32, i32* %aux07
	%_32 = load i32, i32* %_30
	%_33 = icmp ult i32 %_31, %_32
	br i1 %_33, label %oob0, label %oob1

oob0:
	%_34 = add i32 %_31, 1
	%_35 = getelementptr i32, i32* %_30, i32 %_34
	%_36 = load i32, i32* %_35
	br label %oob2
oob1:
call void @throw_oob()
br label %oob2
	store i32 %_36, i32* %aux04	%_38 = getelementptr i8, i8* %this, i32 8
	%_39 = bitcast i8* %_38 to i32**
	%_40 = load i32*, i32** %_39
	%_41 = load i32, i32* %j
	%_42 = load i32, i32* %_40
	%_43 = icmp ult i32 %_41, %_42
	br i1 %_43, label %oob3, label %oob4

oob3:
	%_44 = add i32 %_41, 1
	%_45 = getelementptr i32, i32* %_40, i32 %_44
	%_46 = load i32, i32* %_45
	br label %oob5
oob4:
call void @throw_oob()
br label %oob5
	store i32 %_46, i32* %aux05	%_48 = load i32, i32* %aux05
	%_49 = load i32, i32* %aux04
	%_47 = icmp slt i32 %_48, %_49	br i1 %_47, label %if0, label %if1

if0:
	%_52 = load i32, i32* %j
	%_51 = sub i32 %_52, 1	store i32 %_51, i32* %aux06	%_54 = getelementptr i8, i8* %this, i32 8
	%_55 = bitcast i8* %_54 to i32**
	%_56 = load i32*, i32** %_55
	%_57 = load i32, i32* %aux06
	%_58 = load i32, i32* %_56
	%_59 = icmp ult i32 %_57, %_58
	br i1 %_59, label %oob6, label %oob7

oob6:
	%_60 = add i32 %_57, 1
	%_61 = getelementptr i32, i32* %_56, i32 %_60
	%_62 = load i32, i32* %_61
	br label %oob8
oob7:
call void @throw_oob()
br label %oob8
	store i32 %_62, i32* %t	%_63 = getelementptr i8, i8* %this, i32 8
	%_64 = bitcast i8* %_63 to i32**
	%_65 = load i32*, i32** %_64
	%_66 = load i32, i32* %aux06
	%_67 = getelementptr i8, i8* %this, i32 8
	%_68 = bitcast i8* %_67 to i32**
	%_69 = load i32*, i32** %_68
	%_70 = load i32, i32* %j
	%_71 = load i32, i32* %_69
	%_72 = icmp ult i32 %_70, %_71
	br i1 %_72, label %oob9, label %oob10

oob9:
	%_73 = add i32 %_70, 1
	%_74 = getelementptr i32, i32* %_69, i32 %_73
	%_75 = load i32, i32* %_74
	br label %oob11
oob10:
call void @throw_oob()
br label %oob11
	%_76 = load i32, i32* %_65
	%_77 = icmp ult i32 %_66, %_76
	br i1 %_77, label %oob12, label %oob13

oob12:
	%_78 = add i32 %_66, 1
	%_79 = getelementptr i32, i32* %_65, i32 %_78
	store i32 %_75, i32* %_79
	br label %oob14
oob13:
call void @throw_oob()
br label %oob14
	%_80 = getelementptr i8, i8* %this, i32 8
	%_81 = bitcast i8* %_80 to i32**
	%_82 = load i32*, i32** %_81
	%_83 = load i32, i32* %j
	%_84 = load i32, i32* %t
	%_85 = load i32, i32* %_82
	%_86 = icmp ult i32 %_83, %_85
	br i1 %_86, label %oob15, label %oob16

oob15:
	%_87 = add i32 %_83, 1
	%_88 = getelementptr i32, i32* %_82, i32 %_87
	store i32 %_84, i32* %_88
	br label %oob17
oob16:
call void @throw_oob()
br label %oob17
	br label %if2

if1:
	store i32 0, i32* %nt	br label %if2

if2:
	%_92 = load i32, i32* %j
	%_91 = add i32 %_92, 1	store i32 %_91, i32* %j	br label %loop3

loop5:
	%_95 = load i32, i32* %i
	%_94 = sub i32 %_95, 1	store i32 %_94, i32* %i	br label %loop0

loop2:

	ret i32 0
}
define i32 @BBS.Print(i8* %this) {
	%j = alloca i32
	store i32 0, i32* %j	br label %loop0

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
define i32 @BBS.Init(i8* %this, i32 %.sz, i1 %.d) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%d = alloca i1
	store i1 %.d, i1* %d
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i32*
	%_3 = load i32, i32* %sz
	store i32 %_3, i32* %_1	%_4 = getelementptr i8, i8* %this, i32 8
	%_5 = bitcast i8* %_4 to i32**
	%_12 = load i32, i32* %sz
	%_7 = load i32, i32* %_12
	%_8 = icmp slt i32 %_7, 0
	br i1 %_8, label %arr_alloc0, label %arr_alloc1

arr_alloc0:
call void @throw_oob()
br label %arr_alloc1

arr_alloc1:
%_9 = add i32 %_7, 1
	%_10 = call i8* @calloc(i32 4, i32 %_9)
	%_11 = bitcast i8* %_10 to i32*
	store i32 %_7, i32* %_11
	store i32* %_11, i32** %_5	%_13 = getelementptr i8, i8* %this, i32 8
	%_14 = bitcast i8* %_13 to i32**
	%_15 = load i32*, i32** %_14
	%_16 = load i32, i32* %_15
	%_17 = icmp ult i32 0, %_16
	br i1 %_17, label %oob0, label %oob1

oob0:
	%_18 = add i32 0, 1
	%_19 = getelementptr i32, i32* %_15, i32 %_18
	store i32 20, i32* %_19
	br label %oob2
oob1:
call void @throw_oob()
br label %oob2
	%_20 = getelementptr i8, i8* %this, i32 8
	%_21 = bitcast i8* %_20 to i32**
	%_22 = load i32*, i32** %_21
	%_23 = load i32, i32* %_22
	%_24 = icmp ult i32 1, %_23
	br i1 %_24, label %oob3, label %oob4

oob3:
	%_25 = add i32 1, 1
	%_26 = getelementptr i32, i32* %_22, i32 %_25
	store i32 7, i32* %_26
	br label %oob5
oob4:
call void @throw_oob()
br label %oob5
	%_27 = getelementptr i8, i8* %this, i32 8
	%_28 = bitcast i8* %_27 to i32**
	%_29 = load i32*, i32** %_28
	%_30 = load i32, i32* %_29
	%_31 = icmp ult i32 2, %_30
	br i1 %_31, label %oob6, label %oob7

oob6:
	%_32 = add i32 2, 1
	%_33 = getelementptr i32, i32* %_29, i32 %_32
	store i32 12, i32* %_33
	br label %oob8
oob7:
call void @throw_oob()
br label %oob8
	%_34 = getelementptr i8, i8* %this, i32 8
	%_35 = bitcast i8* %_34 to i32**
	%_36 = load i32*, i32** %_35
	%_37 = load i32, i32* %_36
	%_38 = icmp ult i32 3, %_37
	br i1 %_38, label %oob9, label %oob10

oob9:
	%_39 = add i32 3, 1
	%_40 = getelementptr i32, i32* %_36, i32 %_39
	store i32 18, i32* %_40
	br label %oob11
oob10:
call void @throw_oob()
br label %oob11
	%_41 = getelementptr i8, i8* %this, i32 8
	%_42 = bitcast i8* %_41 to i32**
	%_43 = load i32*, i32** %_42
	%_44 = load i32, i32* %_43
	%_45 = icmp ult i32 4, %_44
	br i1 %_45, label %oob12, label %oob13

oob12:
	%_46 = add i32 4, 1
	%_47 = getelementptr i32, i32* %_43, i32 %_46
	store i32 2, i32* %_47
	br label %oob14
oob13:
call void @throw_oob()
br label %oob14
	%_48 = getelementptr i8, i8* %this, i32 8
	%_49 = bitcast i8* %_48 to i32**
	%_50 = load i32*, i32** %_49
	%_51 = load i32, i32* %_50
	%_52 = icmp ult i32 5, %_51
	br i1 %_52, label %oob15, label %oob16

oob15:
	%_53 = add i32 5, 1
	%_54 = getelementptr i32, i32* %_50, i32 %_53
	store i32 11, i32* %_54
	br label %oob17
oob16:
call void @throw_oob()
br label %oob17
	%_55 = getelementptr i8, i8* %this, i32 8
	%_56 = bitcast i8* %_55 to i32**
	%_57 = load i32*, i32** %_56
	%_58 = load i32, i32* %_57
	%_59 = icmp ult i32 6, %_58
	br i1 %_59, label %oob18, label %oob19

oob18:
	%_60 = add i32 6, 1
	%_61 = getelementptr i32, i32* %_57, i32 %_60
	store i32 6, i32* %_61
	br label %oob20
oob19:
call void @throw_oob()
br label %oob20
	%_62 = getelementptr i8, i8* %this, i32 8
	%_63 = bitcast i8* %_62 to i32**
	%_64 = load i32*, i32** %_63
	%_65 = load i32, i32* %_64
	%_66 = icmp ult i32 7, %_65
	br i1 %_66, label %oob21, label %oob22

oob21:
	%_67 = add i32 7, 1
	%_68 = getelementptr i32, i32* %_64, i32 %_67
	store i32 9, i32* %_68
	br label %oob23
oob22:
call void @throw_oob()
br label %oob23
	%_69 = getelementptr i8, i8* %this, i32 8
	%_70 = bitcast i8* %_69 to i32**
	%_71 = load i32*, i32** %_70
	%_72 = load i32, i32* %_71
	%_73 = icmp ult i32 8, %_72
	br i1 %_73, label %oob24, label %oob25

oob24:
	%_74 = add i32 8, 1
	%_75 = getelementptr i32, i32* %_71, i32 %_74
	store i32 19, i32* %_75
	br label %oob26
oob25:
call void @throw_oob()
br label %oob26
	%_76 = getelementptr i8, i8* %this, i32 8
	%_77 = bitcast i8* %_76 to i32**
	%_78 = load i32*, i32** %_77
	%_79 = load i32, i32* %_78
	%_80 = icmp ult i32 9, %_79
	br i1 %_80, label %oob27, label %oob28

oob27:
	%_81 = add i32 9, 1
	%_82 = getelementptr i32, i32* %_78, i32 %_81
	store i32 5, i32* %_82
	br label %oob29
oob28:
call void @throw_oob()
br label %oob29

	ret i32 0
}
