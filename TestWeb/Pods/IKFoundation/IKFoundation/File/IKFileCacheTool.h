//
//  IKFileCacheTool.h
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  文件缓存管理
 */
@interface IKFileCacheTool : NSObject

/**
 *  计算缓存文件大小
 *
 *  @return return value description
 */
+ (long long)calculateFolderSize;

/**
 *  清空缓存文件
 */
+ (void)clean;

@end
