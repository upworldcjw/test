//
//  NBJsonParse.m
//  pengpeng
//
//  Created by jianwei.chen on 15/7/23.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import "NBJsonHelper.h"

@implementation NBJsonHelper
+(id)jsonFromPath:(NSString *)jsonFilePath{
    NSData *userData = [NSData dataWithContentsOfFile:jsonFilePath];
    if(!userData)
        return nil;
    
    NSError *error = nil;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:userData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return nil;
    }
    return jsonObj;
}

+(BOOL)deleteFilePath:(NSString *)filePath{
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}

+(BOOL)writeObject:(id)object toJsonPath:(NSString *)jsonPath{
    if (object == nil) {
        return [self deleteFilePath:jsonPath];
    }else{
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];
        return [jsonData writeToFile:jsonPath atomically:YES];
    }
}
@end
