//
//  NSData+IKLogCrypto.h
//  IKLogDemo
//
//  Created by fanzhang on 2017/1/3.
//  Copyright © 2017年 meelive. All rights reserved.
//

#import <Foundation/NSData.h>

@interface NSData (IKLogCommonCryptor)

- (NSData*)iklog_RC4EncryptedDataWithKey:(NSString*)key;

@end
