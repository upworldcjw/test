//
//  SecretTool.h
//  InkeCrypto
//  Version(2.0.0)
//
//  Created by Chenxiaocheng on 16/4/25.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IK_TCP_CONNECT_TYPE) {
    IK_TCP_CONNECT_TYPE_UA = 0,
    IK_TCP_CONNECT_TYPE_ROOM
};

@interface IKSecurityTool : NSObject

+ (NSString *)rsaEncrypt:(NSString *)target;

+ (NSString *)rsaEncrypt1:(NSString *)target;

+ (NSString *)rsaEncrypt2:(NSString *)target;

+ (NSString *)rsaEncryptMJPhone:(NSString *)target;

+ (NSString *)rsaEncrypt:(NSString *)target withPubKey:(NSString *)key;

+ (NSString *)rsaDecrypt:(NSString *)target withPriKey:(NSString *)key;

+ (NSString *)md5Encrypt:(NSString *)target;

+ (NSString *)crc32EncryptWithString:(NSString *)target;

+ (NSString *)desEncrypt:(NSString *)target;

+ (NSString *)desDecrypt:(NSString *)target;

+ (NSString *)openUid;

+ (void)genrateRandomCode;

+ (NSString *)randomCode;

+ (NSString *)rc4:(NSString *)key;

+ (NSString *)rc4:(NSString *)content withKey:(NSString *)key;

+ (NSString *)rc4DecodeForTest:(NSString *)content;

+ (NSString *)base64StringFromText:(NSString *)text;

+ (NSString *)textFromBase64String:(NSString *)base64;

+ (NSString *)hashedValueForAccountName:(NSString *)userAccountName;

+ (void)shareSessionId:(NSString *)sessionId withUserId:(NSString *)uid;

+ (BOOL)checkLoginSecret:(NSString *)secret
               sessionId:(NSString *)sessionId
                  userId:(NSString *)uid;

+ (BOOL)initWithServerTime:(NSTimeInterval)serverTime
                 startCode:(NSString *)code;

+ (void)updateWithServerTime:(NSTimeInterval)serverTime
                   startCode:(NSString *)startCode
                     runCode:(NSString *)runCode;

+ (NSString *)encryUrl:(NSString *)url;

+ (void)checkCydia: (void (^)(NSString *result))success;

+ (void)preSet:(NSString *)openId;

+ (NSData *)rsaTCPEncrypt:(NSData *)target withPubKey:(NSString *)key;

+ (NSData *)rc4TCPDecry:(NSData *)content type:(IK_TCP_CONNECT_TYPE)type;

+ (NSInteger)getRSAPublicKeyId;

+ (void)updateRSAPublicKeyId:(NSInteger)publicId
                rsaPublicKey:(NSString *)rsaPublicKey;

+ (NSData*)encryptTCPConnHandshake:(NSInteger)uid type:(IK_TCP_CONNECT_TYPE)type;

+ (NSString *)encryWebUrl:(NSString *)url;

+ (BOOL)initT:(NSString *)sc rc:(NSString *)rc st:(time_t)st;

+ (NSString *)te:(NSString *)oriString;


+ (NSInteger)aid;

+ (void)upaid:(NSInteger)aid akey:(NSString *)akey;

+ (NSData*)enb:(NSInteger)uid type:(NSInteger)type;

@end
