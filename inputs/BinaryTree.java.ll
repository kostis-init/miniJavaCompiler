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
	%_1 = bitcast i8* %_7 to i8***
	%_2 = load i8**, i8*** %_1
	%_3 = getelementptr i8*, i8** %_2, i32 0
	%_4 = load i8*, i8** %_3
	%_5 = bitcast i8* %_4 to i32 (i8*)*
	%_6 = call i32 %_5(i8* %_7)
	call void (i32) @print_int(i32 %_6)

	ret i32 0
}
define i32 @BT.Start(i8* %this) {
	%root = alloca i8*
	%ntb = alloca i1
	%nti = alloca i32
	%_4 = call i8* @calloc(i32 1, i32 38)
	%_5 = bitcast i8* %_4 to i8***
	%_6 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	store i8** %_6,i8*** %_5
	store i8* %_4, i8** %root	%_15 = load i8*, i8** %root
	%_9 = bitcast i8* %_15 to i8***
	%_10 = load i8**, i8*** %_9
	%_11 = getelementptr i8*, i8** %_10, i32 0
	%_12 = load i8*, i8** %_11
	%_13 = bitcast i8* %_12 to i1 (i8*,i32)*
	%_14 = call i1 %_13(i8* %_15, i32 16)
	store i1 %_14, i1* %ntb	%_24 = load i8*, i8** %root
	%_18 = bitcast i8* %_24 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 18
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i1 (i8*)*
	%_23 = call i1 %_22(i8* %_24)
	store i1 %_23, i1* %ntb	call void (i32) @print_int(i32 100000000)
	%_33 = load i8*, i8** %root
	%_27 = bitcast i8* %_33 to i8***
	%_28 = load i8**, i8*** %_27
	%_29 = getelementptr i8*, i8** %_28, i32 12
	%_30 = load i8*, i8** %_29
	%_31 = bitcast i8* %_30 to i1 (i8*,i32)*
	%_32 = call i1 %_31(i8* %_33, i32 8)
	store i1 %_32, i1* %ntb	%_42 = load i8*, i8** %root
	%_36 = bitcast i8* %_42 to i8***
	%_37 = load i8**, i8*** %_36
	%_38 = getelementptr i8*, i8** %_37, i32 18
	%_39 = load i8*, i8** %_38
	%_40 = bitcast i8* %_39 to i1 (i8*)*
	%_41 = call i1 %_40(i8* %_42)
	store i1 %_41, i1* %ntb	%_51 = load i8*, i8** %root
	%_45 = bitcast i8* %_51 to i8***
	%_46 = load i8**, i8*** %_45
	%_47 = getelementptr i8*, i8** %_46, i32 12
	%_48 = load i8*, i8** %_47
	%_49 = bitcast i8* %_48 to i1 (i8*,i32)*
	%_50 = call i1 %_49(i8* %_51, i32 24)
	store i1 %_50, i1* %ntb	%_60 = load i8*, i8** %root
	%_54 = bitcast i8* %_60 to i8***
	%_55 = load i8**, i8*** %_54
	%_56 = getelementptr i8*, i8** %_55, i32 12
	%_57 = load i8*, i8** %_56
	%_58 = bitcast i8* %_57 to i1 (i8*,i32)*
	%_59 = call i1 %_58(i8* %_60, i32 4)
	store i1 %_59, i1* %ntb	%_69 = load i8*, i8** %root
	%_63 = bitcast i8* %_69 to i8***
	%_64 = load i8**, i8*** %_63
	%_65 = getelementptr i8*, i8** %_64, i32 12
	%_66 = load i8*, i8** %_65
	%_67 = bitcast i8* %_66 to i1 (i8*,i32)*
	%_68 = call i1 %_67(i8* %_69, i32 12)
	store i1 %_68, i1* %ntb	%_78 = load i8*, i8** %root
	%_72 = bitcast i8* %_78 to i8***
	%_73 = load i8**, i8*** %_72
	%_74 = getelementptr i8*, i8** %_73, i32 12
	%_75 = load i8*, i8** %_74
	%_76 = bitcast i8* %_75 to i1 (i8*,i32)*
	%_77 = call i1 %_76(i8* %_78, i32 20)
	store i1 %_77, i1* %ntb	%_87 = load i8*, i8** %root
	%_81 = bitcast i8* %_87 to i8***
	%_82 = load i8**, i8*** %_81
	%_83 = getelementptr i8*, i8** %_82, i32 12
	%_84 = load i8*, i8** %_83
	%_85 = bitcast i8* %_84 to i1 (i8*,i32)*
	%_86 = call i1 %_85(i8* %_87, i32 28)
	store i1 %_86, i1* %ntb	%_96 = load i8*, i8** %root
	%_90 = bitcast i8* %_96 to i8***
	%_91 = load i8**, i8*** %_90
	%_92 = getelementptr i8*, i8** %_91, i32 12
	%_93 = load i8*, i8** %_92
	%_94 = bitcast i8* %_93 to i1 (i8*,i32)*
	%_95 = call i1 %_94(i8* %_96, i32 14)
	store i1 %_95, i1* %ntb	%_105 = load i8*, i8** %root
	%_99 = bitcast i8* %_105 to i8***
	%_100 = load i8**, i8*** %_99
	%_101 = getelementptr i8*, i8** %_100, i32 18
	%_102 = load i8*, i8** %_101
	%_103 = bitcast i8* %_102 to i1 (i8*)*
	%_104 = call i1 %_103(i8* %_105)
	store i1 %_104, i1* %ntb	%_113 = load i8*, i8** %root
	%_107 = bitcast i8* %_113 to i8***
	%_108 = load i8**, i8*** %_107
	%_109 = getelementptr i8*, i8** %_108, i32 17
	%_110 = load i8*, i8** %_109
	%_111 = bitcast i8* %_110 to i32 (i8*,i32)*
	%_112 = call i32 %_111(i8* %_113, i32 24)
	call void (i32) @print_int(i32 %_112)
	%_121 = load i8*, i8** %root
	%_115 = bitcast i8* %_121 to i8***
	%_116 = load i8**, i8*** %_115
	%_117 = getelementptr i8*, i8** %_116, i32 17
	%_118 = load i8*, i8** %_117
	%_119 = bitcast i8* %_118 to i32 (i8*,i32)*
	%_120 = call i32 %_119(i8* %_121, i32 12)
	call void (i32) @print_int(i32 %_120)
	%_129 = load i8*, i8** %root
	%_123 = bitcast i8* %_129 to i8***
	%_124 = load i8**, i8*** %_123
	%_125 = getelementptr i8*, i8** %_124, i32 17
	%_126 = load i8*, i8** %_125
	%_127 = bitcast i8* %_126 to i32 (i8*,i32)*
	%_128 = call i32 %_127(i8* %_129, i32 16)
	call void (i32) @print_int(i32 %_128)
	%_137 = load i8*, i8** %root
	%_131 = bitcast i8* %_137 to i8***
	%_132 = load i8**, i8*** %_131
	%_133 = getelementptr i8*, i8** %_132, i32 17
	%_134 = load i8*, i8** %_133
	%_135 = bitcast i8* %_134 to i32 (i8*,i32)*
	%_136 = call i32 %_135(i8* %_137, i32 50)
	call void (i32) @print_int(i32 %_136)
	%_145 = load i8*, i8** %root
	%_139 = bitcast i8* %_145 to i8***
	%_140 = load i8**, i8*** %_139
	%_141 = getelementptr i8*, i8** %_140, i32 17
	%_142 = load i8*, i8** %_141
	%_143 = bitcast i8* %_142 to i32 (i8*,i32)*
	%_144 = call i32 %_143(i8* %_145, i32 12)
	call void (i32) @print_int(i32 %_144)
	%_154 = load i8*, i8** %root
	%_148 = bitcast i8* %_154 to i8***
	%_149 = load i8**, i8*** %_148
	%_150 = getelementptr i8*, i8** %_149, i32 13
	%_151 = load i8*, i8** %_150
	%_152 = bitcast i8* %_151 to i1 (i8*,i32)*
	%_153 = call i1 %_152(i8* %_154, i32 12)
	store i1 %_153, i1* %ntb	%_163 = load i8*, i8** %root
	%_157 = bitcast i8* %_163 to i8***
	%_158 = load i8**, i8*** %_157
	%_159 = getelementptr i8*, i8** %_158, i32 18
	%_160 = load i8*, i8** %_159
	%_161 = bitcast i8* %_160 to i1 (i8*)*
	%_162 = call i1 %_161(i8* %_163)
	store i1 %_162, i1* %ntb	%_171 = load i8*, i8** %root
	%_165 = bitcast i8* %_171 to i8***
	%_166 = load i8**, i8*** %_165
	%_167 = getelementptr i8*, i8** %_166, i32 17
	%_168 = load i8*, i8** %_167
	%_169 = bitcast i8* %_168 to i32 (i8*,i32)*
	%_170 = call i32 %_169(i8* %_171, i32 12)
	call void (i32) @print_int(i32 %_170)

	ret i32 0
}
define i1 @Tree.Init(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i32*
	%_3 = load i32, i32* %v_key
	store i32 %_3, i32* %_1	%_4 = getelementptr i8, i8* %this, i32 28
	%_5 = bitcast i8* %_4 to i1*
	store i1 0, i1* %_5	%_7 = getelementptr i8, i8* %this, i32 29
	%_8 = bitcast i8* %_7 to i1*
	store i1 0, i1* %_8
	ret i1 1
}
define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
	%rn = alloca i8*
	store i8* %.rn, i8** %rn
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i8**
	%_3 = load i8*, i8** %rn
	store i8* %_3, i8** %_1
	ret i1 1
}
define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
	%ln = alloca i8*
	store i8* %.ln, i8** %ln
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i8**
	%_3 = load i8*, i8** %ln
	store i8* %_3, i8** %_1
	ret i1 1
}
define i8* @Tree.GetRight(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1

	ret i8* %_2
}
define i8* @Tree.GetLeft(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1

	ret i8* %_2
}
define i32 @Tree.GetKey(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1

	ret i32 %_2
}
define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i32*
	%_3 = load i32, i32* %v_key
	store i32 %_3, i32* %_1
	ret i1 1
}
define i1 @Tree.GetHas_Right(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 29
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1

	ret i1 %_2
}
define i1 @Tree.GetHas_Left(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 28
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1

	ret i1 %_2
}
define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_0 = getelementptr i8, i8* %this, i32 28
	%_1 = bitcast i8* %_0 to i1*
	%_3 = load i1, i1* %val
	store i1 %_3, i1* %_1
	ret i1 1
}
define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_0 = getelementptr i8, i8* %this, i32 29
	%_1 = bitcast i8* %_0 to i1*
	%_3 = load i1, i1* %val
	store i1 %_3, i1* %_1
	ret i1 1
}
define i1 @Tree.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%ntb = alloca i1
	%nti = alloca i32
	store i1 0, i1* %ntb	%_5 = load i32, i32* %num2
	%_4 = add i32 %_5, 1	store i32 %_4, i32* %nti	%_7 = load i32, i32* %num1
	%_8 = load i32, i32* %num2
	%_6 = icmp slt i32 %_7, %_8	br i1 %_6, label %if0, label %if1

if0:
	store i1 0, i1* %ntb	br label %if2

if1:
	%_12 = load i32, i32* %num1
	%_13 = load i32, i32* %nti
	%_11 = icmp slt i32 %_12, %_13	%_10 = xor i1 1, %_11	br i1 %_10, label %if3, label %if4

if3:
	store i1 0, i1* %ntb	br label %if5

if4:
	store i1 1, i1* %ntb	br label %if5

if5:
	br label %if2

if2:
	%_16 = load i1, i1* %ntb

	ret i1 %_16
}
define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%new_node = alloca i8*
	%ntb = alloca i1
	%cont = alloca i1
	%key_aux = alloca i32
	%current_node = alloca i8*
	%_6 = call i8* @calloc(i32 1, i32 38)
	%_7 = bitcast i8* %_6 to i8***
	%_8 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	store i8** %_8,i8*** %_7
	store i8* %_6, i8** %new_node	%_17 = load i8*, i8** %new_node
	%_11 = bitcast i8* %_17 to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 0
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i1 (i8*,i32)*
	%_18 = load i32, i32* %v_key
	%_16 = call i1 %_15(i8* %_17, i32 %_18)
	store i1 %_16, i1* %ntb	store i8* %this, i8** %current_node	store i1 1, i1* %cont	br label %loop0

loop0:
	%_21 = load i1, i1* %cont
	br i1 %_21, label %loop1, label %loop2

loop1:
	%_30 = load i8*, i8** %current_node
	%_24 = bitcast i8* %_30 to i8***
	%_25 = load i8**, i8*** %_24
	%_26 = getelementptr i8*, i8** %_25, i32 5
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i32 (i8*)*
	%_29 = call i32 %_28(i8* %_30)
	store i32 %_29, i32* %key_aux	%_32 = load i32, i32* %v_key
	%_33 = load i32, i32* %key_aux
	%_31 = icmp slt i32 %_32, %_33	br i1 %_31, label %if0, label %if1

if0:
	%_41 = load i8*, i8** %current_node
	%_35 = bitcast i8* %_41 to i8***
	%_36 = load i8**, i8*** %_35
	%_37 = getelementptr i8*, i8** %_36, i32 8
	%_38 = load i8*, i8** %_37
	%_39 = bitcast i8* %_38 to i1 (i8*)*
	%_40 = call i1 %_39(i8* %_41)
	br i1 %_40, label %if3, label %if4

if3:
	%_50 = load i8*, i8** %current_node
	%_44 = bitcast i8* %_50 to i8***
	%_45 = load i8**, i8*** %_44
	%_46 = getelementptr i8*, i8** %_45, i32 4
	%_47 = load i8*, i8** %_46
	%_48 = bitcast i8* %_47 to i8* (i8*)*
	%_49 = call i8* %_48(i8* %_50)
	store i8* %_49, i8** %current_node	br label %if5

if4:
	store i1 0, i1* %cont	%_60 = load i8*, i8** %current_node
	%_54 = bitcast i8* %_60 to i8***
	%_55 = load i8**, i8*** %_54
	%_56 = getelementptr i8*, i8** %_55, i32 9
	%_57 = load i8*, i8** %_56
	%_58 = bitcast i8* %_57 to i1 (i8*,i1)*
	%_59 = call i1 %_58(i8* %_60, i1 1)
	store i1 %_59, i1* %ntb	%_69 = load i8*, i8** %current_node
	%_63 = bitcast i8* %_69 to i8***
	%_64 = load i8**, i8*** %_63
	%_65 = getelementptr i8*, i8** %_64, i32 2
	%_66 = load i8*, i8** %_65
	%_67 = bitcast i8* %_66 to i1 (i8*,i8*)*
	%_70 = load i8*, i8** %new_node
	%_68 = call i1 %_67(i8* %_69, i8* %_70)
	store i1 %_68, i1* %ntb	br label %if5

if5:
	br label %if2

if1:
	%_78 = load i8*, i8** %current_node
	%_72 = bitcast i8* %_78 to i8***
	%_73 = load i8**, i8*** %_72
	%_74 = getelementptr i8*, i8** %_73, i32 7
	%_75 = load i8*, i8** %_74
	%_76 = bitcast i8* %_75 to i1 (i8*)*
	%_77 = call i1 %_76(i8* %_78)
	br i1 %_77, label %if6, label %if7

if6:
	%_87 = load i8*, i8** %current_node
	%_81 = bitcast i8* %_87 to i8***
	%_82 = load i8**, i8*** %_81
	%_83 = getelementptr i8*, i8** %_82, i32 3
	%_84 = load i8*, i8** %_83
	%_85 = bitcast i8* %_84 to i8* (i8*)*
	%_86 = call i8* %_85(i8* %_87)
	store i8* %_86, i8** %current_node	br label %if8

if7:
	store i1 0, i1* %cont	%_97 = load i8*, i8** %current_node
	%_91 = bitcast i8* %_97 to i8***
	%_92 = load i8**, i8*** %_91
	%_93 = getelementptr i8*, i8** %_92, i32 10
	%_94 = load i8*, i8** %_93
	%_95 = bitcast i8* %_94 to i1 (i8*,i1)*
	%_96 = call i1 %_95(i8* %_97, i1 1)
	store i1 %_96, i1* %ntb	%_106 = load i8*, i8** %current_node
	%_100 = bitcast i8* %_106 to i8***
	%_101 = load i8**, i8*** %_100
	%_102 = getelementptr i8*, i8** %_101, i32 1
	%_103 = load i8*, i8** %_102
	%_104 = bitcast i8* %_103 to i1 (i8*,i8*)*
	%_107 = load i8*, i8** %new_node
	%_105 = call i1 %_104(i8* %_106, i8* %_107)
	store i1 %_105, i1* %ntb	br label %if8

if8:
	br label %if2

if2:
	br label %loop0

loop2:

	ret i1 1
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
	store i8* %this, i8** %current_node	store i8* %this, i8** %parent_node	store i1 1, i1* %cont	store i1 0, i1* %found	store i1 1, i1* %is_root	br label %loop0

loop0:
	%_12 = load i1, i1* %cont
	br i1 %_12, label %loop1, label %loop2

loop1:
	%_21 = load i8*, i8** %current_node
	%_15 = bitcast i8* %_21 to i8***
	%_16 = load i8**, i8*** %_15
	%_17 = getelementptr i8*, i8** %_16, i32 5
	%_18 = load i8*, i8** %_17
	%_19 = bitcast i8* %_18 to i32 (i8*)*
	%_20 = call i32 %_19(i8* %_21)
	store i32 %_20, i32* %key_aux	%_23 = load i32, i32* %v_key
	%_24 = load i32, i32* %key_aux
	%_22 = icmp slt i32 %_23, %_24	br i1 %_22, label %if0, label %if1

if0:
	%_32 = load i8*, i8** %current_node
	%_26 = bitcast i8* %_32 to i8***
	%_27 = load i8**, i8*** %_26
	%_28 = getelementptr i8*, i8** %_27, i32 8
	%_29 = load i8*, i8** %_28
	%_30 = bitcast i8* %_29 to i1 (i8*)*
	%_31 = call i1 %_30(i8* %_32)
	br i1 %_31, label %if3, label %if4

if3:
	%_34 = load i8*, i8** %current_node
	store i8* %_34, i8** %parent_node	%_43 = load i8*, i8** %current_node
	%_37 = bitcast i8* %_43 to i8***
	%_38 = load i8**, i8*** %_37
	%_39 = getelementptr i8*, i8** %_38, i32 4
	%_40 = load i8*, i8** %_39
	%_41 = bitcast i8* %_40 to i8* (i8*)*
	%_42 = call i8* %_41(i8* %_43)
	store i8* %_42, i8** %current_node	br label %if5

if4:
	store i1 0, i1* %cont	br label %if5

if5:
	br label %if2

if1:
	%_46 = load i32, i32* %key_aux
	%_47 = load i32, i32* %v_key
	%_45 = icmp slt i32 %_46, %_47	br i1 %_45, label %if6, label %if7

if6:
	%_55 = load i8*, i8** %current_node
	%_49 = bitcast i8* %_55 to i8***
	%_50 = load i8**, i8*** %_49
	%_51 = getelementptr i8*, i8** %_50, i32 7
	%_52 = load i8*, i8** %_51
	%_53 = bitcast i8* %_52 to i1 (i8*)*
	%_54 = call i1 %_53(i8* %_55)
	br i1 %_54, label %if9, label %if10

if9:
	%_57 = load i8*, i8** %current_node
	store i8* %_57, i8** %parent_node	%_66 = load i8*, i8** %current_node
	%_60 = bitcast i8* %_66 to i8***
	%_61 = load i8**, i8*** %_60
	%_62 = getelementptr i8*, i8** %_61, i32 3
	%_63 = load i8*, i8** %_62
	%_64 = bitcast i8* %_63 to i8* (i8*)*
	%_65 = call i8* %_64(i8* %_66)
	store i8* %_65, i8** %current_node	br label %if11

if10:
	store i1 0, i1* %cont	br label %if11

if11:
	br label %if8

if7:
	%_68 = load i1, i1* %is_root
	br i1 %_68, label %if12, label %if13

if12:
	%_78 = load i8*, i8** %current_node
	%_72 = bitcast i8* %_78 to i8***
	%_73 = load i8**, i8*** %_72
	%_74 = getelementptr i8*, i8** %_73, i32 7
	%_75 = load i8*, i8** %_74
	%_76 = bitcast i8* %_75 to i1 (i8*)*
	%_77 = call i1 %_76(i8* %_78)
	%_70 = xor i1 1, %_77	br label %andClause0

andClause0:
	br i1 %_70, label %andClause1, label %andClause3

andClause1:
	%_87 = load i8*, i8** %current_node
	%_81 = bitcast i8* %_87 to i8***
	%_82 = load i8**, i8*** %_81
	%_83 = getelementptr i8*, i8** %_82, i32 8
	%_84 = load i8*, i8** %_83
	%_85 = bitcast i8* %_84 to i1 (i8*)*
	%_86 = call i1 %_85(i8* %_87)
	%_79 = xor i1 1, %_86	br label %andClause2

andClause2:
	br label %andClause3

andClause3:
	%_69 = phi i1 [ 0, %andClause0 ], [ %_79, %andClause2 ]
	br i1 %_69, label %if15, label %if16

if15:
	store i1 1, i1* %ntb	br label %if17

if16:
	%_91 = bitcast i8* %this to i8***
	%_92 = load i8**, i8*** %_91
	%_93 = getelementptr i8*, i8** %_92, i32 14
	%_94 = load i8*, i8** %_93
	%_95 = bitcast i8* %_94 to i1 (i8*,i8*,i8*)*
	%_97 = load i8*, i8** %parent_node
	%_98 = load i8*, i8** %current_node
	%_96 = call i1 %_95(i8* %this, i8* %_97, i8* %_98)
	store i1 %_96, i1* %ntb	br label %if17

if17:
	br label %if14

if13:
	%_101 = bitcast i8* %this to i8***
	%_102 = load i8**, i8*** %_101
	%_103 = getelementptr i8*, i8** %_102, i32 14
	%_104 = load i8*, i8** %_103
	%_105 = bitcast i8* %_104 to i1 (i8*,i8*,i8*)*
	%_107 = load i8*, i8** %parent_node
	%_108 = load i8*, i8** %current_node
	%_106 = call i1 %_105(i8* %this, i8* %_107, i8* %_108)
	store i1 %_106, i1* %ntb	br label %if14

if14:
	store i1 1, i1* %found	store i1 0, i1* %cont	br label %if8

if8:
	br label %if2

if2:
	store i1 0, i1* %is_root	br label %loop0

loop2:
	%_112 = load i1, i1* %found

	ret i1 %_112
}
define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	%auxkey1 = alloca i32
	%auxkey2 = alloca i32
	%_10 = load i8*, i8** %c_node
	%_4 = bitcast i8* %_10 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 8
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*)*
	%_9 = call i1 %_8(i8* %_10)
	br i1 %_9, label %if0, label %if1

if0:
	%_13 = bitcast i8* %this to i8***
	%_14 = load i8**, i8*** %_13
	%_15 = getelementptr i8*, i8** %_14, i32 16
	%_16 = load i8*, i8** %_15
	%_17 = bitcast i8* %_16 to i1 (i8*,i8*,i8*)*
	%_19 = load i8*, i8** %p_node
	%_20 = load i8*, i8** %c_node
	%_18 = call i1 %_17(i8* %this, i8* %_19, i8* %_20)
	store i1 %_18, i1* %ntb	br label %if2

if1:
	%_28 = load i8*, i8** %c_node
	%_22 = bitcast i8* %_28 to i8***
	%_23 = load i8**, i8*** %_22
	%_24 = getelementptr i8*, i8** %_23, i32 7
	%_25 = load i8*, i8** %_24
	%_26 = bitcast i8* %_25 to i1 (i8*)*
	%_27 = call i1 %_26(i8* %_28)
	br i1 %_27, label %if3, label %if4

if3:
	%_31 = bitcast i8* %this to i8***
	%_32 = load i8**, i8*** %_31
	%_33 = getelementptr i8*, i8** %_32, i32 15
	%_34 = load i8*, i8** %_33
	%_35 = bitcast i8* %_34 to i1 (i8*,i8*,i8*)*
	%_37 = load i8*, i8** %p_node
	%_38 = load i8*, i8** %c_node
	%_36 = call i1 %_35(i8* %this, i8* %_37, i8* %_38)
	store i1 %_36, i1* %ntb	br label %if5

if4:
	%_47 = load i8*, i8** %c_node
	%_41 = bitcast i8* %_47 to i8***
	%_42 = load i8**, i8*** %_41
	%_43 = getelementptr i8*, i8** %_42, i32 5
	%_44 = load i8*, i8** %_43
	%_45 = bitcast i8* %_44 to i32 (i8*)*
	%_46 = call i32 %_45(i8* %_47)
	store i32 %_46, i32* %auxkey1	%_63 = load i8*, i8** %p_node
	%_57 = bitcast i8* %_63 to i8***
	%_58 = load i8**, i8*** %_57
	%_59 = getelementptr i8*, i8** %_58, i32 4
	%_60 = load i8*, i8** %_59
	%_61 = bitcast i8* %_60 to i8* (i8*)*
	%_62 = call i8* %_61(i8* %_63)
	%_50 = bitcast i8* %_62 to i8***
	%_51 = load i8**, i8*** %_50
	%_52 = getelementptr i8*, i8** %_51, i32 5
	%_53 = load i8*, i8** %_52
	%_54 = bitcast i8* %_53 to i32 (i8*)*
	%_55 = call i32 %_54(i8* %_62)
	store i32 %_55, i32* %auxkey2	%_65 = bitcast i8* %this to i8***
	%_66 = load i8**, i8*** %_65
	%_67 = getelementptr i8*, i8** %_66, i32 11
	%_68 = load i8*, i8** %_67
	%_69 = bitcast i8* %_68 to i1 (i8*,i32,i32)*
	%_71 = load i32, i32* %auxkey1
	%_72 = load i32, i32* %auxkey2
	%_70 = call i1 %_69(i8* %this, i32 %_71, i32 %_72)
	br i1 %_70, label %if6, label %if7

if6:
	%_81 = load i8*, i8** %p_node
	%_75 = bitcast i8* %_81 to i8***
	%_76 = load i8**, i8*** %_75
	%_77 = getelementptr i8*, i8** %_76, i32 2
	%_78 = load i8*, i8** %_77
	%_79 = bitcast i8* %_78 to i1 (i8*,i8*)*
	%_82 = getelementptr i8, i8* %this, i32 30
	%_83 = bitcast i8* %_82 to i8**
	%_84 = load i8*, i8** %_83
	%_80 = call i1 %_79(i8* %_81, i8* %_84)
	store i1 %_80, i1* %ntb	%_93 = load i8*, i8** %p_node
	%_87 = bitcast i8* %_93 to i8***
	%_88 = load i8**, i8*** %_87
	%_89 = getelementptr i8*, i8** %_88, i32 9
	%_90 = load i8*, i8** %_89
	%_91 = bitcast i8* %_90 to i1 (i8*,i1)*
	%_92 = call i1 %_91(i8* %_93, i1 0)
	store i1 %_92, i1* %ntb	br label %if8

if7:
	%_102 = load i8*, i8** %p_node
	%_96 = bitcast i8* %_102 to i8***
	%_97 = load i8**, i8*** %_96
	%_98 = getelementptr i8*, i8** %_97, i32 1
	%_99 = load i8*, i8** %_98
	%_100 = bitcast i8* %_99 to i1 (i8*,i8*)*
	%_103 = getelementptr i8, i8* %this, i32 30
	%_104 = bitcast i8* %_103 to i8**
	%_105 = load i8*, i8** %_104
	%_101 = call i1 %_100(i8* %_102, i8* %_105)
	store i1 %_101, i1* %ntb	%_114 = load i8*, i8** %p_node
	%_108 = bitcast i8* %_114 to i8***
	%_109 = load i8**, i8*** %_108
	%_110 = getelementptr i8*, i8** %_109, i32 10
	%_111 = load i8*, i8** %_110
	%_112 = bitcast i8* %_111 to i1 (i8*,i1)*
	%_113 = call i1 %_112(i8* %_114, i1 0)
	store i1 %_113, i1* %ntb	br label %if8

if8:
	br label %if5

if5:
	br label %if2

if2:

	ret i1 1
}
define i1 @Tree.RemoveRight(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	br label %loop0

loop0:
	%_8 = load i8*, i8** %c_node
	%_2 = bitcast i8* %_8 to i8***
	%_3 = load i8**, i8*** %_2
	%_4 = getelementptr i8*, i8** %_3, i32 7
	%_5 = load i8*, i8** %_4
	%_6 = bitcast i8* %_5 to i1 (i8*)*
	%_7 = call i1 %_6(i8* %_8)
	br i1 %_7, label %loop1, label %loop2

loop1:
	%_17 = load i8*, i8** %c_node
	%_11 = bitcast i8* %_17 to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 6
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i1 (i8*,i32)*
	%_32 = load i8*, i8** %c_node
	%_26 = bitcast i8* %_32 to i8***
	%_27 = load i8**, i8*** %_26
	%_28 = getelementptr i8*, i8** %_27, i32 3
	%_29 = load i8*, i8** %_28
	%_30 = bitcast i8* %_29 to i8* (i8*)*
	%_31 = call i8* %_30(i8* %_32)
	%_19 = bitcast i8* %_31 to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 5
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i32 (i8*)*
	%_24 = call i32 %_23(i8* %_31)
	%_16 = call i1 %_15(i8* %_17, i32 %_24)
	store i1 %_16, i1* %ntb	%_34 = load i8*, i8** %c_node
	store i8* %_34, i8** %p_node	%_43 = load i8*, i8** %c_node
	%_37 = bitcast i8* %_43 to i8***
	%_38 = load i8**, i8*** %_37
	%_39 = getelementptr i8*, i8** %_38, i32 3
	%_40 = load i8*, i8** %_39
	%_41 = bitcast i8* %_40 to i8* (i8*)*
	%_42 = call i8* %_41(i8* %_43)
	store i8* %_42, i8** %c_node	br label %loop0

loop2:
	%_52 = load i8*, i8** %p_node
	%_46 = bitcast i8* %_52 to i8***
	%_47 = load i8**, i8*** %_46
	%_48 = getelementptr i8*, i8** %_47, i32 1
	%_49 = load i8*, i8** %_48
	%_50 = bitcast i8* %_49 to i1 (i8*,i8*)*
	%_53 = getelementptr i8, i8* %this, i32 30
	%_54 = bitcast i8* %_53 to i8**
	%_55 = load i8*, i8** %_54
	%_51 = call i1 %_50(i8* %_52, i8* %_55)
	store i1 %_51, i1* %ntb	%_64 = load i8*, i8** %p_node
	%_58 = bitcast i8* %_64 to i8***
	%_59 = load i8**, i8*** %_58
	%_60 = getelementptr i8*, i8** %_59, i32 10
	%_61 = load i8*, i8** %_60
	%_62 = bitcast i8* %_61 to i1 (i8*,i1)*
	%_63 = call i1 %_62(i8* %_64, i1 0)
	store i1 %_63, i1* %ntb
	ret i1 1
}
define i1 @Tree.RemoveLeft(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	br label %loop0

loop0:
	%_8 = load i8*, i8** %c_node
	%_2 = bitcast i8* %_8 to i8***
	%_3 = load i8**, i8*** %_2
	%_4 = getelementptr i8*, i8** %_3, i32 8
	%_5 = load i8*, i8** %_4
	%_6 = bitcast i8* %_5 to i1 (i8*)*
	%_7 = call i1 %_6(i8* %_8)
	br i1 %_7, label %loop1, label %loop2

loop1:
	%_17 = load i8*, i8** %c_node
	%_11 = bitcast i8* %_17 to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 6
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i1 (i8*,i32)*
	%_32 = load i8*, i8** %c_node
	%_26 = bitcast i8* %_32 to i8***
	%_27 = load i8**, i8*** %_26
	%_28 = getelementptr i8*, i8** %_27, i32 4
	%_29 = load i8*, i8** %_28
	%_30 = bitcast i8* %_29 to i8* (i8*)*
	%_31 = call i8* %_30(i8* %_32)
	%_19 = bitcast i8* %_31 to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 5
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i32 (i8*)*
	%_24 = call i32 %_23(i8* %_31)
	%_16 = call i1 %_15(i8* %_17, i32 %_24)
	store i1 %_16, i1* %ntb	%_34 = load i8*, i8** %c_node
	store i8* %_34, i8** %p_node	%_43 = load i8*, i8** %c_node
	%_37 = bitcast i8* %_43 to i8***
	%_38 = load i8**, i8*** %_37
	%_39 = getelementptr i8*, i8** %_38, i32 4
	%_40 = load i8*, i8** %_39
	%_41 = bitcast i8* %_40 to i8* (i8*)*
	%_42 = call i8* %_41(i8* %_43)
	store i8* %_42, i8** %c_node	br label %loop0

loop2:
	%_52 = load i8*, i8** %p_node
	%_46 = bitcast i8* %_52 to i8***
	%_47 = load i8**, i8*** %_46
	%_48 = getelementptr i8*, i8** %_47, i32 2
	%_49 = load i8*, i8** %_48
	%_50 = bitcast i8* %_49 to i1 (i8*,i8*)*
	%_53 = getelementptr i8, i8* %this, i32 30
	%_54 = bitcast i8* %_53 to i8**
	%_55 = load i8*, i8** %_54
	%_51 = call i1 %_50(i8* %_52, i8* %_55)
	store i1 %_51, i1* %ntb	%_64 = load i8*, i8** %p_node
	%_58 = bitcast i8* %_64 to i8***
	%_59 = load i8**, i8*** %_58
	%_60 = getelementptr i8*, i8** %_59, i32 9
	%_61 = load i8*, i8** %_60
	%_62 = bitcast i8* %_61 to i1 (i8*,i1)*
	%_63 = call i1 %_62(i8* %_64, i1 0)
	store i1 %_63, i1* %ntb
	ret i1 1
}
define i32 @Tree.Search(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%cont = alloca i1
	%ifound = alloca i32
	%current_node = alloca i8*
	%key_aux = alloca i32
	store i8* %this, i8** %current_node	store i1 1, i1* %cont	store i32 0, i32* %ifound	br label %loop0

loop0:
	%_7 = load i1, i1* %cont
	br i1 %_7, label %loop1, label %loop2

loop1:
	%_16 = load i8*, i8** %current_node
	%_10 = bitcast i8* %_16 to i8***
	%_11 = load i8**, i8*** %_10
	%_12 = getelementptr i8*, i8** %_11, i32 5
	%_13 = load i8*, i8** %_12
	%_14 = bitcast i8* %_13 to i32 (i8*)*
	%_15 = call i32 %_14(i8* %_16)
	store i32 %_15, i32* %key_aux	%_18 = load i32, i32* %v_key
	%_19 = load i32, i32* %key_aux
	%_17 = icmp slt i32 %_18, %_19	br i1 %_17, label %if0, label %if1

if0:
	%_27 = load i8*, i8** %current_node
	%_21 = bitcast i8* %_27 to i8***
	%_22 = load i8**, i8*** %_21
	%_23 = getelementptr i8*, i8** %_22, i32 8
	%_24 = load i8*, i8** %_23
	%_25 = bitcast i8* %_24 to i1 (i8*)*
	%_26 = call i1 %_25(i8* %_27)
	br i1 %_26, label %if3, label %if4

if3:
	%_36 = load i8*, i8** %current_node
	%_30 = bitcast i8* %_36 to i8***
	%_31 = load i8**, i8*** %_30
	%_32 = getelementptr i8*, i8** %_31, i32 4
	%_33 = load i8*, i8** %_32
	%_34 = bitcast i8* %_33 to i8* (i8*)*
	%_35 = call i8* %_34(i8* %_36)
	store i8* %_35, i8** %current_node	br label %if5

if4:
	store i1 0, i1* %cont	br label %if5

if5:
	br label %if2

if1:
	%_39 = load i32, i32* %key_aux
	%_40 = load i32, i32* %v_key
	%_38 = icmp slt i32 %_39, %_40	br i1 %_38, label %if6, label %if7

if6:
	%_48 = load i8*, i8** %current_node
	%_42 = bitcast i8* %_48 to i8***
	%_43 = load i8**, i8*** %_42
	%_44 = getelementptr i8*, i8** %_43, i32 7
	%_45 = load i8*, i8** %_44
	%_46 = bitcast i8* %_45 to i1 (i8*)*
	%_47 = call i1 %_46(i8* %_48)
	br i1 %_47, label %if9, label %if10

if9:
	%_57 = load i8*, i8** %current_node
	%_51 = bitcast i8* %_57 to i8***
	%_52 = load i8**, i8*** %_51
	%_53 = getelementptr i8*, i8** %_52, i32 3
	%_54 = load i8*, i8** %_53
	%_55 = bitcast i8* %_54 to i8* (i8*)*
	%_56 = call i8* %_55(i8* %_57)
	store i8* %_56, i8** %current_node	br label %if11

if10:
	store i1 0, i1* %cont	br label %if11

if11:
	br label %if8

if7:
	store i32 1, i32* %ifound	store i1 0, i1* %cont	br label %if8

if8:
	br label %if2

if2:
	br label %loop0

loop2:
	%_61 = load i32, i32* %ifound

	ret i32 %_61
}
define i1 @Tree.Print(i8* %this) {
	%current_node = alloca i8*
	%ntb = alloca i1
	store i8* %this, i8** %current_node	%_5 = bitcast i8* %this to i8***
	%_6 = load i8**, i8*** %_5
	%_7 = getelementptr i8*, i8** %_6, i32 19
	%_8 = load i8*, i8** %_7
	%_9 = bitcast i8* %_8 to i1 (i8*,i8*)*
	%_11 = load i8*, i8** %current_node
	%_10 = call i1 %_9(i8* %this, i8* %_11)
	store i1 %_10, i1* %ntb
	ret i1 1
}
define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
	%node = alloca i8*
	store i8* %.node, i8** %node
	%ntb = alloca i1
	%_8 = load i8*, i8** %node
	%_2 = bitcast i8* %_8 to i8***
	%_3 = load i8**, i8*** %_2
	%_4 = getelementptr i8*, i8** %_3, i32 8
	%_5 = load i8*, i8** %_4
	%_6 = bitcast i8* %_5 to i1 (i8*)*
	%_7 = call i1 %_6(i8* %_8)
	br i1 %_7, label %if0, label %if1

if0:
	%_11 = bitcast i8* %this to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 19
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i1 (i8*,i8*)*
	%_24 = load i8*, i8** %node
	%_18 = bitcast i8* %_24 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 4
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i8* (i8*)*
	%_23 = call i8* %_22(i8* %_24)
	%_16 = call i1 %_15(i8* %this, i8* %_23)
	store i1 %_16, i1* %ntb	br label %if2

if1:
	store i1 1, i1* %ntb	br label %if2

if2:
	%_33 = load i8*, i8** %node
	%_27 = bitcast i8* %_33 to i8***
	%_28 = load i8**, i8*** %_27
	%_29 = getelementptr i8*, i8** %_28, i32 5
	%_30 = load i8*, i8** %_29
	%_31 = bitcast i8* %_30 to i32 (i8*)*
	%_32 = call i32 %_31(i8* %_33)
	call void (i32) @print_int(i32 %_32)
	%_41 = load i8*, i8** %node
	%_35 = bitcast i8* %_41 to i8***
	%_36 = load i8**, i8*** %_35
	%_37 = getelementptr i8*, i8** %_36, i32 7
	%_38 = load i8*, i8** %_37
	%_39 = bitcast i8* %_38 to i1 (i8*)*
	%_40 = call i1 %_39(i8* %_41)
	br i1 %_40, label %if3, label %if4

if3:
	%_44 = bitcast i8* %this to i8***
	%_45 = load i8**, i8*** %_44
	%_46 = getelementptr i8*, i8** %_45, i32 19
	%_47 = load i8*, i8** %_46
	%_48 = bitcast i8* %_47 to i1 (i8*,i8*)*
	%_57 = load i8*, i8** %node
	%_51 = bitcast i8* %_57 to i8***
	%_52 = load i8**, i8*** %_51
	%_53 = getelementptr i8*, i8** %_52, i32 3
	%_54 = load i8*, i8** %_53
	%_55 = bitcast i8* %_54 to i8* (i8*)*
	%_56 = call i8* %_55(i8* %_57)
	%_49 = call i1 %_48(i8* %this, i8* %_56)
	store i1 %_49, i1* %ntb	br label %if5

if4:
	store i1 1, i1* %ntb	br label %if5

if5:

	ret i1 1
}
