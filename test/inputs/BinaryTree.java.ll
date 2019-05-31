@.BinaryTree_vtable = global [0 x i8*] []
@.BT_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @BT.Start to i8*)]
@.Tree_vtable = global [20 x i8*] [i8* bitcast (i1 (i8*,i32)* @Tree.Init to i8*),i8* bitcast (i1 (i8*,i8*)* @Tree.SetRight to i8*),i8* bitcast (i1 (i8*,i8*)* @Tree.SetLeft to i8*),i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*),i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*),i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*),i8* bitcast (i1 (i8*,i32)* @Tree.SetKey to i8*),i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*),i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*),i8* bitcast (i1 (i8*,i1)* @Tree.SetHas_Left to i8*),i8* bitcast (i1 (i8*,i1)* @Tree.SetHas_Right to i8*),i8* bitcast (i1 (i8*,i32,i32)* @Tree.Compare to i8*),i8* bitcast (i1 (i8*,i32)* @Tree.Insert to i8*),i8* bitcast (i1 (i8*,i32)* @Tree.Delete to i8*),i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.Remove to i8*),i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.RemoveRight to i8*),i8* bitcast (i1 (i8*,i8*,i8*)* @Tree.RemoveLeft to i8*),i8* bitcast (i32 (i8*,i32)* @Tree.Search to i8*),i8* bitcast (i1 (i8*)* @Tree.Print to i8*),i8* bitcast (i1 (i8*,i8*)* @Tree.RecPrint to i8*)]


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
%_9 = getelementptr [1 x i8*], [1 x i8*]* @.BT_vtable, i32 0, i32 0
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
define i32 @BT.Start(i8* %this) {
	%root = alloca i8*
	%ntb = alloca i1
	%nti = alloca i32
%_0 = call i8* @calloc(i32 1, i32 38)
%_1 = bitcast i8* %_0 to i8***
%_2 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
store i8** %_2,i8*** %_1
%_3 = load i8*, i8** %root
%_4 = bitcast i8* %_3 to i8***
%_5 = load i8**, i8*** %_4
%_6 = getelementptr i8*, i8** %_5, i32 0
%_7 = load i8*, i8** %_6
%_8 = bitcast i8* %_7 to i1 (i8*,i32)*
%_9 = call i1 %_8(i8* %_3, i32 16)
%_10 = load i8*, i8** %root
%_11 = bitcast i8* %_10 to i8***
%_12 = load i8**, i8*** %_11
%_13 = getelementptr i8*, i8** %_12, i32 18
%_14 = load i8*, i8** %_13
%_15 = bitcast i8* %_14 to i1 (i8*)*
%_16 = call i1 %_15(i8* %_10)
%_17 = load i8*, i8** %root
%_18 = bitcast i8* %_17 to i8***
%_19 = load i8**, i8*** %_18
%_20 = getelementptr i8*, i8** %_19, i32 12
%_21 = load i8*, i8** %_20
%_22 = bitcast i8* %_21 to i1 (i8*,i32)*
%_23 = call i1 %_22(i8* %_17, i32 8)
%_24 = load i8*, i8** %root
%_25 = bitcast i8* %_24 to i8***
%_26 = load i8**, i8*** %_25
%_27 = getelementptr i8*, i8** %_26, i32 18
%_28 = load i8*, i8** %_27
%_29 = bitcast i8* %_28 to i1 (i8*)*
%_30 = call i1 %_29(i8* %_24)
%_31 = load i8*, i8** %root
%_32 = bitcast i8* %_31 to i8***
%_33 = load i8**, i8*** %_32
%_34 = getelementptr i8*, i8** %_33, i32 12
%_35 = load i8*, i8** %_34
%_36 = bitcast i8* %_35 to i1 (i8*,i32)*
%_37 = call i1 %_36(i8* %_31, i32 24)
%_38 = load i8*, i8** %root
%_39 = bitcast i8* %_38 to i8***
%_40 = load i8**, i8*** %_39
%_41 = getelementptr i8*, i8** %_40, i32 12
%_42 = load i8*, i8** %_41
%_43 = bitcast i8* %_42 to i1 (i8*,i32)*
%_44 = call i1 %_43(i8* %_38, i32 4)
%_45 = load i8*, i8** %root
%_46 = bitcast i8* %_45 to i8***
%_47 = load i8**, i8*** %_46
%_48 = getelementptr i8*, i8** %_47, i32 12
%_49 = load i8*, i8** %_48
%_50 = bitcast i8* %_49 to i1 (i8*,i32)*
%_51 = call i1 %_50(i8* %_45, i32 12)
%_52 = load i8*, i8** %root
%_53 = bitcast i8* %_52 to i8***
%_54 = load i8**, i8*** %_53
%_55 = getelementptr i8*, i8** %_54, i32 12
%_56 = load i8*, i8** %_55
%_57 = bitcast i8* %_56 to i1 (i8*,i32)*
%_58 = call i1 %_57(i8* %_52, i32 20)
%_59 = load i8*, i8** %root
%_60 = bitcast i8* %_59 to i8***
%_61 = load i8**, i8*** %_60
%_62 = getelementptr i8*, i8** %_61, i32 12
%_63 = load i8*, i8** %_62
%_64 = bitcast i8* %_63 to i1 (i8*,i32)*
%_65 = call i1 %_64(i8* %_59, i32 28)
%_66 = load i8*, i8** %root
%_67 = bitcast i8* %_66 to i8***
%_68 = load i8**, i8*** %_67
%_69 = getelementptr i8*, i8** %_68, i32 12
%_70 = load i8*, i8** %_69
%_71 = bitcast i8* %_70 to i1 (i8*,i32)*
%_72 = call i1 %_71(i8* %_66, i32 14)
%_73 = load i8*, i8** %root
%_74 = bitcast i8* %_73 to i8***
%_75 = load i8**, i8*** %_74
%_76 = getelementptr i8*, i8** %_75, i32 18
%_77 = load i8*, i8** %_76
%_78 = bitcast i8* %_77 to i1 (i8*)*
%_79 = call i1 %_78(i8* %_73)
%_80 = load i8*, i8** %root
%_81 = bitcast i8* %_80 to i8***
%_82 = load i8**, i8*** %_81
%_83 = getelementptr i8*, i8** %_82, i32 17
%_84 = load i8*, i8** %_83
%_85 = bitcast i8* %_84 to i32 (i8*,i32)*
%_86 = call i32 %_85(i8* %_80, i32 24)
%_87 = load i8*, i8** %root
%_88 = bitcast i8* %_87 to i8***
%_89 = load i8**, i8*** %_88
%_90 = getelementptr i8*, i8** %_89, i32 17
%_91 = load i8*, i8** %_90
%_92 = bitcast i8* %_91 to i32 (i8*,i32)*
%_93 = call i32 %_92(i8* %_87, i32 12)
%_94 = load i8*, i8** %root
%_95 = bitcast i8* %_94 to i8***
%_96 = load i8**, i8*** %_95
%_97 = getelementptr i8*, i8** %_96, i32 17
%_98 = load i8*, i8** %_97
%_99 = bitcast i8* %_98 to i32 (i8*,i32)*
%_100 = call i32 %_99(i8* %_94, i32 16)
%_101 = load i8*, i8** %root
%_102 = bitcast i8* %_101 to i8***
%_103 = load i8**, i8*** %_102
%_104 = getelementptr i8*, i8** %_103, i32 17
%_105 = load i8*, i8** %_104
%_106 = bitcast i8* %_105 to i32 (i8*,i32)*
%_107 = call i32 %_106(i8* %_101, i32 50)
%_108 = load i8*, i8** %root
%_109 = bitcast i8* %_108 to i8***
%_110 = load i8**, i8*** %_109
%_111 = getelementptr i8*, i8** %_110, i32 17
%_112 = load i8*, i8** %_111
%_113 = bitcast i8* %_112 to i32 (i8*,i32)*
%_114 = call i32 %_113(i8* %_108, i32 12)
%_115 = load i8*, i8** %root
%_116 = bitcast i8* %_115 to i8***
%_117 = load i8**, i8*** %_116
%_118 = getelementptr i8*, i8** %_117, i32 13
%_119 = load i8*, i8** %_118
%_120 = bitcast i8* %_119 to i1 (i8*,i32)*
%_121 = call i1 %_120(i8* %_115, i32 12)
%_122 = load i8*, i8** %root
%_123 = bitcast i8* %_122 to i8***
%_124 = load i8**, i8*** %_123
%_125 = getelementptr i8*, i8** %_124, i32 18
%_126 = load i8*, i8** %_125
%_127 = bitcast i8* %_126 to i1 (i8*)*
%_128 = call i1 %_127(i8* %_122)
%_129 = load i8*, i8** %root
%_130 = bitcast i8* %_129 to i8***
%_131 = load i8**, i8*** %_130
%_132 = getelementptr i8*, i8** %_131, i32 17
%_133 = load i8*, i8** %_132
%_134 = bitcast i8* %_133 to i32 (i8*,i32)*
%_135 = call i32 %_134(i8* %_129, i32 12)
%_136 = load i32, i32* 0
	ret i32 %_136
}
define i1 @Tree.Init(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
%_0 = getelementptr i8, i8* %this, i32 24
%_1 = bitcast i8* %_0 to i32*
%_2 = getelementptr i8, i8* %this, i32 28
%_3 = bitcast i8* %_2 to i1*
%_4 = getelementptr i8, i8* %this, i32 29
%_5 = bitcast i8* %_4 to i1*
%_6 = load i1, i1* true
	ret i1 %_6
}
define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
	%rn = alloca i8*
	store i8* %.rn, i8** %rn
%_0 = getelementptr i8, i8* %this, i32 16
%_1 = bitcast i8* %_0 to i8**
%_2 = load i1, i1* true
	ret i1 %_2
}
define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
	%ln = alloca i8*
	store i8* %.ln, i8** %ln
%_0 = getelementptr i8, i8* %this, i32 8
%_1 = bitcast i8* %_0 to i8**
%_2 = load i1, i1* true
	ret i1 %_2
}
define i8* @Tree.GetRight(i8* %this) {
%_1 = getelementptr i8, i8* %this, i32 16
%_2 = bitcast i8* %_1 to i8**
%_0 = load i8*, i8** %_2
	ret i8* %_0
}
define i8* @Tree.GetLeft(i8* %this) {
%_1 = getelementptr i8, i8* %this, i32 8
%_2 = bitcast i8* %_1 to i8**
%_0 = load i8*, i8** %_2
	ret i8* %_0
}
define i32 @Tree.GetKey(i8* %this) {
%_1 = getelementptr i8, i8* %this, i32 24
%_2 = bitcast i8* %_1 to i32*
%_0 = load i32, i32* %_2
	ret i32 %_0
}
define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
%_0 = getelementptr i8, i8* %this, i32 24
%_1 = bitcast i8* %_0 to i32*
%_2 = load i1, i1* true
	ret i1 %_2
}
define i1 @Tree.GetHas_Right(i8* %this) {
%_1 = getelementptr i8, i8* %this, i32 29
%_2 = bitcast i8* %_1 to i1*
%_0 = load i1, i1* %_2
	ret i1 %_0
}
define i1 @Tree.GetHas_Left(i8* %this) {
%_1 = getelementptr i8, i8* %this, i32 28
%_2 = bitcast i8* %_1 to i1*
%_0 = load i1, i1* %_2
	ret i1 %_0
}
define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
%_0 = getelementptr i8, i8* %this, i32 28
%_1 = bitcast i8* %_0 to i1*
%_2 = load i1, i1* true
	ret i1 %_2
}
define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
%_0 = getelementptr i8, i8* %this, i32 29
%_1 = bitcast i8* %_0 to i1*
%_2 = load i1, i1* true
	ret i1 %_2
}
define i1 @Tree.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%ntb = alloca i1
	%nti = alloca i32
%_0 = xor i1 1, null%_1 = load i1, i1* %ntb
	ret i1 %_1
}
define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%new_node = alloca i8*
	%ntb = alloca i1
	%cont = alloca i1
	%key_aux = alloca i32
	%current_node = alloca i8*
%_0 = call i8* @calloc(i32 1, i32 38)
%_1 = bitcast i8* %_0 to i8***
%_2 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
store i8** %_2,i8*** %_1
%_3 = load i8*, i8** %new_node
%_4 = bitcast i8* %_3 to i8***
%_5 = load i8**, i8*** %_4
%_6 = getelementptr i8*, i8** %_5, i32 0
%_7 = load i8*, i8** %_6
%_8 = bitcast i8* %_7 to i1 (i8*,i32)*
%_9 = call i1 %_8(i8* %_3, i32 %v_key)
%_10 = load i8*, i8** %current_node
%_11 = bitcast i8* %_10 to i8***
%_12 = load i8**, i8*** %_11
%_13 = getelementptr i8*, i8** %_12, i32 5
%_14 = load i8*, i8** %_13
%_15 = bitcast i8* %_14 to i32 (i8*)*
%_16 = call i32 %_15(i8* %_10)
%_17 = load i8*, i8** %current_node
%_18 = bitcast i8* %_17 to i8***
%_19 = load i8**, i8*** %_18
%_20 = getelementptr i8*, i8** %_19, i32 8
%_21 = load i8*, i8** %_20
%_22 = bitcast i8* %_21 to i1 (i8*)*
%_23 = call i1 %_22(i8* %_17)
%_24 = load i8*, i8** %current_node
%_25 = bitcast i8* %_24 to i8***
%_26 = load i8**, i8*** %_25
%_27 = getelementptr i8*, i8** %_26, i32 4
%_28 = load i8*, i8** %_27
%_29 = bitcast i8* %_28 to i8* (i8*)*
%_30 = call i8* %_29(i8* %_24)
%_31 = load i8*, i8** %current_node
%_32 = bitcast i8* %_31 to i8***
%_33 = load i8**, i8*** %_32
%_34 = getelementptr i8*, i8** %_33, i32 9
%_35 = load i8*, i8** %_34
%_36 = bitcast i8* %_35 to i1 (i8*,i1)*
%_37 = call i1 %_36(i8* %_31, i1 true)
%_38 = load i8*, i8** %current_node
%_39 = bitcast i8* %_38 to i8***
%_40 = load i8**, i8*** %_39
%_41 = getelementptr i8*, i8** %_40, i32 2
%_42 = load i8*, i8** %_41
%_43 = bitcast i8* %_42 to i1 (i8*,i8*)*
%_44 = call i1 %_43(i8* %_38, i8* %new_node)
%_45 = load i8*, i8** %current_node
%_46 = bitcast i8* %_45 to i8***
%_47 = load i8**, i8*** %_46
%_48 = getelementptr i8*, i8** %_47, i32 7
%_49 = load i8*, i8** %_48
%_50 = bitcast i8* %_49 to i1 (i8*)*
%_51 = call i1 %_50(i8* %_45)
%_52 = load i8*, i8** %current_node
%_53 = bitcast i8* %_52 to i8***
%_54 = load i8**, i8*** %_53
%_55 = getelementptr i8*, i8** %_54, i32 3
%_56 = load i8*, i8** %_55
%_57 = bitcast i8* %_56 to i8* (i8*)*
%_58 = call i8* %_57(i8* %_52)
%_59 = load i8*, i8** %current_node
%_60 = bitcast i8* %_59 to i8***
%_61 = load i8**, i8*** %_60
%_62 = getelementptr i8*, i8** %_61, i32 10
%_63 = load i8*, i8** %_62
%_64 = bitcast i8* %_63 to i1 (i8*,i1)*
%_65 = call i1 %_64(i8* %_59, i1 true)
%_66 = load i8*, i8** %current_node
%_67 = bitcast i8* %_66 to i8***
%_68 = load i8**, i8*** %_67
%_69 = getelementptr i8*, i8** %_68, i32 1
%_70 = load i8*, i8** %_69
%_71 = bitcast i8* %_70 to i1 (i8*,i8*)*
%_72 = call i1 %_71(i8* %_66, i8* %new_node)
%_73 = load i1, i1* true
	ret i1 %_73
}
define i1 @Tree.Delete(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%current_node = alloca i8*
	%parent_node = alloca i8*
	%cont = alloca i1
	%found = alloca i1
	%is_root = alloca i1
	%key_aux = alloca i32
	%ntb = alloca i1
%_0 = load i8*, i8** %current_node
%_1 = bitcast i8* %_0 to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 5
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i32 (i8*)*
%_6 = call i32 %_5(i8* %_0)
%_7 = load i8*, i8** %current_node
%_8 = bitcast i8* %_7 to i8***
%_9 = load i8**, i8*** %_8
%_10 = getelementptr i8*, i8** %_9, i32 8
%_11 = load i8*, i8** %_10
%_12 = bitcast i8* %_11 to i1 (i8*)*
%_13 = call i1 %_12(i8* %_7)
%_14 = load i8*, i8** %current_node
%_15 = bitcast i8* %_14 to i8***
%_16 = load i8**, i8*** %_15
%_17 = getelementptr i8*, i8** %_16, i32 4
%_18 = load i8*, i8** %_17
%_19 = bitcast i8* %_18 to i8* (i8*)*
%_20 = call i8* %_19(i8* %_14)
%_21 = load i8*, i8** %current_node
%_22 = bitcast i8* %_21 to i8***
%_23 = load i8**, i8*** %_22
%_24 = getelementptr i8*, i8** %_23, i32 7
%_25 = load i8*, i8** %_24
%_26 = bitcast i8* %_25 to i1 (i8*)*
%_27 = call i1 %_26(i8* %_21)
%_28 = load i8*, i8** %current_node
%_29 = bitcast i8* %_28 to i8***
%_30 = load i8**, i8*** %_29
%_31 = getelementptr i8*, i8** %_30, i32 3
%_32 = load i8*, i8** %_31
%_33 = bitcast i8* %_32 to i8* (i8*)*
%_34 = call i8* %_33(i8* %_28)
%_36 = load i8*, i8** %current_node
%_37 = bitcast i8* %_36 to i8***
%_38 = load i8**, i8*** %_37
%_39 = getelementptr i8*, i8** %_38, i32 7
%_40 = load i8*, i8** %_39
%_41 = bitcast i8* %_40 to i1 (i8*)*
%_42 = call i1 %_41(i8* %_36)
%_35 = xor i1 1, %_42%_44 = load i8*, i8** %current_node
%_45 = bitcast i8* %_44 to i8***
%_46 = load i8**, i8*** %_45
%_47 = getelementptr i8*, i8** %_46, i32 8
%_48 = load i8*, i8** %_47
%_49 = bitcast i8* %_48 to i1 (i8*)*
%_50 = call i1 %_49(i8* %_44)
%_43 = xor i1 1, %_50%_52 = bitcast i8* %this to i8***
%_53 = load i8**, i8*** %_52
%_54 = getelementptr i8*, i8** %_53, i32 14
%_55 = load i8*, i8** %_54
%_56 = bitcast i8* %_55 to i1 (i8*,i8*,i8*)*
%_57 = call i1 %_56(i8* %this, i8* %parent_node, i8* %current_node)
%_59 = bitcast i8* %this to i8***
%_60 = load i8**, i8*** %_59
%_61 = getelementptr i8*, i8** %_60, i32 14
%_62 = load i8*, i8** %_61
%_63 = bitcast i8* %_62 to i1 (i8*,i8*,i8*)*
%_64 = call i1 %_63(i8* %this, i8* %parent_node, i8* %current_node)
%_65 = load i1, i1* %found
	ret i1 %_65
}
define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	%auxkey1 = alloca i32
	%auxkey2 = alloca i32
%_0 = load i8*, i8** %c_node
%_1 = bitcast i8* %_0 to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 8
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i1 (i8*)*
%_6 = call i1 %_5(i8* %_0)
%_8 = bitcast i8* %this to i8***
%_9 = load i8**, i8*** %_8
%_10 = getelementptr i8*, i8** %_9, i32 16
%_11 = load i8*, i8** %_10
%_12 = bitcast i8* %_11 to i1 (i8*,i8*,i8*)*
%_13 = call i1 %_12(i8* %this, i8* %p_node, i8* %c_node)
%_14 = load i8*, i8** %c_node
%_15 = bitcast i8* %_14 to i8***
%_16 = load i8**, i8*** %_15
%_17 = getelementptr i8*, i8** %_16, i32 7
%_18 = load i8*, i8** %_17
%_19 = bitcast i8* %_18 to i1 (i8*)*
%_20 = call i1 %_19(i8* %_14)
%_22 = bitcast i8* %this to i8***
%_23 = load i8**, i8*** %_22
%_24 = getelementptr i8*, i8** %_23, i32 15
%_25 = load i8*, i8** %_24
%_26 = bitcast i8* %_25 to i1 (i8*,i8*,i8*)*
%_27 = call i1 %_26(i8* %this, i8* %p_node, i8* %c_node)
%_28 = load i8*, i8** %c_node
%_29 = bitcast i8* %_28 to i8***
%_30 = load i8**, i8*** %_29
%_31 = getelementptr i8*, i8** %_30, i32 5
%_32 = load i8*, i8** %_31
%_33 = bitcast i8* %_32 to i32 (i8*)*
%_34 = call i32 %_33(i8* %_28)
%_42 = load i8*, i8** %p_node
%_43 = bitcast i8* %_42 to i8***
%_44 = load i8**, i8*** %_43
%_45 = getelementptr i8*, i8** %_44, i32 4
%_46 = load i8*, i8** %_45
%_47 = bitcast i8* %_46 to i8* (i8*)*
%_48 = call i8* %_47(i8* %_42)
%_35 = load i8*, i8** %_48
%_36 = bitcast i8* %_35 to i8***
%_37 = load i8**, i8*** %_36
%_38 = getelementptr i8*, i8** %_37, i32 5
%_39 = load i8*, i8** %_38
%_40 = bitcast i8* %_39 to i32 (i8*)*
%_41 = call i32 %_40(i8* %_35)
%_50 = bitcast i8* %this to i8***
%_51 = load i8**, i8*** %_50
%_52 = getelementptr i8*, i8** %_51, i32 11
%_53 = load i8*, i8** %_52
%_54 = bitcast i8* %_53 to i1 (i8*,i32,i32)*
%_55 = call i1 %_54(i8* %this, i32 %auxkey1, i32 %auxkey2)
%_56 = load i8*, i8** %p_node
%_57 = bitcast i8* %_56 to i8***
%_58 = load i8**, i8*** %_57
%_59 = getelementptr i8*, i8** %_58, i32 2
%_60 = load i8*, i8** %_59
%_61 = bitcast i8* %_60 to i1 (i8*,i8*)*
%_63 = getelementptr i8, i8* %this, i32 30
%_64 = bitcast i8* %_63 to i8**
%_62 = call i1 %_61(i8* %_56, i8* %_64)
%_65 = load i8*, i8** %p_node
%_66 = bitcast i8* %_65 to i8***
%_67 = load i8**, i8*** %_66
%_68 = getelementptr i8*, i8** %_67, i32 9
%_69 = load i8*, i8** %_68
%_70 = bitcast i8* %_69 to i1 (i8*,i1)*
%_71 = call i1 %_70(i8* %_65, i1 false)
%_72 = load i8*, i8** %p_node
%_73 = bitcast i8* %_72 to i8***
%_74 = load i8**, i8*** %_73
%_75 = getelementptr i8*, i8** %_74, i32 1
%_76 = load i8*, i8** %_75
%_77 = bitcast i8* %_76 to i1 (i8*,i8*)*
%_79 = getelementptr i8, i8* %this, i32 30
%_80 = bitcast i8* %_79 to i8**
%_78 = call i1 %_77(i8* %_72, i8* %_80)
%_81 = load i8*, i8** %p_node
%_82 = bitcast i8* %_81 to i8***
%_83 = load i8**, i8*** %_82
%_84 = getelementptr i8*, i8** %_83, i32 10
%_85 = load i8*, i8** %_84
%_86 = bitcast i8* %_85 to i1 (i8*,i1)*
%_87 = call i1 %_86(i8* %_81, i1 false)
%_88 = load i1, i1* true
	ret i1 %_88
}
define i1 @Tree.RemoveRight(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
%_0 = load i8*, i8** %c_node
%_1 = bitcast i8* %_0 to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 7
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i1 (i8*)*
%_6 = call i1 %_5(i8* %_0)
%_7 = load i8*, i8** %c_node
%_8 = bitcast i8* %_7 to i8***
%_9 = load i8**, i8*** %_8
%_10 = getelementptr i8*, i8** %_9, i32 6
%_11 = load i8*, i8** %_10
%_12 = bitcast i8* %_11 to i1 (i8*,i32)*
%_21 = load i8*, i8** %c_node
%_22 = bitcast i8* %_21 to i8***
%_23 = load i8**, i8*** %_22
%_24 = getelementptr i8*, i8** %_23, i32 3
%_25 = load i8*, i8** %_24
%_26 = bitcast i8* %_25 to i8* (i8*)*
%_27 = call i8* %_26(i8* %_21)
%_14 = load i8*, i8** %_27
%_15 = bitcast i8* %_14 to i8***
%_16 = load i8**, i8*** %_15
%_17 = getelementptr i8*, i8** %_16, i32 5
%_18 = load i8*, i8** %_17
%_19 = bitcast i8* %_18 to i32 (i8*)*
%_20 = call i32 %_19(i8* %_14)
%_13 = call i1 %_12(i8* %_7, i32 %_20)
%_28 = load i8*, i8** %c_node
%_29 = bitcast i8* %_28 to i8***
%_30 = load i8**, i8*** %_29
%_31 = getelementptr i8*, i8** %_30, i32 3
%_32 = load i8*, i8** %_31
%_33 = bitcast i8* %_32 to i8* (i8*)*
%_34 = call i8* %_33(i8* %_28)
%_35 = load i8*, i8** %p_node
%_36 = bitcast i8* %_35 to i8***
%_37 = load i8**, i8*** %_36
%_38 = getelementptr i8*, i8** %_37, i32 1
%_39 = load i8*, i8** %_38
%_40 = bitcast i8* %_39 to i1 (i8*,i8*)*
%_42 = getelementptr i8, i8* %this, i32 30
%_43 = bitcast i8* %_42 to i8**
%_41 = call i1 %_40(i8* %_35, i8* %_43)
%_44 = load i8*, i8** %p_node
%_45 = bitcast i8* %_44 to i8***
%_46 = load i8**, i8*** %_45
%_47 = getelementptr i8*, i8** %_46, i32 10
%_48 = load i8*, i8** %_47
%_49 = bitcast i8* %_48 to i1 (i8*,i1)*
%_50 = call i1 %_49(i8* %_44, i1 false)
%_51 = load i1, i1* true
	ret i1 %_51
}
define i1 @Tree.RemoveLeft(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
%_0 = load i8*, i8** %c_node
%_1 = bitcast i8* %_0 to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 8
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i1 (i8*)*
%_6 = call i1 %_5(i8* %_0)
%_7 = load i8*, i8** %c_node
%_8 = bitcast i8* %_7 to i8***
%_9 = load i8**, i8*** %_8
%_10 = getelementptr i8*, i8** %_9, i32 6
%_11 = load i8*, i8** %_10
%_12 = bitcast i8* %_11 to i1 (i8*,i32)*
%_21 = load i8*, i8** %c_node
%_22 = bitcast i8* %_21 to i8***
%_23 = load i8**, i8*** %_22
%_24 = getelementptr i8*, i8** %_23, i32 4
%_25 = load i8*, i8** %_24
%_26 = bitcast i8* %_25 to i8* (i8*)*
%_27 = call i8* %_26(i8* %_21)
%_14 = load i8*, i8** %_27
%_15 = bitcast i8* %_14 to i8***
%_16 = load i8**, i8*** %_15
%_17 = getelementptr i8*, i8** %_16, i32 5
%_18 = load i8*, i8** %_17
%_19 = bitcast i8* %_18 to i32 (i8*)*
%_20 = call i32 %_19(i8* %_14)
%_13 = call i1 %_12(i8* %_7, i32 %_20)
%_28 = load i8*, i8** %c_node
%_29 = bitcast i8* %_28 to i8***
%_30 = load i8**, i8*** %_29
%_31 = getelementptr i8*, i8** %_30, i32 4
%_32 = load i8*, i8** %_31
%_33 = bitcast i8* %_32 to i8* (i8*)*
%_34 = call i8* %_33(i8* %_28)
%_35 = load i8*, i8** %p_node
%_36 = bitcast i8* %_35 to i8***
%_37 = load i8**, i8*** %_36
%_38 = getelementptr i8*, i8** %_37, i32 2
%_39 = load i8*, i8** %_38
%_40 = bitcast i8* %_39 to i1 (i8*,i8*)*
%_42 = getelementptr i8, i8* %this, i32 30
%_43 = bitcast i8* %_42 to i8**
%_41 = call i1 %_40(i8* %_35, i8* %_43)
%_44 = load i8*, i8** %p_node
%_45 = bitcast i8* %_44 to i8***
%_46 = load i8**, i8*** %_45
%_47 = getelementptr i8*, i8** %_46, i32 9
%_48 = load i8*, i8** %_47
%_49 = bitcast i8* %_48 to i1 (i8*,i1)*
%_50 = call i1 %_49(i8* %_44, i1 false)
%_51 = load i1, i1* true
	ret i1 %_51
}
define i32 @Tree.Search(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%cont = alloca i1
	%ifound = alloca i32
	%current_node = alloca i8*
	%key_aux = alloca i32
%_0 = load i8*, i8** %current_node
%_1 = bitcast i8* %_0 to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 5
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i32 (i8*)*
%_6 = call i32 %_5(i8* %_0)
%_7 = load i8*, i8** %current_node
%_8 = bitcast i8* %_7 to i8***
%_9 = load i8**, i8*** %_8
%_10 = getelementptr i8*, i8** %_9, i32 8
%_11 = load i8*, i8** %_10
%_12 = bitcast i8* %_11 to i1 (i8*)*
%_13 = call i1 %_12(i8* %_7)
%_14 = load i8*, i8** %current_node
%_15 = bitcast i8* %_14 to i8***
%_16 = load i8**, i8*** %_15
%_17 = getelementptr i8*, i8** %_16, i32 4
%_18 = load i8*, i8** %_17
%_19 = bitcast i8* %_18 to i8* (i8*)*
%_20 = call i8* %_19(i8* %_14)
%_21 = load i8*, i8** %current_node
%_22 = bitcast i8* %_21 to i8***
%_23 = load i8**, i8*** %_22
%_24 = getelementptr i8*, i8** %_23, i32 7
%_25 = load i8*, i8** %_24
%_26 = bitcast i8* %_25 to i1 (i8*)*
%_27 = call i1 %_26(i8* %_21)
%_28 = load i8*, i8** %current_node
%_29 = bitcast i8* %_28 to i8***
%_30 = load i8**, i8*** %_29
%_31 = getelementptr i8*, i8** %_30, i32 3
%_32 = load i8*, i8** %_31
%_33 = bitcast i8* %_32 to i8* (i8*)*
%_34 = call i8* %_33(i8* %_28)
%_35 = load i32, i32* %ifound
	ret i32 %_35
}
define i1 @Tree.Print(i8* %this) {
	%current_node = alloca i8*
	%ntb = alloca i1
%_1 = bitcast i8* %this to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 19
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i1 (i8*,i8*)*
%_6 = call i1 %_5(i8* %this, i8* %current_node)
%_7 = load i1, i1* true
	ret i1 %_7
}
define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
	%node = alloca i8*
	store i8* %.node, i8** %node
	%ntb = alloca i1
%_0 = load i8*, i8** %node
%_1 = bitcast i8* %_0 to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 8
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i1 (i8*)*
%_6 = call i1 %_5(i8* %_0)
%_8 = bitcast i8* %this to i8***
%_9 = load i8**, i8*** %_8
%_10 = getelementptr i8*, i8** %_9, i32 19
%_11 = load i8*, i8** %_10
%_12 = bitcast i8* %_11 to i1 (i8*,i8*)*
%_14 = load i8*, i8** %node
%_15 = bitcast i8* %_14 to i8***
%_16 = load i8**, i8*** %_15
%_17 = getelementptr i8*, i8** %_16, i32 4
%_18 = load i8*, i8** %_17
%_19 = bitcast i8* %_18 to i8* (i8*)*
%_20 = call i8* %_19(i8* %_14)
%_13 = call i1 %_12(i8* %this, i8* %_20)
%_21 = load i8*, i8** %node
%_22 = bitcast i8* %_21 to i8***
%_23 = load i8**, i8*** %_22
%_24 = getelementptr i8*, i8** %_23, i32 5
%_25 = load i8*, i8** %_24
%_26 = bitcast i8* %_25 to i32 (i8*)*
%_27 = call i32 %_26(i8* %_21)
%_28 = load i8*, i8** %node
%_29 = bitcast i8* %_28 to i8***
%_30 = load i8**, i8*** %_29
%_31 = getelementptr i8*, i8** %_30, i32 7
%_32 = load i8*, i8** %_31
%_33 = bitcast i8* %_32 to i1 (i8*)*
%_34 = call i1 %_33(i8* %_28)
%_36 = bitcast i8* %this to i8***
%_37 = load i8**, i8*** %_36
%_38 = getelementptr i8*, i8** %_37, i32 19
%_39 = load i8*, i8** %_38
%_40 = bitcast i8* %_39 to i1 (i8*,i8*)*
%_42 = load i8*, i8** %node
%_43 = bitcast i8* %_42 to i8***
%_44 = load i8**, i8*** %_43
%_45 = getelementptr i8*, i8** %_44, i32 3
%_46 = load i8*, i8** %_45
%_47 = bitcast i8* %_46 to i8* (i8*)*
%_48 = call i8* %_47(i8* %_42)
%_41 = call i1 %_40(i8* %this, i8* %_48)
%_49 = load i1, i1* true
	ret i1 %_49
}
