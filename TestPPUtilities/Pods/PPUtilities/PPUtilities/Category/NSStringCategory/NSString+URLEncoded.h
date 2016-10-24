//
//  NSString+URLEncoded.h
//  Pods
//
//  Created by jianwei.chen on 16/1/25.
//
//



@interface NSString (URLEncoded)

- (NSString *)URLEncodedString;

- (NSString *)URLDecodedString;

- (NSString*)encodeUtF8;

+ (NSString *)replaceUnicode:(NSString *)unicodeStr;

+ (NSString *)convertUnicode:(NSString *)string;

@end
