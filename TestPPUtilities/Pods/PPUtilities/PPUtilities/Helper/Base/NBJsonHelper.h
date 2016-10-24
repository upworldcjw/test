//
//  NBJsonParse.h
//  pengpeng
//
//  Created by jianwei.chen on 15/7/23.
//  Copyright (c) 2015年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBJsonHelper : NSObject
+(id)jsonFromPath:(NSString *)jsonFilePath;
+(BOOL)writeObject:(id)object toJsonPath:(NSString *)jsonPath;
@end
