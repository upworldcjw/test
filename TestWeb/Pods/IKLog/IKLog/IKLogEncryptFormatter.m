//
//  IKLogEncryptFormatter.m
//  IKLogDemo
//
//  Created by fanzhang on 2017/1/3.
//  Copyright © 2017年 meelive. All rights reserved.
//

#import "IKLogEncryptFormatter.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+IKLogCrypto.h"

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

@interface IKLogEncryptFormatter()
{
    NSString*           _encryptKey;
}

@end

//--------------------------------------------------------------------------------------------------------------------------------------------------------------

@implementation IKLogEncryptFormatter

- (instancetype)initWithEncryptKey:(NSString*)key
{
    self = [super init];
    
    if (self) {
        _encryptKey = key;
    }
    
    return self;
}

- (NSString*)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString* message = [super formatLogMessage:logMessage];
    message = [self _encryptMessage:message];
    return message;
}

- (NSString*)_encryptMessage:(NSString*)message
{
    NSData* originalData  = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSData* encryptedData = [originalData iklog_RC4EncryptedDataWithKey:_encryptKey];
    NSString* result      = [encryptedData base64EncodedStringWithOptions:0];
    
    return result;
}

@end
