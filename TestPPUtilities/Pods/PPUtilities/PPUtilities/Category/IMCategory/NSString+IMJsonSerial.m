//
//  NSString+Category.m
//  CalendarLib
//
//  Created by huangyi on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "NSString+IMJsonSerial.h"
@implementation NSString (JsonSerial)

-(BOOL)hasValue;
{
    if (self == nil) {
        return NO;
    }
    
    if ([self isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}

+(NSString *) jsonStringWithString:(NSString *) string{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+(NSString *) StringFromJsonhString:(NSString *) string;
{
    //先用“n”替换“\n”
    //先用“r”替换“\r”
    //再用“"”替换“\"”
    return [[[string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]stringByReplacingOccurrencesOfString:@"\\r" withString:@"r"] stringByReplacingOccurrencesOfString:@"\\\""withString:@"\""] ;
}
+(NSString *) chatStringFromJsonString:(NSString *) string;
{
    //先用“\n”(真正的换行符)替换“\n”（接受到的两个字符）
    //先用“r”替换“\r”
    
    return [[[string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"]stringByReplacingOccurrencesOfString:@"\\r" withString:@""] stringByReplacingOccurrencesOfString:@"\\\""withString:@"\""] ;
}


+(NSString *) jsonStringWithObject:(id) object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }
    return value;
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary{
    if (!dictionary || ![dictionary isKindOfClass: [NSDictionary class]] || dictionary.count < 1) {
        return nil;
    }

    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    
    NSArray *keys = [dictionary allKeys];
    if (keys && keys.count > 0) {
        NSMutableArray *keyValues = [NSMutableArray array];
        for (int i = 0; i < [keys count]; i++) {
            NSString *name = [keys objectAtIndex:i];
            id valueObj = [dictionary valueForKey:name];
            NSString *value = [NSString jsonStringWithObject:valueObj];
            if (value) {
                [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
            }
        }
        
        [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
        [reString appendString:@"}"];
    }

    return reString;
}

+(NSString *) jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}


-(NSArray*)toCharArray;
{
    NSInteger len = self.length;
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:len] ;
    for (NSInteger i = 0;i < len;i ++) {
        NSString* c = [self substringWithRange:NSMakeRange(i,1)];
        [array addObject:c];
    }
    
    return array;
}

//解析Json数据中的数据，如果有，返回，没有，返回@""
+(NSString *)jsonHasStringWithDictionary:(NSDictionary *)dict andObjecetKey:(NSString *)key{
    NSString *returnString = @"";
    
    if ([dict objectForKey:key]&&![[dict objectForKey:key] isKindOfClass:[NSNull class]]) {
        returnString = [NSString stringWithFormat:@"%@",[dict objectForKey:key]];
    }
    
    return returnString;
}
+(NSString *)getLocationCityNameWith:(NSDictionary *)locationDic{
    NSString *location = @"";
    
    if ([locationDic isKindOfClass:[NSDictionary class]] ) {
        if (locationDic.count > 0) {
            
        }
    }
    NSString *city = [NSString jsonHasStringWithDictionary:locationDic andObjecetKey:@"city"];
    NSString *country = [NSString jsonHasStringWithDictionary:locationDic andObjecetKey:@"country"];
    NSString *province = [NSString jsonHasStringWithDictionary:locationDic andObjecetKey:@"province"];
    
    BOOL isCountry = [country isEqualToString:@"Unknown"]||[country isEqualToString:@"null"]||country==nil;
    BOOL isProvince = [province isEqualToString:@"Unknown"]||[province isEqualToString:@"null"]||province==nil;
    BOOL isCity = [city isEqualToString:@"Unknown"]||[city isEqualToString:@"null"]||city==nil;
    
    if ([country isEqualToString:province]&&[province isEqualToString:city]&&[city isEqualToString:country]) {//三级一样默认显示
        location = country;
    }else{
        if ([country isEqualToString:@"中国"]) {
            if ([city isEqualToString:province]&&!isCity) {//相同字段认为时候直辖市
                location = [NSString stringWithFormat:@"%@",province];
            }else{
                if (isCity) {
                    location = [NSString stringWithFormat:@"%@",province];
                }else {
                    if (isProvince&&!isCity) {
                        location = [NSString stringWithFormat:@"%@",city];
                    }else{
                        if ([city hasPrefix:province]) {
                            province = @"";
                        }
                        location = [NSString stringWithFormat:@"%@%@",province,city];
                    }
                }
            }
        }else{
            if ([city isEqualToString:province]&&!isCity) {//相同字段认为时候直辖市
                location = [NSString stringWithFormat:@"%@%@",country,province];
            }else{
                if (isCity||isProvince||isCountry) {
                    if (isProvince&&!isCity&&!isCountry) {//省市为空只显示国家
                        location = [NSString stringWithFormat:@"%@%@",country,city];
                    }else if(isCity&&!isProvince&&!isCountry){//不为空显示国家－省份
                        location = [NSString stringWithFormat:@"%@%@",country,province];
                    }else if(!isCity&&!isProvince&&isCountry){//国家为空
                        location = [NSString stringWithFormat:@"%@%@",province,city];
                    }
                }else{
                    if ([country isEqualToString:province]) {
                        province = @"";
                    }
                    if ([country isEqualToString:city]) {
                        city = @"";
                    }
                    if ([city hasPrefix:province]) {
                        province = @"";
                    }
                    location = [NSString stringWithFormat:@"%@%@%@",country,province,city];
                }
            }
        }
    }
    
    return location;
}


- (NSString *)addPreEnterForAlertWithCondition:(NSString *)title
{
    BOOL isIos8Later = [UIDevice currentDevice].systemVersion.floatValue >= 8.0;
    return isIos8Later ? (title ? self : [NSString stringWithFormat:@"\n%@",self]) : self;
}

//随机生成一个字母。也可以扩展为一串
+ (NSString *)randomLetterChar{
    NSString *letter = nil;
    
    //可扩展为生成多个
    char data[1];
    for (int x = 0;x < 1;data[x++] = (char)('A' + (arc4random_uniform(26))))
        letter = [[NSString alloc] initWithBytes:data length:1 encoding:NSUTF8StringEncoding] ;
    
    if (letter == nil) {
        letter = @"P";
    }
    
    return letter;
}


//过滤Html中标签

@end

@implementation NSString(FlattenHTML)
//经过滤，修改了原来的字符串
-(NSString *)stringByFlattenHTML{
    NSString *flattenStr = self;
    NSScanner *theScanner = [NSScanner scannerWithString:flattenStr];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        flattenStr = [flattenStr stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    return flattenStr;
}
@end
