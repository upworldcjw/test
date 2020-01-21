//
//  IKFileManager.h
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  文件管理类
 */
@interface IKFileManager : NSObject

/**
 *  获取程序的Home目录路径
 *
 *  @return Home目录路径
 */
+ (NSString *)homeDirectoryPath;

/**
 *  获取document目录路径
 *
 *  @return document目录路径
 */
+ (NSString *)documentPath;

/**
 *  获取Cache目录路径
 *
 *  @return Cache路径
 */
+ (NSString *)cachePath;

/**
 *  获取Library目录路径
 *
 *  @return Library目录路径
 */
+ (NSString *)libraryPath;

/**
 *  获取Tmp目录路径
 *
 *  @return Tmp目录路径
 */
+ (NSString *)tmpPath;

/**
 *  写入NsArray文件
 *
 *  @param ArrarObject ArrarObject description
 *  @param path        path description
 *
 *  @return return value description
 */
+ (BOOL)writeArray:(NSArray *)ArrarObject specifiedFile:(NSString *)path;

/**
 *  写入NSDictionary文件
 *
 *  @param DictionaryObject DictionaryObject description
 *  @param path             path description
 *
 *  @return return value description
 */
+ (BOOL)writeDictionary:(NSDictionary *)dictionaryObject
              specifiedFile:(NSString *)path;

/**
 *  写入NSString文件
 *
 *  @param str  str description
 *  @param path path description
 *
 *  @return return value description
 */
+ (BOOL)writeString:(NSString *)str specifiedFile:(NSString *)path;

/**
 *  读取Array
 *
 *  @param filePath path description
 *
 *  @return return value description
 */
+ (NSArray *)arrayFromFile:(NSString *)filePath;

/**
 *  读取Dictionary
 *
 *  @param filePath path description
 *
 *  @return return value description
 */
+ (NSDictionary *)dictionaryFromFile:(NSString *)filePath;

/**
 *  读取String
 *
 *  @param filePath path description
 *
 *  @return return value description
 */
+ (NSString *)stringFromFile:(NSString *)filePath;

/**
 *  读取NSData
 *
 *  @param filePath path description
 *
 *  @return return value description
 */
+ (NSData *)dataFromFile:(NSString *)filePath;

/**
 *  是否存在该文件
 *
 *  @param filepath filepath description
 *
 *  @return return value description
 */
+ (BOOL)isFileExists:(NSString *)filepath;

/**
 *  文件大小
 *
 *  @param filePath filePath description
 *
 *  @return return value description
 */
+ (long long)fileSizeAtPath:(NSString*)filePath;

/**
 *  是否存在文件夹
 *
 *  @param path path description
 *
 *  @return return value description
 */
+ (BOOL)isDirExists:(NSString *)path;

/**
 *  删除指定文件
 *
 *  @param filepath filepath description
 */
+ (void)deleteFile:(NSString *)filepath;

/**
 *  删除 document/dir 目录下 所有文件
 *
 *  @param dir dir description
 */
+ (void)deleteAllInDocumentsWithDir:(NSString *)dir;

/**
 *  获取目录列表里所有的文件名
 *
 *  @param path path description
 *
 *  @return return value description
 */
+ (NSArray *)subpathsAtPath:(NSString *)path;


/**
 *  获取在Caches目录下的文件路径
 *
 *  @param filename filename description
 *
 *  @return return value description
 */
+ (NSString *)filePathInCaches:(NSString *)fileName;

/**
 *  获取Caches目录下的文件夹路径(没有则创建)
 *
 *  @param fileName fileName description
 *  @param dirName  dirName description
 *
 *  @return return value description
 */
+ (NSString *)filePathInCaches:(NSString *)fileName inDir:(NSString *)dirName;

/**
 *  获取Documents目录下的文件路径
 *
 *  @param fileName fileName description
 *
 *  @return return value description
 */
+ (NSString *)filePathInDocuments:(NSString *)fileName;

/**
 *  获取Documents目录下指定文件夹下的的文件路径
 *
 *  @param fileName fileName description
 *  @param dirName  dirName description
 *
 *  @return return value description
 */
+ (NSString *)filePathInDocuments:(NSString *)fileName inDir:(NSString *)dirName;

/**
 *  获取Resource目录下的文件路径
 *
 *  @param fileName fileName description
 *
 *  @return return value description
 */
+ (NSString *)filePathInResource:(NSString *)fileName;

/**
 *  获取Resource目录下指定文件下的文件路径
 *
 *  @param fileName fileName description
 *  @param dirName  dirName description
 *
 *  @return return value description
 */
+ (NSString *)filePathInResource:(NSString *)fileName inDir:(NSString *)dirName;

/**
 *  获取Library目录下指定文件下的文件路径
 *
 *  @param fileName fileName description
 *  @param dirName  dirName description
 *
 *  @return return value description
 */
+ (NSString *)filePathInLibrary:(NSString *)fileName inDir:(NSString *)dirName;

/**
 *  返回 Library/Data/xxx文件
 *
 *  @param file file description
 *
 *  @return return value description
 */
+ (NSString *)filePathInDataDirInLibrary:(NSString *)fileName;

/**
 *  返回 Library/User/xxx文件
 *
 *  @param file file description
 *
 *  @return return value description
 */
+ (NSString *)filePathInUserDirInLibrary:(NSString *)fileName;

/**
 *  返回 Library/xxx/
 *
 *  @param dirName dirName description
 *
 *  @return return value description
 */
+ (NSString *)dirPathInLibrary:(NSString *)dirName;

/**
 *  返回 Documents/xxx/
 *
 *  @param dirName dirName description
 *
 *  @return return value description
 */
+ (NSString *)dirPathInDocuments:(NSString *)dirName;

/**
 *  返回Caches下的指定文件路径
 *
 *  @param dirName dirName description
 *
 *  @return return value description
 */
+ (NSString *)dirPathInCaches:(NSString *)dirName;

/**
 *  返回 Tmp/xxx/
 *
 *  @param dirName dirName description
 *
 *  @return return value description
 */
+ (NSString *)dirPathInTmp:(NSString *)dirName;


/**
 获取文件最后更新时间

 @param filePath filePath description
 @return return value description
 */
+ (NSDate *)modificationTime:(NSString *)filePath;

@end
