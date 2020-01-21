//
//  countryModle.h
//  MeeLive
//
//  Created by Duomi on 14/12/19.
//  Copyright (c) 2014年 duomi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKCountryModel : NSObject

@property (nonatomic,copy)   NSString  *Cname;
@property (nonatomic,copy)   NSString  *Cnum;
@property (nonatomic,copy)   NSString  *CEnName;
@property (nonatomic,assign) NSInteger sectionNum;

- (NSString *) getFullName;
- (NSString *) getFirstName;
- (NSString *) getFirstName:(NSString *)firstName;

@end
