//
//  NSString+URLEncoded.m
//  Pods
//
//  Created by jianwei.chen on 16/1/25.
//
//

#import "NSString+URLEncoded.h"

@implementation NSString (URLEncoded)

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                  NULL,
                                                                                  (CFStringRef)self,
                                                                                  NULL,
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                  kCFStringEncodingUTF8 ));
    return encodedString;
}

- (NSString*)URLDecodedString
{
    NSString *result = (NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)self,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8));
    return result;
}


-(NSString*)encodeUtF8;
{
    NSData *data = [NSData dataWithBytes:[self UTF8String] length:[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSString *ret = [[NSString alloc ]initWithData:data encoding:NSUTF8StringEncoding];
    
    return ret;
}

+ (NSString *)convertUnicode:(NSString *)string{
    if (!string) {
        return nil;
    }
    
    NSString *unicodeString = [NSString stringWithCString:[string cStringUsingEncoding:NSNonLossyASCIIStringEncoding] encoding:NSUTF8StringEncoding];
    
    return unicodeString;
}


+ (NSString *)replaceUnicode:(NSString *)unicodeStr{
    if (!unicodeStr) {
        return nil;
    }
    
    NSString* returnStr = nil;
    @autoreleasepool {
        NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
        NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
        NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
        NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
        returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                               mutabilityOption:NSPropertyListImmutable
                                                                         format:NULL
                                                               errorDescription:NULL];
    }

    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}


@end
