//
//  IKTimeLineItem.h
//  inke
//
//  Created by Parker on 11/4/18.
//  Copyright © 2018年 MeeLive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IKUserInfo.h"
#import "IKTLContentType.h"

@interface IKTimeLinePicItem : NSObject
@property (nonatomic,strong) NSString *cutPicUrl;
@property (nonatomic,strong) NSString *picUrl;
@property (nonatomic,assign) CGFloat picRate;

@property (nonatomic,assign) BOOL isLocal;

- (NSString *)screenFactorUrl;
@end

@interface IKTimeLineVideoItem : NSObject

@property (nonatomic, assign) NSUInteger ownerId;
@property (nonatomic,copy)   NSString *videoUrl;
@property (nonatomic,copy)   NSString *videoCover;
@property (nonatomic,assign)   CGFloat videoDurationFloat;
@property (nonatomic,copy)   NSString *videoDuration;
@property (nonatomic,assign) CGFloat videoRate;
@property (nonatomic, copy) NSString *keyVid;

@property (nonatomic,assign) BOOL isLocal;

- (NSString *)screenFactorUrl;

@end

@interface IKTimeLineContent : NSObject
@property (nonatomic,copy)   NSString *contentStr;
@property (nonatomic,strong) NSDictionary *atDict;

@property (nonatomic,strong) NSDictionary *topicDict;
@property (nonatomic,strong) NSArray *elementArray;
@property (nonatomic,strong) NSArray<IKTimeLinePicItem *> *picturesArray;
@property (nonatomic,strong) NSArray<IKTimeLineVideoItem *> *videoArray;

@end

@interface IKTimeLineCommentContent : NSObject

@property (nonatomic,copy) NSString *commentStr;
@property (nonatomic,strong) UserInfo *replyAtUser;

@end

@interface IKTimeLineComment : NSObject
@property (nonatomic,assign) uint64_t commentID;
@property (nonatomic,assign) NSTimeInterval createAt;
@property (nonatomic,strong) UserInfo *commentUser;
@property (nonatomic,strong) IKTimeLineCommentContent *content;
@property (nonatomic,assign) BOOL ownerComment;

@property (nonatomic, strong, readonly) NSString *formattedTime;
@property (nonatomic, strong, readonly) NSAttributedString *wholeComment;
@end

/**
 feed内点赞用户
 */
@interface IKTimeLineLikeItem : NSObject

@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *portrait;

@end


@interface IKTimeLineItem : IKTLContentTypeModel


@property (nonatomic,copy) NSString *token;

@property (nonatomic,assign) uint64_t feedID;
@property (nonatomic,strong) IKTimeLineContent *content;
@property (nonatomic,copy)   NSString *location;
@property (nonatomic,assign) NSInteger createAt;
@property (nonatomic,strong) UserInfo *feedUser;
@property (nonatomic,strong) NSMutableArray<IKTimeLineComment *> *comments;
@property (nonatomic,assign) NSInteger likeNum;
@property (nonatomic, assign) NSInteger belikedNum;
@property (nonatomic, assign) NSInteger scanNum;
@property (nonatomic,strong) NSArray<IKTimeLineLikeItem *> * likeList;
@property (nonatomic,assign) NSInteger commentNum;
@property (nonatomic,assign) BOOL isFollow;
@property (nonatomic,assign) BOOL isLike;
@property (nonatomic,assign) BOOL isOffical;
@property (nonatomic,copy)   NSString *officalIcon;
@property (nonatomic,assign) NSInteger shareNum;
@property (nonatomic,assign) BOOL isExpanded;

//辅助信息，不需要解析
@property (nonatomic,strong) NSString *formattedTime;
@property (nonatomic,strong) NSString *commentStr;
@property (nonatomic,strong) IKTimeLineComment *commentItem;

@property (nonatomic,strong) UserInfo *commentedUser;
@property (nonatomic,strong) IKTimeLineComment *deleteComment;
@property (nonatomic,strong) NSArray<NSMutableAttributedString *> *finalComments;
@property (nonatomic,copy)   NSAttributedString *attributedText;

@property (nonatomic,copy)   NSString *distance;  //同城使用
@property (nonatomic,assign) BOOL isFake;  //插入的本地数据
@property (nonatomic,assign) NSInteger photoIndex;  //详情页图片位置
@property (nonatomic,assign) BOOL loadImage;

@end
