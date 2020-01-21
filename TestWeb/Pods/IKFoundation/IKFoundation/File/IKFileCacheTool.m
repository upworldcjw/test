//
//  IKFileCacheTool.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import "IKFileCacheTool.h"
#import <UIKit/UIKit.h>

@implementation IKFileCacheTool


+ (long long)calculateFolderSize {
    CGFloat folderSize = 0;
    for (NSString *path in [[self class] shouldCleanPaths]) {
        folderSize += [[self class] folderSizeAtPath:path];
    }
    
    return folderSize;
}

+ (void)clean {
    for (NSString *path in [[self class] shouldCleanPaths]) {
        [self cleanFileAtPath:path];
    }

}

#pragma mark - private methods

+ (NSArray *)shouldCleanPaths {
    NSMutableArray *cleanPaths = [NSMutableArray array];
    
    // temp
    NSString *tempPath = NSTemporaryDirectory();
    [cleanPaths addObject:tempPath];
    
    // cache
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileNames = [manager contentsOfDirectoryAtPath:cachePath error:nil];
    for (NSString *fileName in fileNames) {
        BOOL donotCleanfile = [fileName isEqualToString:@"Snapshots"];
        if (!donotCleanfile) {
            NSString *fileAbsolutePath =
            [cachePath stringByAppendingPathComponent:fileName];
            [cleanPaths addObject:fileAbsolutePath];
        }
    }
    
    // Data下cachesdb
    NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *baseDir = libraryPaths.firstObject;
    NSString *cachesdb = [baseDir stringByAppendingPathComponent:@"Data/cachesdb"];
    [cleanPaths addObject:cachesdb];
    
    return cleanPaths;
}

+ (CGFloat)folderSizeAtPath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:path]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:path] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / 1024.0;
}

+ (long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (void)cleanFileAtPath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isDir;
    BOOL isExist = [manager fileExistsAtPath:path isDirectory:&isDir];
    if (!isExist) return;
    if (!isDir) {
        [manager removeItemAtPath:path error:nil];
        return;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:path] objectEnumerator];
    
    NSString *fileName;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
        [manager removeItemAtPath:fileAbsolutePath error:nil];
    }
}

@end
