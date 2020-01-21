//
//  IKFileManager.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "IKFileManager.h"
#import "IKFoundationEnvConfig.h"

@implementation IKFileManager

+ (NSString *)homeDirectoryPath {
    return NSHomeDirectory();
}

+ (NSString *)documentPath {
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *path = [Paths objectAtIndex:0];
    return path;
}

+ (NSString *)cachePath {
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                         NSUserDomainMask, YES);
    NSString *path = [Paths objectAtIndex:0];
    
    return path;
}

+ (NSString *)libraryPath {
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                         NSUserDomainMask, YES);
    NSString *path = [Paths objectAtIndex:0];
    
    if (kIsTestEnv) {
        return [NSString stringWithFormat:@"%@/TestRootDir", path];
    } else {
        return path;
    }
}

+ (NSString *)tmpPath {
    return NSTemporaryDirectory();
}


+ (BOOL)writeArray:(NSArray *)ArrarObject specifiedFile:(NSString *)path {
    return [ArrarObject writeToFile:path atomically:YES];
}

+ (BOOL)writeDictionary:(NSDictionary *)dictionaryObject
          specifiedFile:(NSString *)path {
    return [dictionaryObject writeToFile:path atomically:YES];
}

+ (BOOL)writeString:(NSString *)str specifiedFile:(NSString *)path {
    return [str writeToFile:path
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:nil];
}

+ (NSArray *)arrayFromFile:(NSString *)path {
    if (!path) {
        return nil;
    }
    
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
    
    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    return array;
}

+ (NSDictionary *)dictionaryFromFile:(NSString *)path {
    if (!path) {
        return nil;
    }
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    return dict;
}

+ (NSString *)stringFromFile:(NSString *)path {
    if (!path) {
        return nil;
    }
    
    NSString *str = [[NSString alloc] initWithContentsOfFile:path
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    if (![str isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    return str;
}

+ (NSData *)dataFromFile:(NSString *)path {
    return [[NSFileManager defaultManager] contentsAtPath:path];
}

+ (BOOL)isFileExists:(NSString *)filepath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}

+ (long long)fileSizeAtPath:(NSString*)filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    
    return 0;
}

+ (BOOL)isDirExists:(NSString *)path {
    BOOL isDir = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    
    return isDir;
}


+ (void)deleteFile:(NSString *)filePath {
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

+ (void)deleteAllInDocumentsWithDir:(NSString *)dir {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileList =
    [fileManager contentsOfDirectoryAtPath:[self dirPathInDocuments:dir]
                                     error:nil];
    
    for (NSString *filename in fileList) {
        [fileManager removeItemAtPath:[self filePathInDocuments:filename inDir:dir]
                                error:nil];
    }
}

+ (NSArray *)subpathsAtPath:(NSString *)path {
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSArray *file = [fileManage subpathsAtPath:path];
    return file;
}

+ (NSString *)filePathInResource:(NSString *)name {
    return
    [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:name];
}

+ (NSString *)filePathInResource:(NSString *)name inDir:(NSString *)dir {
    return
    [[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:dir]
     stringByAppendingPathComponent:name];
}

+ (NSString *)filePathInDocuments:(NSString *)filename {
    return [[self documentPath] stringByAppendingPathComponent:filename];
}

+ (NSString *)filePathInDocuments:(NSString *)filename inDir:(NSString *)dir {
    return [[self dirPathInDocuments:dir]
            stringByAppendingPathComponent:filename];
}

+ (NSString *)filePathInCaches:(NSString *)filename {
    return [[self cachePath] stringByAppendingPathComponent:filename];
}

+ (NSString *)filePathInCaches:(NSString *)filename inDir:(NSString *)dir {
    return [[self dirPathInCaches:dir]
            stringByAppendingPathComponent:filename];
}

+ (NSString *)filePathInLibrary:(NSString *)filename inDir:(NSString *)dir {
    return [[self dirPathInLibrary:dir] stringByAppendingPathComponent:filename];
}

+ (NSString *)filePathInDataDirInLibrary:(NSString *)file {
    return [IKFileManager filePathInLibrary:file inDir:@"Data"];
}

+ (NSString *)filePathInUserDirInLibrary:(NSString *)file {
    return [IKFileManager filePathInLibrary:file inDir:@"User"];
}

+ (NSString *)dirPathInDocuments:(NSString *)dir {
    NSError *error;
    NSString *path = [[self documentPath] stringByAppendingPathComponent:dir];
    if ([[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error]) {
        [self addSkipBackupAttributeToItemAtPath:path];
    }
    return path;
}


+ (NSString *)dirPathInLibrary:(NSString *)dir {
    NSError *error;
    NSString *path = [[self libraryPath] stringByAppendingPathComponent:dir];
    if ([[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error]) {
        [self addSkipBackupAttributeToItemAtPath:path];
    }
    
    return path;
}

+ (NSString *)dirPathInCaches:(NSString *)dir {
    NSError *error;
    NSString *path = [[self cachePath] stringByAppendingPathComponent:dir];
    if ([[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error]) {
        [self addSkipBackupAttributeToItemAtPath:path];
    }
    
    return path;
}

+ (NSString *)dirPathInTmp:(NSString *)dir
{
    NSError *error;
    NSString *path = [[self tmpPath] stringByAppendingPathComponent:dir];
    if ([[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error]) {
        [self addSkipBackupAttributeToItemAtPath:path];
    }
    return path;
}

+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)filePathString
{
    NSURL *URL = [NSURL fileURLWithPath:filePathString];
    assert([[NSFileManager defaultManager] fileExistsAtPath:[URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue:[NSNumber numberWithBool:YES]
                                  forKey:NSURLIsExcludedFromBackupKey
                                   error:&error];
    if (!success) {
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+ (NSDate *)modificationTime:(NSString *)filePath
{
    NSDictionary<NSFileAttributeKey, id> *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    
    NSDate *modifiedDate = [attributes objectForKey:NSFileModificationDate];
    
    return modifiedDate;
}

@end
