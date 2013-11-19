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


extern YYSTYPE yylval;
