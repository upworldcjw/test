//
//  NSData+IKUtility.h
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (IKUtility)

- (void)ik_enumerateComponentsSeparatedBy:(NSData *)delimiter
                               usingBlock:(void (^)(NSData *omponent,
                                                    BOOL flag))block;

- (NSData *)ik_dataByGZipCompressingWithError:(NSError * __autoreleasing *)error;

- (NSData *)ik_gunzippedData;

@end
