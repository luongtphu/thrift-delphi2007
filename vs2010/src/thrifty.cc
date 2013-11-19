
/*  A Bison parser, made from src/thrifty.yy with Bison version GNU Bison version 1.24
  */

#define YYBISON 1  /* Identify Bison output.  */

#define	tok_identifier	258
#define	tok_literal	259
#define	tok_doctext	260
#define	tok_st_identifier	261
#define	tok_int_constant	262
#define	tok_dub_constant	263
#define	tok_include	264
#define	tok_namespace	265
#define	tok_cpp_namespace	266
#define	tok_cpp_include	267
#define	tok_cpp_type	268
#define	tok_php_namespace	269
#define	tok_py_module	270
#define	tok_perl_package	271
#define	tok_java_package	272
#define	tok_xsd_all	273
#define	tok_xsd_optional	274
#define	tok_xsd_nillable	275
#define	tok_xsd_namespace	276
#define	tok_xsd_attrs	277
#define	tok_ruby_namespace	278
#define	tok_smalltalk_category	279
#define	tok_smalltalk_prefix	280
#define	tok_cocoa_prefix	281
#define	tok_csharp_namespace	282
#define	tok_delphi_namespace	283
#define	tok_void	284
#define	tok_bool	285
#define	tok_byte	286
#define	tok_string	287
#define	tok_binary	288
#define	tok_slist	289
#define	tok_senum	290
#define	tok_i16	291
#define	tok_i32	292
#define	tok_i64	293
#define	tok_double	294
#define	tok_map	295
#define	tok_list	296
#define	tok_set	297
#define	tok_oneway	298
#define	tok_typedef	299
#define	tok_struct	300
#define	tok_xception	301
#define	tok_throws	302
#define	tok_extends	303
#define	tok_service	304
#define	tok_enum	305
#define	tok_const	306
#define	tok_required	307
#define	tok_optional	308
#define	tok_union	309

#line 1 "src/thrifty.yy"

/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

/**
 * Thrift parser.
 *
 * This parser is used on a thrift definition file.
 *
 */

#define __STDC_LIMIT_MACROS
#define __STDC_FORMAT_MACROS
#include <stdio.h>
#ifndef _MSC_VER
#include <inttypes.h>
#else
#include <stdint.h>
#endif
#include <limits.h>
#include "main.h"
#include "globals.h"
#include "parse/t_program.h"
#include "parse/t_scope.h"

/**
 * This global variable is used for automatic numbering of field indices etc.
 * when parsing the members of a struct. Field values are automatically
 * assigned starting from -1 and working their way down.
 */
int y_field_val = -1;
int g_arglist = 0;
const int struct_is_struct = 0;
const int struct_is_union = 1;


#line 58 "src/thrifty.yy"
typedef union {
  char*          id;
  int64_t        iconst;
  double         dconst;
  bool           tbool;
  t_doc*         tdoc;
  t_type*        ttype;
  t_base_type*   tbase;
  t_typedef*     ttypedef;
  t_enum*        tenum;
  t_enum_value*  tenumv;
  t_const*       tconst;
  t_const_value* tconstv;
  t_struct*      tstruct;
  t_service*     tservice;
  t_function*    tfunction;
  t_field*       tfield;
  char*          dtext;
  t_field::e_req ereq;
  t_annotation*  tannot;
  t_field_id     tfieldid;
} YYSTYPE;

#ifndef YYLTYPE
typedef
  struct yyltype
    {
      int timestamp;
      int first_line;
      int first_column;
      int last_line;
      int last_column;
      char *text;
   }
  yyltype;

#define YYLTYPE yyltype
#endif

#include <stdio.h>

#ifndef __cplusplus
#ifndef __STDC__
#define const
#endif
#endif



#define	YYFINAL		220
#define	YYFLAG		-32768
#define	YYNTBASE	68

#define YYTRANSLATE(x) ((unsigned)(x) <= 309 ? yytranslate[x] : 124)

static const char yytranslate[] = {     0,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,    64,
    65,    55,     2,    56,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,    63,    57,    66,
    60,    67,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
    61,     2,    62,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,    58,     2,    59,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     1,     2,     3,     4,     5,
     6,     7,     8,     9,    10,    11,    12,    13,    14,    15,
    16,    17,    18,    19,    20,    21,    22,    23,    24,    25,
    26,    27,    28,    29,    30,    31,    32,    33,    34,    35,
    36,    37,    38,    39,    40,    41,    42,    43,    44,    45,
    46,    47,    48,    49,    50,    51,    52,    53,    54
};

#if YYDEBUG != 0
static const short yyprhs[] = {     0,
     0,     3,     4,     5,     9,    10,    12,    16,    20,    23,
    26,    29,    32,    35,    38,    41,    44,    47,    50,    53,
    56,    59,    62,    66,    67,    69,    71,    73,    75,    77,
    79,    81,    83,    88,    90,    92,    93,   100,   103,   104,
   111,   116,   123,   126,   127,   130,   137,   139,   141,   143,
   145,   147,   149,   153,   157,   158,   162,   168,   169,   171,
   173,   181,   183,   184,   186,   187,   189,   190,   195,   196,
   203,   213,   214,   215,   218,   219,   222,   223,   234,   236,
   237,   242,   243,   246,   247,   259,   262,   263,   265,   267,
   268,   271,   272,   274,   276,   278,   280,   282,   285,   287,
   289,   291,   293,   295,   297,   299,   301,   303,   306,   308,
   310,   312,   320,   326,   332,   335,   336,   340,   341,   344,
   345
};

static const short yyrhs[] = {    71,
    74,     0,     0,     0,    71,    70,    72,     0,     0,    73,
     0,    10,     3,     3,     0,    10,    55,     3,     0,    11,
     3,     0,    12,     4,     0,    14,     3,     0,    15,     3,
     0,    16,     3,     0,    23,     3,     0,    24,     6,     0,
    25,     3,     0,    17,     3,     0,    26,     3,     0,    21,
     4,     0,    27,     3,     0,    28,     3,     0,     9,     4,
     0,    74,    69,    75,     0,     0,    85,     0,    76,     0,
    98,     0,    77,     0,    79,     0,    82,     0,    92,     0,
    97,     0,    44,   112,     3,   121,     0,    56,     0,    57,
     0,     0,    50,     3,    58,    80,    59,   121,     0,    80,
    81,     0,     0,    69,     3,    60,     7,   121,    78,     0,
    69,     3,   121,    78,     0,    35,     3,    58,    83,    59,
   121,     0,    83,    84,     0,     0,     4,    78,     0,    51,
   112,     3,    60,    86,    78,     0,     7,     0,     8,     0,
     4,     0,     3,     0,    87,     0,    89,     0,    61,    88,
    62,     0,    88,    86,    78,     0,     0,    58,    90,    59,
     0,    90,    86,    63,    86,    78,     0,     0,    45,     0,
    54,     0,    91,     3,    93,    58,   106,    59,   121,     0,
    18,     0,     0,    19,     0,     0,    20,     0,     0,    22,
    58,   106,    59,     0,     0,    46,     3,    58,   106,    59,
   121,     0,    49,     3,   101,    58,    99,   102,   100,    59,
   121,     0,     0,     0,    48,     3,     0,     0,   102,   103,
     0,     0,    69,   104,   111,     3,    64,   106,    65,   105,
   121,    78,     0,    43,     0,     0,    47,    64,   106,    65,
     0,     0,   106,   107,     0,     0,    69,   108,   109,   112,
     3,   110,    94,    95,    96,   121,    78,     0,     7,    63,
     0,     0,    52,     0,    53,     0,     0,    60,    86,     0,
     0,   112,     0,    29,     0,     3,     0,   113,     0,   115,
     0,   114,   121,     0,    32,     0,    33,     0,    34,     0,
    30,     0,    31,     0,    36,     0,    37,     0,    38,     0,
    39,     0,   116,   121,     0,   117,     0,   118,     0,   119,
     0,    40,   120,    66,   112,    56,   112,    67,     0,    42,
   120,    66,   112,    67,     0,    41,    66,   112,    67,   120,
     0,    13,     4,     0,     0,    64,   122,    65,     0,     0,
   122,   123,     0,     0,     3,    60,     4,    78,     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
   234,   247,   258,   267,   272,   277,   282,   289,   297,   305,
   312,   321,   330,   339,   348,   357,   366,   375,   384,   393,
   402,   411,   423,   431,   436,   445,   460,   477,   485,   492,
   499,   506,   514,   526,   529,   531,   534,   561,   568,   574,
   593,   607,   618,   625,   632,   639,   657,   667,   673,   678,
   684,   689,   695,   702,   709,   716,   723,   730,   737,   742,
   747,   761,   766,   771,   776,   781,   786,   791,   796,   801,
   814,   827,   832,   837,   850,   855,   862,   868,   882,   887,
   892,   902,   907,   917,   924,   956,   992,   998,  1003,  1014,
  1019,  1028,  1033,  1039,  1045,  1061,  1066,  1072,  1084,  1090,
  1095,  1100,  1105,  1110,  1115,  1120,  1125,  1131,  1141,  1147,
  1152,  1158,  1168,  1178,  1188,  1193,  1198,  1204,  1209,  1217,
  1223
};

static const char * const yytname[] = {   "$","error","$undefined.","tok_identifier",
"tok_literal","tok_doctext","tok_st_identifier","tok_int_constant","tok_dub_constant",
"tok_include","tok_namespace","tok_cpp_namespace","tok_cpp_include","tok_cpp_type",
"tok_php_namespace","tok_py_module","tok_perl_package","tok_java_package","tok_xsd_all",
"tok_xsd_optional","tok_xsd_nillable","tok_xsd_namespace","tok_xsd_attrs","tok_ruby_namespace",
"tok_smalltalk_category","tok_smalltalk_prefix","tok_cocoa_prefix","tok_csharp_namespace",
"tok_delphi_namespace","tok_void","tok_bool","tok_byte","tok_string","tok_binary",
"tok_slist","tok_senum","tok_i16","tok_i32","tok_i64","tok_double","tok_map",
"tok_list","tok_set","tok_oneway","tok_typedef","tok_struct","tok_xception",
"tok_throws","tok_extends","tok_service","tok_enum","tok_const","tok_required",
"tok_optional","tok_union","'*'","','","';'","'{'","'}'","'='","'['","']'","':'",
"'('","')'","'<'","'>'","Program","CaptureDocText","DestroyDocText","HeaderList",
"Header","Include","DefinitionList","Definition","TypeDefinition","Typedef",
"CommaOrSemicolonOptional","Enum","EnumDefList","EnumDef","Senum","SenumDefList",
"SenumDef","Const","ConstValue","ConstList","ConstListContents","ConstMap","ConstMapContents",
"StructHead","Struct","XsdAll","XsdOptional","XsdNillable","XsdAttributes","Xception",
"Service","FlagArgs","UnflagArgs","Extends","FunctionList","Function","Oneway",
"Throws","FieldList","Field","FieldIdentifier","FieldRequiredness","FieldValue",
"FunctionType","FieldType","BaseType","SimpleBaseType","ContainerType","SimpleContainerType",
"MapType","SetType","ListType","CppType","TypeAnnotations","TypeAnnotationList",
"TypeAnnotation",""
};
#endif

static const short yyr1[] = {     0,
    68,    69,    70,    71,    71,    72,    72,    72,    72,    72,
    72,    72,    72,    72,    72,    72,    72,    72,    72,    72,
    72,    73,    74,    74,    75,    75,    75,    76,    76,    76,
    76,    76,    77,    78,    78,    78,    79,    80,    80,    81,
    81,    82,    83,    83,    84,    85,    86,    86,    86,    86,
    86,    86,    87,    88,    88,    89,    90,    90,    91,    91,
    92,    93,    93,    94,    94,    95,    95,    96,    96,    97,
    98,    99,   100,   101,   101,   102,   102,   103,   104,   104,
   105,   105,   106,   106,   107,   108,   108,   109,   109,   109,
   110,   110,   111,   111,   112,   112,   112,   113,   114,   114,
   114,   114,   114,   114,   114,   114,   114,   115,   116,   116,
   116,   117,   118,   119,   120,   120,   121,   121,   122,   122,
   123
};

static const short yyr2[] = {     0,
     2,     0,     0,     3,     0,     1,     3,     3,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     3,     0,     1,     1,     1,     1,     1,     1,
     1,     1,     4,     1,     1,     0,     6,     2,     0,     6,
     4,     6,     2,     0,     2,     6,     1,     1,     1,     1,
     1,     1,     3,     3,     0,     3,     5,     0,     1,     1,
     7,     1,     0,     1,     0,     1,     0,     4,     0,     6,
     9,     0,     0,     2,     0,     2,     0,    10,     1,     0,
     4,     0,     2,     0,    11,     2,     0,     1,     1,     0,
     2,     0,     1,     1,     1,     1,     1,     2,     1,     1,
     1,     1,     1,     1,     1,     1,     1,     2,     1,     1,
     1,     7,     5,     5,     2,     0,     3,     0,     2,     0,
     4
};

static const short yydefact[] = {     5,
     3,     0,     2,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     4,     6,
     0,    22,     0,     0,     9,    10,    11,    12,    13,    17,
    19,    14,    15,    16,    18,    20,    21,     0,     0,    59,
     0,     0,     0,     0,    60,    23,    26,    28,    29,    30,
    25,     0,    31,    32,    27,     7,     8,     0,    95,   102,
   103,    99,   100,   101,   104,   105,   106,   107,   116,     0,
   116,     0,    96,   118,    97,   118,   109,   110,   111,     0,
    75,     0,     0,    63,    44,     0,     0,     0,     0,   118,
   120,    98,   108,    84,     0,     0,    39,     0,    62,     0,
     0,   115,     0,     0,     0,    33,     0,     2,    74,    72,
     2,     0,    84,    36,   118,    43,     0,   116,     0,     0,
   117,   119,   118,    87,    83,    77,   118,     0,    38,    50,
    49,    47,    48,    58,    55,    36,    51,    52,     2,    34,
    35,    45,    42,     0,   114,   113,     0,    70,     0,    90,
     2,    37,   118,     0,     0,    46,   118,     0,    36,    86,
    88,    89,     0,    80,     0,    76,     0,    36,    56,     0,
    53,    36,    61,   112,   121,     0,    79,     0,   118,   118,
    41,     0,    54,    92,    94,     0,    93,    71,    36,    36,
     0,    65,     0,    40,    57,    91,    64,    67,    84,    66,
    69,     2,     0,   118,    82,    84,    36,     0,   118,     2,
    85,    84,    36,    68,     2,    78,    81,     0,     0,     0
};

static const short yydefgoto[] = {   218,
   124,     2,     1,    19,    20,     3,    46,    47,    48,   142,
    49,   111,   129,    50,   101,   116,    51,   136,   137,   155,
   138,   154,    52,    53,   100,   198,   201,   204,    54,    55,
   126,   165,    96,   151,   166,   178,   209,   108,   125,   150,
   163,   192,   186,    72,    73,    74,    75,    76,    77,    78,
    79,    87,    92,   107,   122
};

static const short yypact[] = {-32768,
    78,   161,    23,    26,    19,    28,    29,    32,    33,    34,
    36,    37,    40,    38,    43,    44,    48,    49,-32768,-32768,
    42,-32768,    50,    54,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,    55,   127,-32768,
    56,    72,    79,   127,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,    80,-32768,-32768,-32768,-32768,-32768,   -26,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,    27,    15,
    27,    86,-32768,    30,-32768,    30,-32768,-32768,-32768,    41,
    47,    46,    95,    82,-32768,    98,    39,   127,    45,    30,
-32768,-32768,-32768,-32768,   106,    52,-32768,    57,-32768,    60,
    12,-32768,   127,    58,   127,-32768,     2,    53,-32768,-32768,
    62,     5,-32768,   -30,    30,-32768,    59,    27,    66,    74,
-32768,-32768,    30,   107,-32768,-32768,    30,   116,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,   -30,-32768,-32768,    67,-32768,
-32768,-32768,-32768,   127,-32768,-32768,   133,-32768,    75,   -24,
    81,-32768,   -40,    11,     3,-32768,    30,    89,   -30,-32768,
-32768,-32768,   127,    96,   103,-32768,   134,   -30,-32768,   111,
-32768,   -30,-32768,-32768,-32768,   176,-32768,   113,    30,    30,
-32768,     5,-32768,   120,-32768,   178,-32768,-32768,   -30,   -30,
     5,   164,   126,-32768,-32768,-32768,-32768,   171,-32768,-32768,
   170,   128,   136,    30,   148,-32768,   -30,   132,    30,   138,
-32768,-32768,   -30,-32768,   135,-32768,-32768,   198,   199,-32768
};

static const short yypgoto[] = {-32768,
    -3,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,  -134,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,  -106,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,  -109,-32768,-32768,
-32768,-32768,-32768,   -43,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,   -50,   -73,-32768,-32768
};


#define	YYLAST		200


static const short yytable[] = {    21,
    83,   156,    93,   139,   120,   130,   131,   130,   131,   132,
   133,   132,   133,   130,   131,   114,   106,   132,   133,   167,
    89,    23,    -1,    91,   175,   140,   141,   161,   162,    22,
    25,    85,    26,   181,    27,    28,    29,   183,    30,    86,
    31,   143,    32,    33,   104,    34,    35,   170,   172,   148,
    36,    37,    56,   152,   194,   195,    57,    58,    80,   117,
   134,   119,   134,   135,   171,   135,   121,   145,   134,   169,
   115,   135,   211,    24,    81,   190,    38,   -24,   216,   168,
    88,    82,    84,   173,   196,    39,    40,    41,    90,   202,
    42,    43,    44,    91,    95,    45,   210,    98,    94,    99,
   158,   102,   215,    97,   103,   188,   189,   128,   109,   110,
   105,   123,   -24,   149,   144,    59,   112,   113,   153,   176,
   127,   -24,   -24,   -24,   118,   157,   -24,   -24,   -24,    59,
   207,   -24,   146,   147,   187,   213,   159,   160,   177,   -73,
   180,   185,    60,    61,    62,    63,    64,   164,    65,    66,
    67,    68,    69,    70,    71,   174,    60,    61,    62,    63,
    64,   179,    65,    66,    67,    68,    69,    70,    71,     4,
     5,     6,     7,   182,     8,     9,    10,    11,   184,   191,
   193,    12,   197,    13,    14,    15,    16,    17,    18,   199,
   200,   203,   205,   206,   208,   212,   214,   219,   220,   217
};

static const short yycheck[] = {     3,
    44,   136,    76,   113,     3,     3,     4,     3,     4,     7,
     8,     7,     8,     3,     4,     4,    90,     7,     8,    60,
    71,     3,     0,    64,   159,    56,    57,    52,    53,     4,
     3,    58,     4,   168,     3,     3,     3,   172,     3,    13,
     4,   115,     3,     6,    88,     3,     3,   154,   155,   123,
     3,     3,     3,   127,   189,   190,     3,     3,     3,   103,
    58,   105,    58,    61,    62,    61,    65,   118,    58,    59,
    59,    61,   207,    55,     3,   182,    35,     0,   213,   153,
    66,     3,     3,   157,   191,    44,    45,    46,     3,   199,
    49,    50,    51,    64,    48,    54,   206,     3,    58,    18,
   144,     4,   212,    58,    66,   179,   180,   111,     3,    58,
    66,    59,    35,     7,    56,     3,    60,    58,     3,   163,
    59,    44,    45,    46,    67,    59,    49,    50,    51,     3,
   204,    54,    67,    60,   178,   209,     4,    63,    43,    59,
     7,    29,    30,    31,    32,    33,    34,   151,    36,    37,
    38,    39,    40,    41,    42,    67,    30,    31,    32,    33,
    34,    59,    36,    37,    38,    39,    40,    41,    42,     9,
    10,    11,    12,    63,    14,    15,    16,    17,     3,    60,
     3,    21,    19,    23,    24,    25,    26,    27,    28,    64,
    20,    22,    65,    58,    47,    64,    59,     0,     0,    65
};
/* -*-C-*-  Note some compilers choke on comments on `#line' lines.  */
#line 3 "bison.simple"

/* Skeleton output parser for bison,
   Copyright (C) 1984, 1989, 1990 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

#ifndef alloca
#ifdef __GNUC__
#define alloca __builtin_alloca
#else /* not GNU C.  */
#if (!defined (__STDC__) && defined (sparc)) || defined (__sparc__) || defined (__sparc) || defined (__sgi)
#include <alloca.h>
#else /* not sparc */
#if defined (MSDOS) && !defined (__TURBOC__)
#include <malloc.h>
#else /* not MSDOS, or __TURBOC__ */
#if defined(_AIX)
#include <malloc.h>
 #pragma alloca
#else /* not MSDOS, __TURBOC__, or _AIX */
#ifdef __hpux
#ifdef __cplusplus
extern "C" {
void *alloca (unsigned int);
};
#else /* not __cplusplus */
void *alloca ();
#endif /* not __cplusplus */
#endif /* __hpux */
#endif /* not _AIX */
#endif /* not MSDOS, or __TURBOC__ */
#endif /* not sparc.  */
#endif /* not GNU C.  */
#endif /* alloca not defined.  */

/* This is the parser code that is written into each bison parser
  when the %semantic_parser declaration is not specified in the grammar.
  It was written by Richard Stallman by simplifying the hairy parser
  used when %semantic_parser is specified.  */

/* Note: there must be only one dollar sign in this file.
   It is replaced by the list of actions, each action
   as one case of the switch.  */

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		-2
#define YYEOF		0
#define YYACCEPT	return(0)
#define YYABORT 	return(1)
#define YYERROR		goto yyerrlab1
/* Like YYERROR except do call yyerror.
   This remains here temporarily to ease the
   transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */
#define YYFAIL		goto yyerrlab
#define YYRECOVERING()  (!!yyerrstatus)
#define YYBACKUP(token, value) \
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    { yychar = (token), yylval = (value);			\
      yychar1 = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { yyerror ("syntax error: cannot back up"); YYERROR; }	\
while (0)

#define YYTERROR	1
#define YYERRCODE	256

#ifndef YYPURE
#define YYLEX		yylex()
#endif

#ifdef YYPURE
#ifdef YYLSP_NEEDED
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, &yylloc, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval, &yylloc)
#endif
#else /* not YYLSP_NEEDED */
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval)
#endif
#endif /* not YYLSP_NEEDED */
#endif

/* If nonreentrant, generate the variables here */

#ifndef YYPURE

int	yychar;			/*  the lookahead symbol		*/
YYSTYPE	yylval;			/*  the semantic value of the		*/
				/*  lookahead symbol			*/

#ifdef YYLSP_NEEDED
YYLTYPE yylloc;			/*  location data for the lookahead	*/
				/*  symbol				*/
#endif

int yynerrs;			/*  number of parse errors so far       */
#endif  /* not YYPURE */

#if YYDEBUG != 0
int yydebug;			/*  nonzero means print parse trace	*/
/* Since this is uninitialized, it does not stop multiple parsers
   from coexisting.  */
#endif

/*  YYINITDEPTH indicates the initial size of the parser's stacks	*/

#ifndef	YYINITDEPTH
#define YYINITDEPTH 200
#endif

/*  YYMAXDEPTH is the maximum size the stacks can grow to
    (effective only if the built-in stack extension method is used).  */

#if YYMAXDEPTH == 0
#undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
#define YYMAXDEPTH 10000
#endif

/* Prevent warning if -Wstrict-prototypes.  */
#ifdef __GNUC__
int yyparse (void);
#endif

#if __GNUC__ > 1		/* GNU C and GNU C++ define this.  */
#define __yy_memcpy(FROM,TO,COUNT)	__builtin_memcpy(TO,FROM,COUNT)
#else				/* not GNU C or C++ */
#ifndef __cplusplus

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (from, to, count)
     char *from;
     char *to;
     int count;
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#else /* __cplusplus */

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (char *from, char *to, int count)
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#endif
#endif

#line 192 "bison.simple"

/* The user can define YYPARSE_PARAM as the name of an argument to be passed
   into yyparse.  The argument should have type void *.
   It should actually point to an object.
   Grammar actions can access the variable by casting it
   to the proper pointer type.  */

#ifdef YYPARSE_PARAM
#define YYPARSE_PARAM_DECL void *YYPARSE_PARAM;
#else
#define YYPARSE_PARAM
#define YYPARSE_PARAM_DECL
#endif

int
yyparse(YYPARSE_PARAM)
     YYPARSE_PARAM_DECL
{
  register int yystate;
  register int yyn;
  register short *yyssp;
  register YYSTYPE *yyvsp;
  int yyerrstatus;	/*  number of tokens to shift before error messages enabled */
  int yychar1 = 0;		/*  lookahead token as an internal (translated) token number */

  short	yyssa[YYINITDEPTH];	/*  the state stack			*/
  YYSTYPE yyvsa[YYINITDEPTH];	/*  the semantic value stack		*/

  short *yyss = yyssa;		/*  refer to the stacks thru separate pointers */
  YYSTYPE *yyvs = yyvsa;	/*  to allow yyoverflow to reallocate them elsewhere */

#ifdef YYLSP_NEEDED
  YYLTYPE yylsa[YYINITDEPTH];	/*  the location stack			*/
  YYLTYPE *yyls = yylsa;
  YYLTYPE *yylsp;

#define YYPOPSTACK   (yyvsp--, yyssp--, yylsp--)
#else
#define YYPOPSTACK   (yyvsp--, yyssp--)
#endif

  int yystacksize = YYINITDEPTH;

#ifdef YYPURE
  int yychar;
  YYSTYPE yylval;
  int yynerrs;
#ifdef YYLSP_NEEDED
  YYLTYPE yylloc;
#endif
#endif

  YYSTYPE yyval;		/*  the variable used to return		*/
				/*  semantic values from the action	*/
				/*  routines				*/

  int yylen;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Starting parse\n");
#endif

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss - 1;
  yyvsp = yyvs;
#ifdef YYLSP_NEEDED
  yylsp = yyls;
#endif

/* Push a new state, which is found in  yystate  .  */
/* In all cases, when you get here, the value and location stacks
   have just been pushed. so pushing a state here evens the stacks.  */
yynewstate:

  *++yyssp = yystate;

  if (yyssp >= yyss + yystacksize - 1)
    {
      /* Give user a chance to reallocate the stack */
      /* Use copies of these so that the &'s don't force the real ones into memory. */
      YYSTYPE *yyvs1 = yyvs;
      short *yyss1 = yyss;
#ifdef YYLSP_NEEDED
      YYLTYPE *yyls1 = yyls;
#endif

      /* Get the current used size of the three stacks, in elements.  */
      int size = yyssp - yyss + 1;

#ifdef yyoverflow
      /* Each stack pointer address is followed by the size of
	 the data in use in that stack, in bytes.  */
#ifdef YYLSP_NEEDED
      /* This used to be a conditional around just the two extra args,
	 but that might be undefined if yyoverflow is a macro.  */
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yyls1, size * sizeof (*yylsp),
		 &yystacksize);
#else
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yystacksize);
#endif

      yyss = yyss1; yyvs = yyvs1;
#ifdef YYLSP_NEEDED
      yyls = yyls1;
#endif
#else /* no yyoverflow */
      /* Extend the stack our own way.  */
      if (yystacksize >= YYMAXDEPTH)
	{
	  yyerror("parser stack overflow");
	  return 2;
	}
      yystacksize *= 2;
      if (yystacksize > YYMAXDEPTH)
	yystacksize = YYMAXDEPTH;
      yyss = (short *) alloca (yystacksize * sizeof (*yyssp));
      __yy_memcpy ((char *)yyss1, (char *)yyss, size * sizeof (*yyssp));
      yyvs = (YYSTYPE *) alloca (yystacksize * sizeof (*yyvsp));
      __yy_memcpy ((char *)yyvs1, (char *)yyvs, size * sizeof (*yyvsp));
#ifdef YYLSP_NEEDED
      yyls = (YYLTYPE *) alloca (yystacksize * sizeof (*yylsp));
      __yy_memcpy ((char *)yyls1, (char *)yyls, size * sizeof (*yylsp));
#endif
#endif /* no yyoverflow */

      yyssp = yyss + size - 1;
      yyvsp = yyvs + size - 1;
#ifdef YYLSP_NEEDED
      yylsp = yyls + size - 1;
#endif

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Stack size increased to %d\n", yystacksize);
#endif

      if (yyssp >= yyss + yystacksize - 1)
	YYABORT;
    }

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Entering state %d\n", yystate);
#endif

  goto yybackup;
 yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* yychar is either YYEMPTY or YYEOF
     or a valid token in external form.  */

  if (yychar == YYEMPTY)
    {
#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Reading a token: ");
#endif
      yychar = YYLEX;
    }

  /* Convert token to internal form (in yychar1) for indexing tables with */

  if (yychar <= 0)		/* This means end of input. */
    {
      yychar1 = 0;
      yychar = YYEOF;		/* Don't call YYLEX any more */

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Now at end of input.\n");
#endif
    }
  else
    {
      yychar1 = YYTRANSLATE(yychar);

#if YYDEBUG != 0
      if (yydebug)
	{
	  fprintf (stderr, "Next token is %d (%s", yychar, yytname[yychar1]);
	  /* Give the individual parser a way to print the precise meaning
	     of a token, for further debugging info.  */
#ifdef YYPRINT
	  YYPRINT (stderr, yychar, yylval);
#endif
	  fprintf (stderr, ")\n");
	}
#endif
    }

  yyn += yychar1;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != yychar1)
    goto yydefault;

  yyn = yytable[yyn];

  /* yyn is what to do for this token type in this state.
     Negative => reduce, -yyn is rule number.
     Positive => shift, yyn is new state.
       New state is final state => don't bother to shift,
       just return success.
     0, or most negative number => error.  */

  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrlab;

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting token %d (%s), ", yychar, yytname[yychar1]);
#endif

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  /* count tokens shifted since error; after three, turn off error status.  */
  if (yyerrstatus) yyerrstatus--;

  yystate = yyn;
  goto yynewstate;

/* Do the default action for the current state.  */
yydefault:

  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;

/* Do a reduction.  yyn is the number of a rule to reduce with.  */
yyreduce:
  yylen = yyr2[yyn];
  if (yylen > 0)
    yyval = yyvsp[1-yylen]; /* implement default value of the action */

#if YYDEBUG != 0
  if (yydebug)
    {
      int i;

      fprintf (stderr, "Reducing via rule %d (line %d), ",
	       yyn, yyrline[yyn]);

      /* Print the symbols being reduced, and their result.  */
      for (i = yyprhs[yyn]; yyrhs[i] > 0; i++)
	fprintf (stderr, "%s ", yytname[yyrhs[i]]);
      fprintf (stderr, " -> %s\n", yytname[yyr1[yyn]]);
    }
#endif


  switch (yyn) {

case 1:
#line 236 "src/thrifty.yy"
{
      pdebug("Program -> Headers DefinitionList");
      /*
      TODO(dreiss): Decide whether full-program doctext is worth the trouble.
      if ($1 != NULL) {
        g_program->set_doc($1);
      }
      */
      clear_doctext();
    ;
    break;}
case 2:
#line 248 "src/thrifty.yy"
{
      if (g_parse_mode == PROGRAM) {
        yyval.dtext = g_doctext;
        g_doctext = NULL;
      } else {
        yyval.dtext = NULL;
      }
    ;
    break;}
case 3:
#line 259 "src/thrifty.yy"
{
      if (g_parse_mode == PROGRAM) {
        clear_doctext();
      }
    ;
    break;}
case 4:
#line 269 "src/thrifty.yy"
{
      pdebug("HeaderList -> HeaderList Header");
    ;
    break;}
case 5:
#line 273 "src/thrifty.yy"
{
      pdebug("HeaderList -> ");
    ;
    break;}
case 6:
#line 279 "src/thrifty.yy"
{
      pdebug("Header -> Include");
    ;
    break;}
case 7:
#line 283 "src/thrifty.yy"
{
      pdebug("Header -> tok_namespace tok_identifier tok_identifier");
      if (g_parse_mode == PROGRAM) {
        g_program->set_namespace(yyvsp[-1].id, yyvsp[0].id);
      }
    ;
    break;}
case 8:
#line 290 "src/thrifty.yy"
{
      pdebug("Header -> tok_namespace * tok_identifier");
      if (g_parse_mode == PROGRAM) {
        g_program->set_namespace("*", yyvsp[0].id);
      }
    ;
    break;}
case 9:
#line 298 "src/thrifty.yy"
{
      pwarning(1, "'cpp_namespace' is deprecated. Use 'namespace cpp' instead");
      pdebug("Header -> tok_cpp_namespace tok_identifier");
      if (g_parse_mode == PROGRAM) {
        g_program->set_namespace("cpp", yyvsp[0].id);
      }
    ;
    break;}
case 10:
#line 306 "src/thrifty.yy"
{
      pdebug("Header -> tok_cpp_include tok_literal");
      if (g_parse_mode == PROGRAM) {
        g_program->add_cpp_include(yyvsp[0].id);
      }
    ;
    break;}
case 11:
#line 313 "src/thrifty.yy"
{
      pwarning(1, "'php_namespace' is deprecated. Use 'namespace php' instead");
      pdebug("Header -> tok_php_namespace tok_identifier");
      if (g_parse_mode == PROGRAM) {
        g_program->set_namespace("php", yyvsp[0].id);
      }
    ;
    break;}
case 12:
#line 322 "src/thrifty.yy"
{
      pwarning(1, "'py_module' is deprecated. Use 'namespace py' instead");
      pdebug("Header -> tok_py_module tok_identifier");
      if (g_parse_mode == PROGRAM) {
        g_program->set_namespace("py", yyvsp[0].id);
      }
    ;
    break;}
case 13:
#line 331 "src/thrifty.yy"
{
      pwarning(1, "'perl_package' is deprecated. Use 'namespace perl' instead");
      pdebug("Header -> tok_perl_namespace tok_identifier");
      if (g_parse_mode == PROGRAM) {
        g_program->set_namespace("perl", yyvsp[0].id);
      }
    ;
    break;}
case 14:
#line 340 "src/thrifty.yy"
{
      pwarning(1, "'ruby_namespace' is deprecated. Use 'namespace rb' instead");
      pdebug("Header -> tok_ruby_namespace tok_identifier");
      if (g_parse_mode == PROGRAM) {
        g_program->set_namespace("rb", yyvsp[0].id);
      }
    ;
    break;}
case 15:
#line 349 "src/thrifty.yy"
{
      pwarning(1, "'smalltalk_category' is deprecated. Use 'namespace smalltalk.category' instead");
      pdebug("Header -> tok_smalltalk_category tok_st_identifier");
      if (g_parse_mode == PROGRAM) {
        g_program->set_namespace("smalltalk.category", yyvsp[0].id);
      }
    ;
    break;}
case 16:
#line 358 "src/thrifty.yy"
{
      pwarning(1, "'smalltalk_prefix' is deprecated. Use 'namespace smalltalk.prefix' instead");
      pdebug("Header -> tok_smalltalk_prefix tok_identifier");
      if (g_parse_mode == PROGRAM) {
        g_program->set_namespace("smalltalk.prefix", yyvsp[0].id);
      }
    ;
    break;}
case 17:
#line 367 "src/thrifty.yy"
{
      pwarning(1, "'java_package' is deprecated. Use 'namespace java' instead");
      pdebug("Header -> tok_java_package tok_identifier");
      if (g_parse_mode == PROGRAM) {
        g_program->set_namespace("java", yyvsp[0].id);
      }
    ;
    break;}
case 18:
#line 376 "src/thrifty.yy"
{
      pwarning(1, "'cocoa_prefix' is deprecated. Use 'namespace cocoa' instead");
      pdebug("Header -> tok_cocoa_prefix tok_identifier");
      if (g_parse_mode == PROGRAM) {
        g_program->set_namespace("cocoa", yyvsp[0].id);
      }
    ;
    break;}
case 19:
#line 385 "src/thrifty.yy"
{
      pwarning(1, "'xsd_namespace' is deprecated. Use 'namespace xsd' instead");
      pdebug("Header -> tok_xsd_namespace tok_literal");
      if (g_parse_mode == PROGRAM) {
        g_program->set_namespace("cocoa", yyvsp[0].id);
      }
    ;
    break;}
case 20:
#line 394 "src/thrifty.yy"
{
     pwarning(1, "'csharp_namespace' is deprecated. Use 'namespace csharp' instead");
     pdebug("Header -> tok_csharp_namespace tok_identifier");
     if (g_parse_mode == PROGRAM) {
       g_program->set_namespace("csharp", yyvsp[0].id);
     }
   ;
    break;}
case 21:
#line 403 "src/thrifty.yy"
{
     pwarning(1, "'delphi_namespace' is deprecated. Use 'namespace delphi' instead");
     pdebug("Header -> tok_delphi_namespace tok_identifier");
     if (g_parse_mode == PROGRAM) {
       g_program->set_namespace("delphi", yyvsp[0].id);
     }
   ;
    break;}
case 22:
#line 413 "src/thrifty.yy"
{
      pdebug("Include -> tok_include tok_literal");
      if (g_parse_mode == INCLUDES) {
        std::string path = include_file(std::string(yyvsp[0].id));
        if (!path.empty()) {
          g_program->add_include(path, std::string(yyvsp[0].id));
        }
      }
    ;
    break;}
case 23:
#line 425 "src/thrifty.yy"
{
      pdebug("DefinitionList -> DefinitionList Definition");
      if (yyvsp[-1].dtext != NULL && yyvsp[0].tdoc != NULL) {
        yyvsp[0].tdoc->set_doc(yyvsp[-1].dtext);
      }
    ;
    break;}
case 24:
#line 432 "src/thrifty.yy"
{
      pdebug("DefinitionList -> ");
    ;
    break;}
case 25:
#line 438 "src/thrifty.yy"
{
      pdebug("Definition -> Const");
      if (g_parse_mode == PROGRAM) {
        g_program->add_const(yyvsp[0].tconst);
      }
      yyval.tdoc = yyvsp[0].tconst;
    ;
    break;}
case 26:
#line 446 "src/thrifty.yy"
{
      pdebug("Definition -> TypeDefinition");
      if (g_parse_mode == PROGRAM) {
        g_scope->add_type(yyvsp[0].ttype->get_name(), yyvsp[0].ttype);
        if (g_parent_scope != NULL) {
          g_parent_scope->add_type(g_parent_prefix + yyvsp[0].ttype->get_name(), yyvsp[0].ttype);
        }
        if (! g_program->is_unique_typename(yyvsp[0].ttype)) {
          yyerror("Type \"%s\" is already defined.", yyvsp[0].ttype->get_name().c_str());
          exit(1);
        }
      }
      yyval.tdoc = yyvsp[0].ttype;
    ;
    break;}
case 27:
#line 461 "src/thrifty.yy"
{
      pdebug("Definition -> Service");
      if (g_parse_mode == PROGRAM) {
        g_scope->add_service(yyvsp[0].tservice->get_name(), yyvsp[0].tservice);
        if (g_parent_scope != NULL) {
          g_parent_scope->add_service(g_parent_prefix + yyvsp[0].tservice->get_name(), yyvsp[0].tservice);
        }
        g_program->add_service(yyvsp[0].tservice);
        if (! g_program->is_unique_typename(yyvsp[0].tservice)) {
          yyerror("Type \"%s\" is already defined.", yyvsp[0].tservice->get_name().c_str());
          exit(1);
        }
      }
      yyval.tdoc = yyvsp[0].tservice;
    ;
    break;}
case 28:
#line 479 "src/thrifty.yy"
{
      pdebug("TypeDefinition -> Typedef");
      if (g_parse_mode == PROGRAM) {
        g_program->add_typedef(yyvsp[0].ttypedef);
      }
    ;
    break;}
case 29:
#line 486 "src/thrifty.yy"
{
      pdebug("TypeDefinition -> Enum");
      if (g_parse_mode == PROGRAM) {
        g_program->add_enum(yyvsp[0].tenum);
      }
    ;
    break;}
case 30:
#line 493 "src/thrifty.yy"
{
      pdebug("TypeDefinition -> Senum");
      if (g_parse_mode == PROGRAM) {
        g_program->add_typedef(yyvsp[0].ttypedef);
      }
    ;
    break;}
case 31:
#line 500 "src/thrifty.yy"
{
      pdebug("TypeDefinition -> Struct");
      if (g_parse_mode == PROGRAM) {
        g_program->add_struct(yyvsp[0].tstruct);
      }
    ;
    break;}
case 32:
#line 507 "src/thrifty.yy"
{
      pdebug("TypeDefinition -> Xception");
      if (g_parse_mode == PROGRAM) {
        g_program->add_xception(yyvsp[0].tstruct);
      }
    ;
    break;}
case 33:
#line 516 "src/thrifty.yy"
{
      pdebug("TypeDef -> tok_typedef FieldType tok_identifier");
      t_typedef *td = new t_typedef(g_program, yyvsp[-2].ttype, yyvsp[-1].id);
      yyval.ttypedef = td;
      if (yyvsp[0].ttype != NULL) {
        yyval.ttypedef->annotations_ = yyvsp[0].ttype->annotations_;
        delete yyvsp[0].ttype;
      }
    ;
    break;}
case 34:
#line 528 "src/thrifty.yy"
{;
    break;}
case 35:
#line 530 "src/thrifty.yy"
{;
    break;}
case 36:
#line 532 "src/thrifty.yy"
{;
    break;}
case 37:
#line 536 "src/thrifty.yy"
{
      pdebug("Enum -> tok_enum tok_identifier { EnumDefList }");
      yyval.tenum = yyvsp[-2].tenum;
      yyval.tenum->set_name(yyvsp[-4].id);
      if (yyvsp[0].ttype != NULL) {
        yyval.tenum->annotations_ = yyvsp[0].ttype->annotations_;
        delete yyvsp[0].ttype;
      }
      yyval.tenum->resolve_values();
      // make constants for all the enum values
      if (g_parse_mode == PROGRAM) {
        const std::vector<t_enum_value*>& enum_values = yyval.tenum->get_constants();
        std::vector<t_enum_value*>::const_iterator c_iter;
        for (c_iter = enum_values.begin(); c_iter != enum_values.end(); ++c_iter) {
          std::string const_name = yyval.tenum->get_name() + "." + (*c_iter)->get_name();
          t_const_value* const_val = new t_const_value((*c_iter)->get_value());
          const_val->set_enum(yyval.tenum);
          g_scope->add_constant(const_name, new t_const(g_type_i32, (*c_iter)->get_name(), const_val));
          if (g_parent_scope != NULL) {
            g_parent_scope->add_constant(g_parent_prefix + const_name, new t_const(g_type_i32, (*c_iter)->get_name(), const_val));
          }
        }
      }
    ;
    break;}
case 38:
#line 563 "src/thrifty.yy"
{
      pdebug("EnumDefList -> EnumDefList EnumDef");
      yyval.tenum = yyvsp[-1].tenum;
      yyval.tenum->append(yyvsp[0].tenumv);
    ;
    break;}
case 39:
#line 569 "src/thrifty.yy"
{
      pdebug("EnumDefList -> ");
      yyval.tenum = new t_enum(g_program);
    ;
    break;}
case 40:
#line 576 "src/thrifty.yy"
{
      pdebug("EnumDef -> tok_identifier = tok_int_constant");
      if (yyvsp[-2].iconst < 0) {
        pwarning(1, "Negative value supplied for enum %s.\n", yyvsp[-4].id);
      }
      if (yyvsp[-2].iconst > INT_MAX) {
        pwarning(1, "64-bit value supplied for enum %s.\n", yyvsp[-4].id);
      }
      yyval.tenumv = new t_enum_value(yyvsp[-4].id, yyvsp[-2].iconst);
      if (yyvsp[-5].dtext != NULL) {
        yyval.tenumv->set_doc(yyvsp[-5].dtext);
      }
      if (yyvsp[-1].ttype != NULL) {
        yyval.tenumv->annotations_ = yyvsp[-1].ttype->annotations_;
        delete yyvsp[-1].ttype;
      }
    ;
    break;}
case 41:
#line 595 "src/thrifty.yy"
{
      pdebug("EnumDef -> tok_identifier");
      yyval.tenumv = new t_enum_value(yyvsp[-2].id);
      if (yyvsp[-3].dtext != NULL) {
        yyval.tenumv->set_doc(yyvsp[-3].dtext);
      }
      if (yyvsp[-1].ttype != NULL) {
        yyval.tenumv->annotations_ = yyvsp[-1].ttype->annotations_;
        delete yyvsp[-1].ttype;
      }
    ;
    break;}
case 42:
#line 609 "src/thrifty.yy"
{
      pdebug("Senum -> tok_senum tok_identifier { SenumDefList }");
      yyval.ttypedef = new t_typedef(g_program, yyvsp[-2].tbase, yyvsp[-4].id);
      if (yyvsp[0].ttype != NULL) {
        yyval.ttypedef->annotations_ = yyvsp[0].ttype->annotations_;
        delete yyvsp[0].ttype;
      }
    ;
    break;}
case 43:
#line 620 "src/thrifty.yy"
{
      pdebug("SenumDefList -> SenumDefList SenumDef");
      yyval.tbase = yyvsp[-1].tbase;
      yyval.tbase->add_string_enum_val(yyvsp[0].id);
    ;
    break;}
case 44:
#line 626 "src/thrifty.yy"
{
      pdebug("SenumDefList -> ");
      yyval.tbase = new t_base_type("string", t_base_type::TYPE_STRING);
      yyval.tbase->set_string_enum(true);
    ;
    break;}
case 45:
#line 634 "src/thrifty.yy"
{
      pdebug("SenumDef -> tok_literal");
      yyval.id = yyvsp[-1].id;
    ;
    break;}
case 46:
#line 641 "src/thrifty.yy"
{
      pdebug("Const -> tok_const FieldType tok_identifier = ConstValue");
      if (g_parse_mode == PROGRAM) {
        g_scope->resolve_const_value(yyvsp[-1].tconstv, yyvsp[-4].ttype);
        yyval.tconst = new t_const(yyvsp[-4].ttype, yyvsp[-3].id, yyvsp[-1].tconstv);
        validate_const_type(yyval.tconst);

        g_scope->add_constant(yyvsp[-3].id, yyval.tconst);
        if (g_parent_scope != NULL) {
          g_parent_scope->add_constant(g_parent_prefix + yyvsp[-3].id, yyval.tconst);
        }
      } else {
        yyval.tconst = NULL;
      }
    ;
    break;}
case 47:
#line 659 "src/thrifty.yy"
{
      pdebug("ConstValue => tok_int_constant");
      yyval.tconstv = new t_const_value();
      yyval.tconstv->set_integer(yyvsp[0].iconst);
      if (!g_allow_64bit_consts && (yyvsp[0].iconst < INT32_MIN || yyvsp[0].iconst > INT32_MAX)) {
        pwarning(1, "64-bit constant \"%"PRIi64"\" may not work in all languages.\n", yyvsp[0].iconst);
      }
    ;
    break;}
case 48:
#line 668 "src/thrifty.yy"
{
      pdebug("ConstValue => tok_dub_constant");
      yyval.tconstv = new t_const_value();
      yyval.tconstv->set_double(yyvsp[0].dconst);
    ;
    break;}
case 49:
#line 674 "src/thrifty.yy"
{
      pdebug("ConstValue => tok_literal");
      yyval.tconstv = new t_const_value(yyvsp[0].id);
    ;
    break;}
case 50:
#line 679 "src/thrifty.yy"
{
      pdebug("ConstValue => tok_identifier");
      yyval.tconstv = new t_const_value();
      yyval.tconstv->set_identifier(yyvsp[0].id);
    ;
    break;}
case 51:
#line 685 "src/thrifty.yy"
{
      pdebug("ConstValue => ConstList");
      yyval.tconstv = yyvsp[0].tconstv;
    ;
    break;}
case 52:
#line 690 "src/thrifty.yy"
{
      pdebug("ConstValue => ConstMap");
      yyval.tconstv = yyvsp[0].tconstv;
    ;
    break;}
case 53:
#line 697 "src/thrifty.yy"
{
      pdebug("ConstList => [ ConstListContents ]");
      yyval.tconstv = yyvsp[-1].tconstv;
    ;
    break;}
case 54:
#line 704 "src/thrifty.yy"
{
      pdebug("ConstListContents => ConstListContents ConstValue CommaOrSemicolonOptional");
      yyval.tconstv = yyvsp[-2].tconstv;
      yyval.tconstv->add_list(yyvsp[-1].tconstv);
    ;
    break;}
case 55:
#line 710 "src/thrifty.yy"
{
      pdebug("ConstListContents =>");
      yyval.tconstv = new t_const_value();
      yyval.tconstv->set_list();
    ;
    break;}
case 56:
#line 718 "src/thrifty.yy"
{
      pdebug("ConstMap => { ConstMapContents }");
      yyval.tconstv = yyvsp[-1].tconstv;
    ;
    break;}
case 57:
#line 725 "src/thrifty.yy"
{
      pdebug("ConstMapContents => ConstMapContents ConstValue CommaOrSemicolonOptional");
      yyval.tconstv = yyvsp[-4].tconstv;
      yyval.tconstv->add_map(yyvsp[-3].tconstv, yyvsp[-1].tconstv);
    ;
    break;}
case 58:
#line 731 "src/thrifty.yy"
{
      pdebug("ConstMapContents =>");
      yyval.tconstv = new t_const_value();
      yyval.tconstv->set_map();
    ;
    break;}
case 59:
#line 739 "src/thrifty.yy"
{
      yyval.iconst = struct_is_struct;
    ;
    break;}
case 60:
#line 743 "src/thrifty.yy"
{
      yyval.iconst = struct_is_union;
    ;
    break;}
case 61:
#line 749 "src/thrifty.yy"
{
      pdebug("Struct -> tok_struct tok_identifier { FieldList }");
      yyvsp[-2].tstruct->set_xsd_all(yyvsp[-4].tbool);
      yyvsp[-2].tstruct->set_union(yyvsp[-6].iconst == struct_is_union);
      yyval.tstruct = yyvsp[-2].tstruct;
      yyval.tstruct->set_name(yyvsp[-5].id);
      if (yyvsp[0].ttype != NULL) {
        yyval.tstruct->annotations_ = yyvsp[0].ttype->annotations_;
        delete yyvsp[0].ttype;
      }
    ;
    break;}
case 62:
#line 763 "src/thrifty.yy"
{
      yyval.tbool = true;
    ;
    break;}
case 63:
#line 767 "src/thrifty.yy"
{
      yyval.tbool = false;
    ;
    break;}
case 64:
#line 773 "src/thrifty.yy"
{
      yyval.tbool = true;
    ;
    break;}
case 65:
#line 777 "src/thrifty.yy"
{
      yyval.tbool = false;
    ;
    break;}
case 66:
#line 783 "src/thrifty.yy"
{
      yyval.tbool = true;
    ;
    break;}
case 67:
#line 787 "src/thrifty.yy"
{
      yyval.tbool = false;
    ;
    break;}
case 68:
#line 793 "src/thrifty.yy"
{
      yyval.tstruct = yyvsp[-1].tstruct;
    ;
    break;}
case 69:
#line 797 "src/thrifty.yy"
{
      yyval.tstruct = NULL;
    ;
    break;}
case 70:
#line 803 "src/thrifty.yy"
{
      pdebug("Xception -> tok_xception tok_identifier { FieldList }");
      yyvsp[-2].tstruct->set_name(yyvsp[-4].id);
      yyvsp[-2].tstruct->set_xception(true);
      yyval.tstruct = yyvsp[-2].tstruct;
      if (yyvsp[0].ttype != NULL) {
        yyval.tstruct->annotations_ = yyvsp[0].ttype->annotations_;
        delete yyvsp[0].ttype;
      }
    ;
    break;}
case 71:
#line 816 "src/thrifty.yy"
{
      pdebug("Service -> tok_service tok_identifier { FunctionList }");
      yyval.tservice = yyvsp[-3].tservice;
      yyval.tservice->set_name(yyvsp[-7].id);
      yyval.tservice->set_extends(yyvsp[-6].tservice);
      if (yyvsp[0].ttype != NULL) {
        yyval.tservice->annotations_ = yyvsp[0].ttype->annotations_;
        delete yyvsp[0].ttype;
      }
    ;
    break;}
case 72:
#line 828 "src/thrifty.yy"
{
       g_arglist = 1;
    ;
    break;}
case 73:
#line 833 "src/thrifty.yy"
{
       g_arglist = 0;
    ;
    break;}
case 74:
#line 839 "src/thrifty.yy"
{
      pdebug("Extends -> tok_extends tok_identifier");
      yyval.tservice = NULL;
      if (g_parse_mode == PROGRAM) {
        yyval.tservice = g_scope->get_service(yyvsp[0].id);
        if (yyval.tservice == NULL) {
          yyerror("Service \"%s\" has not been defined.", yyvsp[0].id);
          exit(1);
        }
      }
    ;
    break;}
case 75:
#line 851 "src/thrifty.yy"
{
      yyval.tservice = NULL;
    ;
    break;}
case 76:
#line 857 "src/thrifty.yy"
{
      pdebug("FunctionList -> FunctionList Function");
      yyval.tservice = yyvsp[-1].tservice;
      yyvsp[-1].tservice->add_function(yyvsp[0].tfunction);
    ;
    break;}
case 77:
#line 863 "src/thrifty.yy"
{
      pdebug("FunctionList -> ");
      yyval.tservice = new t_service(g_program);
    ;
    break;}
case 78:
#line 870 "src/thrifty.yy"
{
      yyvsp[-4].tstruct->set_name(std::string(yyvsp[-6].id) + "_args");
      yyval.tfunction = new t_function(yyvsp[-7].ttype, yyvsp[-6].id, yyvsp[-4].tstruct, yyvsp[-2].tstruct, yyvsp[-8].tbool);
      if (yyvsp[-9].dtext != NULL) {
        yyval.tfunction->set_doc(yyvsp[-9].dtext);
      }
      if (yyvsp[-1].ttype != NULL) {
        yyval.tfunction->annotations_ = yyvsp[-1].ttype->annotations_;
        delete yyvsp[-1].ttype;
      }
    ;
    break;}
case 79:
#line 884 "src/thrifty.yy"
{
      yyval.tbool = true;
    ;
    break;}
case 80:
#line 888 "src/thrifty.yy"
{
      yyval.tbool = false;
    ;
    break;}
case 81:
#line 894 "src/thrifty.yy"
{
      pdebug("Throws -> tok_throws ( FieldList )");
      yyval.tstruct = yyvsp[-1].tstruct;
      if (g_parse_mode == PROGRAM && !validate_throws(yyval.tstruct)) {
        yyerror("Throws clause may not contain non-exception types");
        exit(1);
      }
    ;
    break;}
case 82:
#line 903 "src/thrifty.yy"
{
      yyval.tstruct = new t_struct(g_program);
    ;
    break;}
case 83:
#line 909 "src/thrifty.yy"
{
      pdebug("FieldList -> FieldList , Field");
      yyval.tstruct = yyvsp[-1].tstruct;
      if (!(yyval.tstruct->append(yyvsp[0].tfield))) {
        yyerror("\"%d: %s\" - field identifier/name has already been used", yyvsp[0].tfield->get_key(), yyvsp[0].tfield->get_name().c_str());
        exit(1);
      }
    ;
    break;}
case 84:
#line 918 "src/thrifty.yy"
{
      pdebug("FieldList -> ");
      y_field_val = -1;
      yyval.tstruct = new t_struct(g_program);
    ;
    break;}
case 85:
#line 926 "src/thrifty.yy"
{
      pdebug("tok_int_constant : Field -> FieldType tok_identifier");
      if (yyvsp[-9].tfieldid.auto_assigned) {
        pwarning(1, "No field key specified for %s, resulting protocol may have conflicts or not be backwards compatible!\n", yyvsp[-6].id);
        if (g_strict >= 192) {
          yyerror("Implicit field keys are deprecated and not allowed with -strict");
          exit(1);
        }
      }
      yyval.tfield = new t_field(yyvsp[-7].ttype, yyvsp[-6].id, yyvsp[-9].tfieldid.value);
      yyval.tfield->set_req(yyvsp[-8].ereq);
      if (yyvsp[-5].tconstv != NULL) {
        g_scope->resolve_const_value(yyvsp[-5].tconstv, yyvsp[-7].ttype);
        validate_field_value(yyval.tfield, yyvsp[-5].tconstv);
        yyval.tfield->set_value(yyvsp[-5].tconstv);
      }
      yyval.tfield->set_xsd_optional(yyvsp[-4].tbool);
      yyval.tfield->set_xsd_nillable(yyvsp[-3].tbool);
      if (yyvsp[-10].dtext != NULL) {
        yyval.tfield->set_doc(yyvsp[-10].dtext);
      }
      if (yyvsp[-2].tstruct != NULL) {
        yyval.tfield->set_xsd_attrs(yyvsp[-2].tstruct);
      }
      if (yyvsp[-1].ttype != NULL) {
        yyval.tfield->annotations_ = yyvsp[-1].ttype->annotations_;
        delete yyvsp[-1].ttype;
      }
    ;
    break;}
case 86:
#line 958 "src/thrifty.yy"
{
      if (yyvsp[-1].iconst <= 0) {
        if (g_allow_neg_field_keys) {
          /*
           * g_allow_neg_field_keys exists to allow users to add explicitly
           * specified key values to old .thrift files without breaking
           * protocol compatibility.
           */
          if (yyvsp[-1].iconst != y_field_val) {
            /*
             * warn if the user-specified negative value isn't what
             * thrift would have auto-assigned.
             */
            pwarning(1, "Nonpositive field key (%"PRIi64") differs from what would be "
                     "auto-assigned by thrift (%d).\n", yyvsp[-1].iconst, y_field_val);
          }
          /*
           * Leave $1 as-is, and update y_field_val to be one less than $1.
           * The FieldList parsing will catch any duplicate key values.
           */
          y_field_val = yyvsp[-1].iconst - 1;
          yyval.tfieldid.value = yyvsp[-1].iconst;
          yyval.tfieldid.auto_assigned = false;
        } else {
          pwarning(1, "Nonpositive value (%"PRIi64") not allowed as a field key.\n",
                   yyvsp[-1].iconst);
          yyval.tfieldid.value = y_field_val--;
          yyval.tfieldid.auto_assigned = true;
        }
      } else {
        yyval.tfieldid.value = yyvsp[-1].iconst;
        yyval.tfieldid.auto_assigned = false;
      }
    ;
    break;}
case 87:
#line 993 "src/thrifty.yy"
{
      yyval.tfieldid.value = y_field_val--;
      yyval.tfieldid.auto_assigned = true;
    ;
    break;}
case 88:
#line 1000 "src/thrifty.yy"
{
      yyval.ereq = t_field::T_REQUIRED;
    ;
    break;}
case 89:
#line 1004 "src/thrifty.yy"
{
      if (g_arglist) {
        if (g_parse_mode == PROGRAM) {
          pwarning(1, "optional keyword is ignored in argument lists.\n");
        }
        yyval.ereq = t_field::T_OPT_IN_REQ_OUT;
      } else {
        yyval.ereq = t_field::T_OPTIONAL;
      }
    ;
    break;}
case 90:
#line 1015 "src/thrifty.yy"
{
      yyval.ereq = t_field::T_OPT_IN_REQ_OUT;
    ;
    break;}
case 91:
#line 1021 "src/thrifty.yy"
{
      if (g_parse_mode == PROGRAM) {
        yyval.tconstv = yyvsp[0].tconstv;
      } else {
        yyval.tconstv = NULL;
      }
    ;
    break;}
case 92:
#line 1029 "src/thrifty.yy"
{
      yyval.tconstv = NULL;
    ;
    break;}
case 93:
#line 1035 "src/thrifty.yy"
{
      pdebug("FunctionType -> FieldType");
      yyval.ttype = yyvsp[0].ttype;
    ;
    break;}
case 94:
#line 1040 "src/thrifty.yy"
{
      pdebug("FunctionType -> tok_void");
      yyval.ttype = g_type_void;
    ;
    break;}
case 95:
#line 1047 "src/thrifty.yy"
{
      pdebug("FieldType -> tok_identifier");
      if (g_parse_mode == INCLUDES) {
        // Ignore identifiers in include mode
        yyval.ttype = NULL;
      } else {
        // Lookup the identifier in the current scope
        yyval.ttype = g_scope->get_type(yyvsp[0].id);
        if (yyval.ttype == NULL) {
          yyerror("Type \"%s\" has not been defined.", yyvsp[0].id);
          exit(1);
        }
      }
    ;
    break;}
case 96:
#line 1062 "src/thrifty.yy"
{
      pdebug("FieldType -> BaseType");
      yyval.ttype = yyvsp[0].ttype;
    ;
    break;}
case 97:
#line 1067 "src/thrifty.yy"
{
      pdebug("FieldType -> ContainerType");
      yyval.ttype = yyvsp[0].ttype;
    ;
    break;}
case 98:
#line 1073 "src/thrifty.yy"
{
      pdebug("BaseType -> SimpleBaseType TypeAnnotations");
      if (yyvsp[0].ttype != NULL) {
        yyval.ttype = new t_base_type(*static_cast<t_base_type*>(yyvsp[-1].ttype));
        yyval.ttype->annotations_ = yyvsp[0].ttype->annotations_;
        delete yyvsp[0].ttype;
      } else {
        yyval.ttype = yyvsp[-1].ttype;
      }
    ;
    break;}
case 99:
#line 1086 "src/thrifty.yy"
{
      pdebug("BaseType -> tok_string");
      yyval.ttype = g_type_string;
    ;
    break;}
case 100:
#line 1091 "src/thrifty.yy"
{
      pdebug("BaseType -> tok_binary");
      yyval.ttype = g_type_binary;
    ;
    break;}
case 101:
#line 1096 "src/thrifty.yy"
{
      pdebug("BaseType -> tok_slist");
      yyval.ttype = g_type_slist;
    ;
    break;}
case 102:
#line 1101 "src/thrifty.yy"
{
      pdebug("BaseType -> tok_bool");
      yyval.ttype = g_type_bool;
    ;
    break;}
case 103:
#line 1106 "src/thrifty.yy"
{
      pdebug("BaseType -> tok_byte");
      yyval.ttype = g_type_byte;
    ;
    break;}
case 104:
#line 1111 "src/thrifty.yy"
{
      pdebug("BaseType -> tok_i16");
      yyval.ttype = g_type_i16;
    ;
    break;}
case 105:
#line 1116 "src/thrifty.yy"
{
      pdebug("BaseType -> tok_i32");
      yyval.ttype = g_type_i32;
    ;
    break;}
case 106:
#line 1121 "src/thrifty.yy"
{
      pdebug("BaseType -> tok_i64");
      yyval.ttype = g_type_i64;
    ;
    break;}
case 107:
#line 1126 "src/thrifty.yy"
{
      pdebug("BaseType -> tok_double");
      yyval.ttype = g_type_double;
    ;
    break;}
case 108:
#line 1132 "src/thrifty.yy"
{
      pdebug("ContainerType -> SimpleContainerType TypeAnnotations");
      yyval.ttype = yyvsp[-1].ttype;
      if (yyvsp[0].ttype != NULL) {
        yyval.ttype->annotations_ = yyvsp[0].ttype->annotations_;
        delete yyvsp[0].ttype;
      }
    ;
    break;}
case 109:
#line 1143 "src/thrifty.yy"
{
      pdebug("SimpleContainerType -> MapType");
      yyval.ttype = yyvsp[0].ttype;
    ;
    break;}
case 110:
#line 1148 "src/thrifty.yy"
{
      pdebug("SimpleContainerType -> SetType");
      yyval.ttype = yyvsp[0].ttype;
    ;
    break;}
case 111:
#line 1153 "src/thrifty.yy"
{
      pdebug("SimpleContainerType -> ListType");
      yyval.ttype = yyvsp[0].ttype;
    ;
    break;}
case 112:
#line 1160 "src/thrifty.yy"
{
      pdebug("MapType -> tok_map <FieldType, FieldType>");
      yyval.ttype = new t_map(yyvsp[-3].ttype, yyvsp[-1].ttype);
      if (yyvsp[-5].id != NULL) {
        ((t_container*)yyval.ttype)->set_cpp_name(std::string(yyvsp[-5].id));
      }
    ;
    break;}
case 113:
#line 1170 "src/thrifty.yy"
{
      pdebug("SetType -> tok_set<FieldType>");
      yyval.ttype = new t_set(yyvsp[-1].ttype);
      if (yyvsp[-3].id != NULL) {
        ((t_container*)yyval.ttype)->set_cpp_name(std::string(yyvsp[-3].id));
      }
    ;
    break;}
case 114:
#line 1180 "src/thrifty.yy"
{
      pdebug("ListType -> tok_list<FieldType>");
      yyval.ttype = new t_list(yyvsp[-2].ttype);
      if (yyvsp[0].id != NULL) {
        ((t_container*)yyval.ttype)->set_cpp_name(std::string(yyvsp[0].id));
      }
    ;
    break;}
case 115:
#line 1190 "src/thrifty.yy"
{
      yyval.id = yyvsp[0].id;
    ;
    break;}
case 116:
#line 1194 "src/thrifty.yy"
{
      yyval.id = NULL;
    ;
    break;}
case 117:
#line 1200 "src/thrifty.yy"
{
      pdebug("TypeAnnotations -> ( TypeAnnotationList )");
      yyval.ttype = yyvsp[-1].ttype;
    ;
    break;}
case 118:
#line 1205 "src/thrifty.yy"
{
      yyval.ttype = NULL;
    ;
    break;}
case 119:
#line 1211 "src/thrifty.yy"
{
      pdebug("TypeAnnotationList -> TypeAnnotationList , TypeAnnotation");
      yyval.ttype = yyvsp[-1].ttype;
      yyval.ttype->annotations_[yyvsp[0].tannot->key] = yyvsp[0].tannot->val;
      delete yyvsp[0].tannot;
    ;
    break;}
case 120:
#line 1218 "src/thrifty.yy"
{
      /* Just use a dummy structure to hold the annotations. */
      yyval.ttype = new t_struct(g_program);
    ;
    break;}
case 121:
#line 1225 "src/thrifty.yy"
{
      pdebug("TypeAnnotation -> tok_identifier = tok_literal");
      yyval.tannot = new t_annotation;
      yyval.tannot->key = yyvsp[-3].id;
      yyval.tannot->val = yyvsp[-1].id;
    ;
    break;}
}
   /* the action file gets copied in in place of this dollarsign */
#line 487 "bison.simple"

  yyvsp -= yylen;
  yyssp -= yylen;
#ifdef YYLSP_NEEDED
  yylsp -= yylen;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

  *++yyvsp = yyval;

#ifdef YYLSP_NEEDED
  yylsp++;
  if (yylen == 0)
    {
      yylsp->first_line = yylloc.first_line;
      yylsp->first_column = yylloc.first_column;
      yylsp->last_line = (yylsp-1)->last_line;
      yylsp->last_column = (yylsp-1)->last_column;
      yylsp->text = 0;
    }
  else
    {
      yylsp->last_line = (yylsp+yylen-1)->last_line;
      yylsp->last_column = (yylsp+yylen-1)->last_column;
    }
#endif

  /* Now "shift" the result of the reduction.
     Determine what state that goes to,
     based on the state we popped back to
     and the rule number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTBASE] + *yyssp;
  if (yystate >= 0 && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTBASE];

  goto yynewstate;

yyerrlab:   /* here on detecting error */

  if (! yyerrstatus)
    /* If not already recovering from an error, report this error.  */
    {
      ++yynerrs;

#ifdef YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (yyn > YYFLAG && yyn < YYLAST)
	{
	  int size = 0;
	  char *msg;
	  int x, count;

	  count = 0;
	  /* Start X at -yyn if nec to avoid negative indexes in yycheck.  */
	  for (x = (yyn < 0 ? -yyn : 0);
	       x < (sizeof(yytname) / sizeof(char *)); x++)
	    if (yycheck[x + yyn] == x)
	      size += strlen(yytname[x]) + 15, count++;
	  msg = (char *) malloc(size + 15);
	  if (msg != 0)
	    {
	      strcpy(msg, "parse error");

	      if (count < 5)
		{
		  count = 0;
		  for (x = (yyn < 0 ? -yyn : 0);
		       x < (sizeof(yytname) / sizeof(char *)); x++)
		    if (yycheck[x + yyn] == x)
		      {
			strcat(msg, count == 0 ? ", expecting `" : " or `");
			strcat(msg, yytname[x]);
			strcat(msg, "'");
			count++;
		      }
		}
	      yyerror(msg);
	      free(msg);
	    }
	  else
	    yyerror ("parse error; also virtual memory exceeded");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror("parse error");
    }

  goto yyerrlab1;
yyerrlab1:   /* here on error raised explicitly by an action */

  if (yyerrstatus == 3)
    {
      /* if just tried and failed to reuse lookahead token after an error, discard it.  */

      /* return failure if at end of input */
      if (yychar == YYEOF)
	YYABORT;

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Discarding token %d (%s).\n", yychar, yytname[yychar1]);
#endif

      yychar = YYEMPTY;
    }

  /* Else will try to reuse lookahead token
     after shifting the error token.  */

  yyerrstatus = 3;		/* Each real token shifted decrements this */

  goto yyerrhandle;

yyerrdefault:  /* current state does not do anything special for the error token. */

#if 0
  /* This is wrong; only states that explicitly want error tokens
     should shift them.  */
  yyn = yydefact[yystate];  /* If its default is to accept any token, ok.  Otherwise pop it.*/
  if (yyn) goto yydefault;
#endif

yyerrpop:   /* pop the current state because it cannot handle the error token */

  if (yyssp == yyss) YYABORT;
  yyvsp--;
  yystate = *--yyssp;
#ifdef YYLSP_NEEDED
  yylsp--;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "Error: state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

yyerrhandle:

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yyerrdefault;

  yyn += YYTERROR;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != YYTERROR)
    goto yyerrdefault;

  yyn = yytable[yyn];
  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrpop;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrpop;

  if (yyn == YYFINAL)
    YYACCEPT;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting error token, ");
#endif

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  yystate = yyn;
  goto yynewstate;
}
#line 1232 "src/thrifty.yy"

