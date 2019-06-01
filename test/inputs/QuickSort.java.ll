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
	%_1 = bitcast i8* %_7 to i8***
	%_2 = load i8**, i8*** %_1
	%_3 = getelementptr i8*, i8** %_2, i32 0
	%_4 = load i8*, i8** %_3
	%_5 = bitcast i8* %_4 to i32 (i8*,i32)*
	%_6 = call i32 %_5(i8* %_7, i32 10)
	call void (i32) @print_int(i32 %_6)

	ret i32 0
}
define i32 @QS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32
	%_3 = bitcast i8* %this to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 3
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*,i32)*
	%_9 = load i32, i32* %sz
	%_8 = call i32 %_7(i8* %this, i32 %_9)
	store i32 %_8, i32* %aux01	%_12 = bitcast i8* %this to i8***
	%_13 = load i8**, i8*** %_12
	%_14 = getelementptr i8*, i8** %_13, i32 2
	%_15 = load i8*, i8** %_14
	%_16 = bitcast i8* %_15 to i32 (i8*)*
	%_17 = call i32 %_16(i8* %this)
	store i32 %_17, i32* %aux01	call void (i32) @print_int(i32 9999)
	%_20 = getelementptr i8, i8* %this, i32 16
	%_21 = bitcast i8* %_20 to i32*
	%_22 = load i32, i32* %_21
	%_19 = sub i32 %_22, 1	store i32 %_19, i32* %aux01	%_25 = bitcast i8* %this to i8***
	%_26 = load i8**, i8*** %_25
	%_27 = getelementptr i8*, i8** %_26, i32 1
	%_28 = load i8*, i8** %_27
	%_29 = bitcast i8* %_28 to i32 (i8*,i32,i32)*
	%_31 = load i32, i32* %aux01
	%_30 = call i32 %_29(i8* %this, i32 0, i32 %_31)
	store i32 %_30, i32* %aux01	%_34 = bitcast i8* %this to i8***
	%_35 = load i8**, i8*** %_34
	%_36 = getelementptr i8*, i8** %_35, i32 2
	%_37 = load i8*, i8** %_36
	%_38 = bitcast i8* %_37 to i32 (i8*)*
	%_39 = call i32 %_38(i8* %this)
	store i32 %_39, i32* %aux01
	ret i32 0
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
	store i32 0, i32* %t	%_10 = load i32, i32* %left
	%_11 = load i32, i32* %right
	%_9 = icmp slt i32 %_10, %_11	br i1 %_9, label %if0, label %if1

if0:
	%_13 = getelementptr i8, i8* %this, i32 8
	%_14 = bitcast i8* %_13 to i32**
	%_15 = load i32*, i32** %_14
	%_16 = load i32, i32* %right
	%_17 = load i32, i32* %_15
	%_18 = icmp ult i32 %_16, %_17
	br i1 %_18, label %oob0, label %oob1

oob0:
	%_19 = add i32 %_16, 1
	%_20 = getelementptr i32, i32* %_15, i32 %_19
	%_21 = load i32, i32* %_20
	br label %oob2
oob1:
call void @throw_oob()
br label %oob2
	store i32 %_21, i32* %v	%_24 = load i32, i32* %left
	%_23 = sub i32 %_24, 1	store i32 %_23, i32* %i	%_26 = load i32, i32* %right
	store i32 %_26, i32* %j	store i1 1, i1* %cont01	br label %loop0

loop0:
	%_28 = load i1, i1* %cont01
	br i1 %_28, label %loop1, label %loop2

loop1:
	store i1 1, i1* %cont02	br label %loop3

loop3:
	%_30 = load i1, i1* %cont02
	br i1 %_30, label %loop4, label %loop5

loop4:
	%_33 = load i32, i32* %i
	%_32 = add i32 %_33, 1	store i32 %_32, i32* %i	%_35 = getelementptr i8, i8* %this, i32 8
	%_36 = bitcast i8* %_35 to i32**
	%_37 = load i32*, i32** %_36
	%_38 = load i32, i32* %i
	%_39 = load i32, i32* %_37
	%_40 = icmp ult i32 %_38, %_39
	br i1 %_40, label %oob3, label %oob4

oob3:
	%_41 = add i32 %_38, 1
	%_42 = getelementptr i32, i32* %_37, i32 %_41
	%_43 = load i32, i32* %_42
	br label %oob5
oob4:
call void @throw_oob()
br label %oob5
	store i32 %_43, i32* %aux03	%_46 = load i32, i32* %aux03
	%_47 = load i32, i32* %v
	%_45 = icmp slt i32 %_46, %_47	%_44 = xor i1 1, %_45	br i1 %_44, label %if3, label %if4

if3:
	store i1 0, i1* %cont02	br label %if5

if4:
	store i1 1, i1* %cont02	br label %if5

if5:
	br label %loop3

loop5:
	store i1 1, i1* %cont02	br label %loop6

loop6:
	%_51 = load i1, i1* %cont02
	br i1 %_51, label %loop7, label %loop8

loop7:
	%_54 = load i32, i32* %j
	%_53 = sub i32 %_54, 1	store i32 %_53, i32* %j	%_56 = getelementptr i8, i8* %this, i32 8
	%_57 = bitcast i8* %_56 to i32**
	%_58 = load i32*, i32** %_57
	%_59 = load i32, i32* %j
	%_60 = load i32, i32* %_58
	%_61 = icmp ult i32 %_59, %_60
	br i1 %_61, label %oob6, label %oob7

oob6:
	%_62 = add i32 %_59, 1
	%_63 = getelementptr i32, i32* %_58, i32 %_62
	%_64 = load i32, i32* %_63
	br label %oob8
oob7:
call void @throw_oob()
br label %oob8
	store i32 %_64, i32* %aux03	%_67 = load i32, i32* %v
	%_68 = load i32, i32* %aux03
	%_66 = icmp slt i32 %_67, %_68	%_65 = xor i1 1, %_66	br i1 %_65, label %if6, label %if7

if6:
	store i1 0, i1* %cont02	br label %if8

if7:
	store i1 1, i1* %cont02	br label %if8

if8:
	br label %loop6

loop8:
	%_72 = getelementptr i8, i8* %this, i32 8
	%_73 = bitcast i8* %_72 to i32**
	%_74 = load i32*, i32** %_73
	%_75 = load i32, i32* %i
	%_76 = load i32, i32* %_74
	%_77 = icmp ult i32 %_75, %_76
	br i1 %_77, label %oob9, label %oob10

oob9:
	%_78 = add i32 %_75, 1
	%_79 = getelementptr i32, i32* %_74, i32 %_78
	%_80 = load i32, i32* %_79
	br label %oob11
oob10:
call void @throw_oob()
br label %oob11
	store i32 %_80, i32* %t	%_81 = getelementptr i8, i8* %this, i32 8
	%_82 = bitcast i8* %_81 to i32**
	%_83 = load i32*, i32** %_82
	%_84 = load i32, i32* %i
	%_85 = getelementptr i8, i8* %this, i32 8
	%_86 = bitcast i8* %_85 to i32**
	%_87 = load i32*, i32** %_86
	%_88 = load i32, i32* %j
	%_89 = load i32, i32* %_87
	%_90 = icmp ult i32 %_88, %_89
	br i1 %_90, label %oob12, label %oob13

oob12:
	%_91 = add i32 %_88, 1
	%_92 = getelementptr i32, i32* %_87, i32 %_91
	%_93 = load i32, i32* %_92
	br label %oob14
oob13:
call void @throw_oob()
br label %oob14
	%_94 = load i32, i32* %_83
	%_95 = icmp ult i32 %_84, %_94
	br i1 %_95, label %oob15, label %oob16

oob15:
	%_96 = add i32 %_84, 1
	%_97 = getelementptr i32, i32* %_83, i32 %_96
	store i32 %_93, i32* %_97
	br label %oob17
oob16:
call void @throw_oob()
br label %oob17
	%_98 = getelementptr i8, i8* %this, i32 8
	%_99 = bitcast i8* %_98 to i32**
	%_100 = load i32*, i32** %_99
	%_101 = load i32, i32* %j
	%_102 = load i32, i32* %t
	%_103 = load i32, i32* %_100
	%_104 = icmp ult i32 %_101, %_103
	br i1 %_104, label %oob18, label %oob19

oob18:
	%_105 = add i32 %_101, 1
	%_106 = getelementptr i32, i32* %_100, i32 %_105
	store i32 %_102, i32* %_106
	br label %oob20
oob19:
call void @throw_oob()
br label %oob20
	%_108 = load i32, i32* %j
	%_110 = load i32, i32* %i
	%_109 = add i32 %_110, 1	%_107 = icmp slt i32 %_108, %_109	br i1 %_107, label %if9, label %if10

if9:
	store i1 0, i1* %cont01	br label %if11

if10:
	store i1 1, i1* %cont01	br label %if11

if11:
	br label %loop0

loop2:
	%_113 = getelementptr i8, i8* %this, i32 8
	%_114 = bitcast i8* %_113 to i32**
	%_115 = load i32*, i32** %_114
	%_116 = load i32, i32* %j
	%_117 = getelementptr i8, i8* %this, i32 8
	%_118 = bitcast i8* %_117 to i32**
	%_119 = load i32*, i32** %_118
	%_120 = load i32, i32* %i
	%_121 = load i32, i32* %_119
	%_122 = icmp ult i32 %_120, %_121
	br i1 %_122, label %oob21, label %oob22

oob21:
	%_123 = add i32 %_120, 1
	%_124 = getelementptr i32, i32* %_119, i32 %_123
	%_125 = load i32, i32* %_124
	br label %oob23
oob22:
call void @throw_oob()
br label %oob23
	%_126 = load i32, i32* %_115
	%_127 = icmp ult i32 %_116, %_126
	br i1 %_127, label %oob24, label %oob25

oob24:
	%_128 = add i32 %_116, 1
	%_129 = getelementptr i32, i32* %_115, i32 %_128
	store i32 %_125, i32* %_129
	br label %oob26
oob25:
call void @throw_oob()
br label %oob26
	%_130 = getelementptr i8, i8* %this, i32 8
	%_131 = bitcast i8* %_130 to i32**
	%_132 = load i32*, i32** %_131
	%_133 = load i32, i32* %i
	%_134 = getelementptr i8, i8* %this, i32 8
	%_135 = bitcast i8* %_134 to i32**
	%_136 = load i32*, i32** %_135
	%_137 = load i32, i32* %right
	%_138 = load i32, i32* %_136
	%_139 = icmp ult i32 %_137, %_138
	br i1 %_139, label %oob27, label %oob28

oob27:
	%_140 = add i32 %_137, 1
	%_141 = getelementptr i32, i32* %_136, i32 %_140
	%_142 = load i32, i32* %_141
	br label %oob29
oob28:
call void @throw_oob()
br label %oob29
	%_143 = load i32, i32* %_132
	%_144 = icmp ult i32 %_133, %_143
	br i1 %_144, label %oob30, label %oob31

oob30:
	%_145 = add i32 %_133, 1
	%_146 = getelementptr i32, i32* %_132, i32 %_145
	store i32 %_142, i32* %_146
	br label %oob32
oob31:
call void @throw_oob()
br label %oob32
	%_147 = getelementptr i8, i8* %this, i32 8
	%_148 = bitcast i8* %_147 to i32**
	%_149 = load i32*, i32** %_148
	%_150 = load i32, i32* %right
	%_151 = load i32, i32* %t
	%_152 = load i32, i32* %_149
	%_153 = icmp ult i32 %_150, %_152
	br i1 %_153, label %oob33, label %oob34

oob33:
	%_154 = add i32 %_150, 1
	%_155 = getelementptr i32, i32* %_149, i32 %_154
	store i32 %_151, i32* %_155
	br label %oob35
oob34:
call void @throw_oob()
br label %oob35
	%_158 = bitcast i8* %this to i8***
	%_159 = load i8**, i8*** %_158
	%_160 = getelementptr i8*, i8** %_159, i32 1
	%_161 = load i8*, i8** %_160
	%_162 = bitcast i8* %_161 to i32 (i8*,i32,i32)*
	%_164 = load i32, i32* %left
	%_166 = load i32, i32* %i
	%_165 = sub i32 %_166, 1	%_163 = call i32 %_162(i8* %this, i32 %_164, i32 %_165)
	store i32 %_163, i32* %nt	%_169 = bitcast i8* %this to i8***
	%_170 = load i8**, i8*** %_169
	%_171 = getelementptr i8*, i8** %_170, i32 1
	%_172 = load i8*, i8** %_171
	%_173 = bitcast i8* %_172 to i32 (i8*,i32,i32)*
	%_176 = load i32, i32* %i
	%_175 = add i32 %_176, 1	%_177 = load i32, i32* %right
	%_174 = call i32 %_173(i8* %this, i32 %_175, i32 %_177)
	store i32 %_174, i32* %nt	br label %if2

if1:
	store i32 0, i32* %nt	br label %if2

if2:

	ret i32 0
}
define i32 @QS.Print(i8* %this) {
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
define i32 @QS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
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
