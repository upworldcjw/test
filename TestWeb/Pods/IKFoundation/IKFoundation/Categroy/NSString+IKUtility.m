//
//  NSString+IKUtility.m
//  IKFoundation
//
//  Created by Chenxiaocheng on 16/7/20.
//  Copyright © 2016年 inke. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSString+IKUtility.h"
#import "FCBasics.h"

@implementation NSString (IKUtility)

- (NSString *)ik_trim {
    return [self ik_trimSubstringFromBothEnds:@" "];
}

- (NSString *)ik_URLEncodedString {
    NSMutableCharacterSet *allowedCharacters =
    [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacters removeCharactersInString:@"?=&+:;@/$!'()\",*"];
    return [self
            stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}


- (NSString *)ik_URLDecodedString
{
    if (kIsEmptyString(self)) {
        return @"";
    }
    
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

- (NSString *)ik_appendQueryWithString:(NSString *)queryString {
    if (kIsEmptyString(self) || kIsEmptyString(queryString)) {
        return self;
    }
    
    NSMutableString *urlStr = [[NSMutableString alloc] init];
    NSRange flag = [self rangeOfString:@"?"];
    NSRange andFlag = [self rangeOfString:@"&"];
    
    [urlStr appendString:self];
    
    if(flag.location == NSNotFound && andFlag.location == NSNotFound && ![self hasPrefix:@"inke://"]) {
        [urlStr appendString:@"?"];
    } else {
        [urlStr appendString:@"&"];
    }
    
    [urlStr appendString:NSStringNONil(queryString)];
    
    return urlStr;
}

- (NSString *)ik_appendQueryWithDictionary:(NSDictionary *)dict {
    if (kIsEmptyString(self) || kIsInvalidDict(dict)) {
        return self;
    }
    
    NSMutableString *urlStr = [[NSMutableString alloc] init];
    [urlStr appendString:self];
    
    NSRange flag = [urlStr rangeOfString:@"?"];
    NSArray *keys = [dict allKeys];
    
    for (int i = 0; i < dict.count; i++) {
        NSString *aParamStr;
        NSString *val = [dict objectForKey:keys[i]];
        
        if (![val isKindOfClass:[NSString class]]) {
            if ([val isKindOfClass:[NSNumber class]]) {
                val = [NSString stringWithFormat:@"%ld", (long)[val integerValue]];
            } else {
                val = @"";
            }
        }
        
        if (i == 0 && flag.location == NSNotFound) {
            aParamStr = [NSString stringWithFormat:@"?%@=%@", keys[i], [val ik_URLEncodedString]];
        } else {
            aParamStr = [NSString stringWithFormat:@"&%@=%@", keys[i], [val ik_URLEncodedString]];
        }
        
        [urlStr appendString: NSStringNONil(aParamStr)];
    }
    
    return urlStr;
}

- (NSString *)ik_HTMLEncodedString {
#if IS_MAC
    CFStringRef cs = CFXMLCreateStringByEscapingEntities(kCFAllocatorDefault,
                                                         (CFStringRef)self, NULL);
    NSString *str = [NSString stringWithString:(NSString *)cs];
    CFRelease(cs);
    return str;
#else
    NSString *h =
    [self stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    h = [h stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    h = [h stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    h = [h stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    return h;
#endif
}

- (NSString *)ik_summarizeToLength:(int)length withEllipsis:(BOOL)ellipsis {
    NSString *str = self;
    if ([str length] > length) {
        str = [str substringToIndex:length];
        
        // Find last space, trim to it
        NSRange offset =
        [str rangeOfCharacterFromSet:[NSCharacterSet
                                      whitespaceAndNewlineCharacterSet]
                             options:NSBackwardsSearch
                               range:NSMakeRange(0, length)];
        if (offset.location == NSNotFound) offset.location = length;
        str = [NSString stringWithFormat:@"%@%@",
               [str substringToIndex:offset.location],
               ellipsis ? @"\xE2\x80\xA6" : @""];
    }
    return str;
}

- (NSString *)ik_substringAfter:(NSString *)needle fromEnd:(BOOL)reverse {
    NSRange r =
    [self rangeOfString:needle options:(reverse ? NSBackwardsSearch : 0)];
    if (r.location == NSNotFound) return self;
    return [self substringFromIndex:(r.location + r.length)];
}

- (NSString *)ik_substringBefore:(NSString *)needle fromEnd:(BOOL)reverse {
    NSRange r =
    [self rangeOfString:needle options:(reverse ? NSBackwardsSearch : 0)];
    if (r.location == NSNotFound) return self;
    return [self substringToIndex:r.location];
}

- (NSString *)ik_substringBetween:(NSString *)leftCap and:(NSString *)rightCap {
    return
    [[self ik_substringAfter:leftCap fromEnd:NO] ik_substringBefore:rightCap
                                                            fromEnd:NO];
}

- (BOOL)ik_contains:(NSString *)needle {
    return ([self rangeOfString:needle].location != NSNotFound);
}

- (NSString *)ik_trimSubstringFromStart:(NSString *)needle {
    NSInteger nlen = [needle length];
    NSString *ret = self;
    while ([ret hasPrefix:needle]) ret = [ret substringFromIndex:nlen];
    return ret;
}

- (NSString *)ik_trimSubstringFromEnd:(NSString *)needle {
    NSInteger nlen = [needle length];
    NSString *ret = self;
    while ([ret hasSuffix:needle])
        ret = [ret substringToIndex:([ret length] - nlen)];
    return ret;
}

- (NSString *)ik_trimSubstringFromBothEnds:(NSString *)needle {
    return [[self ik_trimSubstringFromStart:needle] ik_trimSubstringFromEnd:needle];
}

- (NSString *)ik_hexString {
    const char *utf8 = [self UTF8String];
    NSMutableString *hex = [NSMutableString string];
    while (*utf8) [hex appendFormat:@"%02X", *utf8++ & 0x00FF];
    return [NSString stringWithFormat:@"%@", hex];
}

- (NSString *)ik_MD5Digest {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    data = [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
    
    NSMutableString *stringBuffer =
    [NSMutableString stringWithCapacity:(data.length * 2)];
    const unsigned char *dataBuffer = data.bytes;
    int i;
    for (i = 0; i < data.length; ++i) {
        [stringBuffer appendFormat:@"%02lx", (unsigned long)dataBuffer[i]];
    }
    return stringBuffer;
}

- (NSString *)ik_MD5Digest16 {
    NSString *md5 = [self ik_MD5Digest];
    if (!md5 || md5.length < 32) {
        return nil;
    }
    return [md5 substringWithRange:NSMakeRange(8, 16)];
}

- (BOOL)ik_isPureNumbers {
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSDate *)ik_shortDateFromString {
    NSString *time = self;
    NSDateFormatter *fa = [[NSDateFormatter alloc] init];
    [fa setDateFormat:@"yyyy-MM-dd"];
    [fa setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [fa dateFromString:time];
}

- (NSDate *)ik_longDateFromString {
    NSString *time = self;
    
    if (kIsEmptyString(time)) {
        return nil;
    }
    
    NSDateFormatter *fa = [[NSDateFormatter alloc] init];
    [fa setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [fa setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [fa setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [fa dateFromString:time];
}

- (NSInteger)ik_textLength {
    int length = 0;
    NSString *text = self;
    
    for (int i = 0; i < [text length]; i++) {
        NSString *tempCh = [text substringWithRange:NSMakeRange(i, 1)];
        NSData *temp = [tempCh dataUsingEncoding:NSUTF8StringEncoding];
        if ([temp length] > 1) {
            length += 2;
        } else {
            length += 1;
        }
    }
    
    return length;
}

- (NSString *)ik_substringWithMaxLength:(NSInteger)maxLength {
    NSMutableString *resultString = [NSMutableString string];
    int length = 0;
    
    for (int i = 0; i < self.length && length < maxLength * 2; i++) {
        NSString *tempCh = [self substringWithRange:NSMakeRange(i, 1)];
        NSData *temp = [tempCh dataUsingEncoding:NSUTF8StringEncoding];
        if ([temp length] > 1) {
            length += 2;
        } else {
            length += 1;
        }
        [resultString appendString:tempCh];
    }
    return resultString;
}

- (BOOL)ik_stringContainsEmoji {
    __block BOOL returnValue = NO;
    
    NSString *aStr = self;
    
    [aStr
     enumerateSubstringsInRange:NSMakeRange(0, [aStr length])
     options:NSStringEnumerationByComposedCharacterSequences
     usingBlock:^(NSString *substring, NSRange substringRange,
                  NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         
         // surrogate pair
         
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 
                 const int uc = ((hs - 0xd800) * 0x400) +
                 (ls - 0xdc00) + 0x10000;
                 
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
             
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
                 
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
                 
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
                 
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
                 
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d ||
                        hs == 0x3030 || hs == 0x2b55 ||
                        hs == 0x2b1c || hs == 0x2b1b ||
                        hs == 0x2b50) {
                 returnValue = YES;
             }
         }
         
     }];
    return returnValue;
}

- (NSString *)ik_filterEmoji {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}

- (NSDictionary *)ik_queryParamsToDic
{
    NSMutableDictionary *dic           = [NSMutableDictionary dictionary];
    NSArray             *urlComponents = [self componentsSeparatedByString:@"&"];
    
    for (NSString *keyValuePair in urlComponents) {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        
        if (pairComponents && [pairComponents count] == 2) {
            NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
            NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
            if (!kIsEmptyString(key)) {
                [dic setObject:NSStringNONil(value) forKey:key];
            }
        }
    }
    
    return dic;
}

+ (id)stringWithToken:(NSString *)token, ... {
    NSMutableString *backStr = [[NSMutableString alloc] init];
    
    va_list argList;
    id arg;
    va_start(argList, token);
    
    while ((arg = va_arg(argList, id))) {
        if (![backStr length]) {
            [backStr appendFormat:@"%@", arg];
        } else {
            [backStr appendFormat:@"%@%@", token, arg];
        }
    }
    va_end(argList);
    
    return backStr;
}

@end
