//
//  IKTLTimeLineCollectionLayout.m
//  inke
//
//  Created by JianweiChen on 2018/10/28.
//  Copyright © 2018 MeeLive. All rights reserved.
//

#import "IKTLTimeLineCollectionLayout.h"

//@implementation IKTLTimeLineCollectionLayoutDataSourceInfo
//
//@end

@interface IKTLTimeLineCollectionLayout ()

//@property (nonatomic, strong) NSMutableDictionary<NSIndexPath *,UICollectionViewLayoutAttributes *> *layoutInfoDic;
@property (nonatomic, strong) NSMutableArray<NSIndexPath *>     *reloadIndexPathArr;
@property (nonatomic, strong) NSMutableArray<NSIndexPath *>     *deleteIndexPathArr;
@property (nonatomic, strong) NSMutableArray<NSIndexPath *>     *insertIndexPathArr;

@property (nonatomic, assign) UICollectionUpdateAction  animationType;
//@property (nonatomic, strong) NSIndexPath *lastSelectIndexPath;
//@property (nonatomic, strong) NSIndexPath *currentSelectIndexPath;
@property (nonatomic, strong) NSIndexPath *handleReloadIndexPath;
//@property (nonatomic, assign) CGRect befromRect;

@end

@implementation IKTLTimeLineCollectionLayout

- (instancetype)init{
    if (self = [super init]) {
        self.reloadIndexPathArr = [NSMutableArray array];
        self.deleteIndexPathArr = [NSMutableArray array];
        self.insertIndexPathArr = [NSMutableArray array];
//        self.layoutInfoDic = [NSMutableDictionary dictionary];
    }
    return self;
}

//- (void)setSelectIndexPath:(NSIndexPath *)selectIndexPath{
//    if (selectIndexPath != self.currentSelectIndexPath) {
//        self.lastSelectIndexPath = self.currentSelectIndexPath;
//        self.currentSelectIndexPath = selectIndexPath;
//    }else{
//        [self.collectionView scrollToItemAtIndexPath:self.currentSelectIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
//    }
//}
//
//- (NSIndexPath *)selectIndexPath{
//    return self.currentSelectIndexPath;
//}

- (void)handleReloadItem:(NSIndexPath *)indexPath{
    self.handleReloadIndexPath = indexPath;
//    self.befromRect = [super layoutAttributesForItemAtIndexPath:indexPath].frame;
}

- (void)prepareLayout{
    [super prepareLayout];
//    self.handleReloadIndexPath = nil;
//    [self.layoutInfoDic removeAllObjects];
    NSLog(@"IKTLTimeLineCollectionLayout prepareLayout");
}


- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    NSLog(@"initialLayoutAttributesForAppearingItemAtIndexPath itemIndexPath %@",itemIndexPath);
    UICollectionViewLayoutAttributes *attributes = [[super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath] copy];
    
    switch (self.animationType) {
        case UICollectionUpdateActionReload:{
            NSLog(@"UICollectionUpdateActionReload");
//            if ([self.animationDelegate respondsToSelector:@selector(timeLineCollectionLayout:indexPath:)]) {
//                IKTLTimeLineCollectionLayoutDataSourceInfo *info = [self.animationDelegate timeLineCollectionLayout:self indexPath:itemIndexPath];
//                attributes.frame = [info befromFrame];
//            }
//            if ([self.reloadIndexPathArr containsObject:itemIndexPath]) {
//                attributes.transform = CGAffineTransformMakeScale(self.befromRect.size.width/ attributes.frame.size.width, self.befromRect.size.height/attributes.frame.size.height);
//                attributes.frame = self.befromRect;
//            }
        }
            
            break;
        case UICollectionUpdateActionInsert:
                NSLog(@"UICollectionUpdateActionInsert");
            break;
        case UICollectionUpdateActionDelete:
                NSLog(@"UICollectionUpdateActionDelete");
            break;
        case UICollectionUpdateActionMove:
                NSLog(@"UICollectionUpdateActionMove");
            break;
        case UICollectionUpdateActionNone:
                NSLog(@"UICollectionUpdateActionNone");
            break;
            
        default:
            break;
    }
    return attributes;
}


- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    NSLog(@"initialLayoutAttributesForAppearingItemAtIndexPath itemIndexPath %@",itemIndexPath);
    UICollectionViewLayoutAttributes *attributes = [[super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath] copy];
    switch (self.animationType) {
        case UICollectionUpdateActionReload:{
            NSLog(@"UICollectionUpdateActionReload");
                //            if ([self.animationDelegate respondsToSelector:@selector(timeLineCollectionLayout:indexPath:)]) {
                //                IKTLTimeLineCollectionLayoutDataSourceInfo *info = [self.animationDelegate timeLineCollectionLayout:self indexPath:itemIndexPath];
                //                attributes.frame = [info befromFrame];
                //
            if (self.handleReloadIndexPath != nil) {
                if ([self.reloadIndexPathArr containsObject:itemIndexPath]) {
                    attributes.alpha = 0;
                    attributes.transform = CGAffineTransformMakeScale(0, 0);
                }
            }

        }
            
            break;
        case UICollectionUpdateActionInsert:
            NSLog(@"UICollectionUpdateActionInsert");
            break;
        case UICollectionUpdateActionDelete:
            NSLog(@"UICollectionUpdateActionDelete");
            break;
        case UICollectionUpdateActionMove:
            NSLog(@"UICollectionUpdateActionMove");
            break;
        case UICollectionUpdateActionNone:
            NSLog(@"UICollectionUpdateActionNone");
            break;
            
        default:
            break;
    }
    return attributes;
}


- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems{
    NSLog(@"prepareForCollectionViewUpdates");
    [super prepareForCollectionViewUpdates:updateItems];
    [self.reloadIndexPathArr removeAllObjects];
    [self.deleteIndexPathArr removeAllObjects];
    [self.insertIndexPathArr removeAllObjects];
    for (UICollectionViewUpdateItem *item in updateItems) {
        switch (item.updateAction) {
            case UICollectionUpdateActionInsert:{
                NSLog(@"UICollectionUpdateActionInsert");
                NSIndexPath *indexPath = item.indexPathAfterUpdate;
                if (indexPath) {
                    [self.insertIndexPathArr addObject:indexPath];
                }
                self.animationType = UICollectionUpdateActionInsert;
            }
                break;
            case UICollectionUpdateActionDelete:{
                NSLog(@"UICollectionUpdateActionDelete");
                NSIndexPath *indexPath = item.indexPathBeforeUpdate;
                if (indexPath) {
                    [self.deleteIndexPathArr addObject:indexPath];
                }
                self.animationType = UICollectionUpdateActionDelete;
            }
                
                break;
            case UICollectionUpdateActionReload:{
                NSLog(@"UICollectionUpdateActionReload");
                NSIndexPath *indexPath = item.indexPathBeforeUpdate;
                if (indexPath) {
                    [self.reloadIndexPathArr addObject:indexPath];
                }
                self.animationType = UICollectionUpdateActionReload;
            }
                break;
            case UICollectionUpdateActionMove:{
                NSLog(@"prepareForCollectionViewUpdates");
                self.animationType = UICollectionUpdateActionMove;
            }
                
                break;
            case UICollectionUpdateActionNone:{
                NSLog(@"UICollectionUpdateActionNone");
                self.animationType = UICollectionUpdateActionNone;
                self.animationType = UICollectionUpdateActionMove;
            }
                break;
            default:
                break;
        }
    }
}

@end
