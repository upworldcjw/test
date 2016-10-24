//
//  NBLogMacro.h
//  pengpeng
//
//  Created by feng on 14-10-17.
//  Copyright (c) 2014年 AsiaInnovations. All rights reserved.
//
//打印信息
#ifndef pengpeng_NBLogMacro_h
#define pengpeng_NBLogMacro_h

#if DEBUG
#define NBLog( s, ... ) NSLog( @"%s:%d %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define NBLog( s, ... )
#endif

#define NBTrace() NBLog(@"")
#define NBTraceClass() NBLog(@"%@",NSStringFromClass([self class]));


#if DEBUG

#  define PMETHODBEGIN NSLog(@"+++%s/(%d) come in+++", __func__, __LINE__)
#  define PMETHODEND  NSLog(@"---%s/(%d) come out---", __func__, __LINE__)
#  define PINFO(KEY,VALUE) NSLog(@"***%@/%@ %@ = %@***",NSStringFromClass([self class]), NSStringFromSelector(_cmd),KEY,VALUE)
#  define PINT(KEY,VALUE) NSLog(@"###%@/%@ %@ = %d###",NSStringFromClass([self class]), NSStringFromSelector(_cmd),KEY,VALUE)
#  define PFLOAT(KEY,VALUE) NSLog(@"###%@/%@ %@ = %f###",NSStringFromClass([self class]), NSStringFromSelector(_cmd),KEY,VALUE)
#  define PDOUBLE(KEY,VALUE) NSLog(@"###%@/%@ %@ = %f###",NSStringFromClass([self class]), NSStringFromSelector(_cmd),KEY,VALUE)
#  define POBJECT(A) NSLog(@"%s(%d): \n***INFO= %@***", __func__, __LINE__,A)
#  define PERROR(A) NSLog(@"%s(%d): \n###error= %@###",__func__, __LINE__,A)
#  define PSUBVIEWS(A) NSLog(@"%@/%@~~~subviews =~~~\n %@",NSStringFromClass([self class]), NSStringFromSelector(_cmd),[A subviews])

#else


#  define PMETHODBEGIN
#  define PMETHODEND
#  define PINT(KEY,VALUE)
#  define PFLOAT(KEY,VALUE)
#  define PDOUBLE(KEY,VALUE)
# define  PINFO(KEY,VALUE)
#  define POBJECT(A)
#  define PERROR(A)
#  define PSUBVIEWS(A)

#endif


#endif
