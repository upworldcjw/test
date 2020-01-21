//
//  IKSubDynamicTabView.m
//  inke
//
//  Created by Vincent on 2018/5/4.
//  Copyright © 2018年 MeeLive. All rights reserved.
//

#import "IKSubTabRecommentView.h"
#import "IKSubTabCollectionViewCell.h"
#import <IKProtocol/IKProtocol.h>

static NSString * const kSubTabIdentifier = @"IKSubTabCollectionViewCell";

static NSInteger const itemHeight = 30;
static NSInteger const itemVMargin = 14; //垂直间距
static NSInteger const itemHMargin = 16; //横向间距
static NSInteger const colunmNum = 2;
static NSInteger const pageLeft = 16;
static NSInteger const pageTop = 20 - 6;    // 6 是上下直播卡片cell的间距

@interface IKSubTabRecommentView ()<UICollectionViewDelegate,UICollectionViewDataSource,SubTabFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSArray<IKSubDynamicTabModel *> *tabDataArray;
@property (nonatomic, strong) NSArray<UIColor *> *colors;
@end

@implementation IKSubTabRecommentView

+ (CGFloat)properHeight{
    return colunmNum * (itemHeight + itemVMargin) - itemVMargin + 2*pageTop;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        self.tabDataArray = [NSMutableArray array];
        UIColor *color1_1 = kColorWith16RGB(0x28cdef);
        UIColor *color1_2 = kColorWith16RGB(0x14e0db);
        UIColor *color2_1 = kColorWith16RGB(0xcf74ff);
        UIColor *color2_2 = kColorWith16RGB(0xff79cf);
        UIColor *color3_1 = kColorWith16RGB(0x8594ff);
        UIColor *color3_2 = kColorWith16RGB(0xad84ff);
        UIColor *color4_1 = kColorWith16RGB(0xff8abe);
        UIColor *color4_2 = kColorWith16RGB(0xffa584);
        NSArray *colorA = @[color1_1,color1_2];
        NSArray *colorB = @[color2_1,color2_2];
        NSArray *colorC = @[color3_1,color3_2];
        NSArray *colorD = @[color4_1,color4_2];
        self.colors = @[colorA,colorB,colorC,colorD,colorB,colorA,colorC,colorD];
    }
    return self;
}

- (void)configUI {
    [self.collection registerClass:[IKSubTabCollectionViewCell class] forCellWithReuseIdentifier:kSubTabIdentifier];
    [self addSubview:self.collection];
    self.collection.frame = CGRectMake(0, pageTop, self.frame.size.width, self.height - 2*pageTop);
}

- (void)reloadData:(NSArray<IKSubDynamicTabModel *> *)tabDataArray{
    self.tabDataArray = tabDataArray;
    [self calculateSize];
    [self changeSubTabIndex];
    [self.collection reloadData];
    [self.collection setContentOffset:CGPointMake(0, 0)];
}

- (void)calculateSize{
    for (IKSubDynamicTabModel *tabModel in self.tabDataArray) {
        tabModel.titleWidth = [IKSubTabCollectionViewCell widthForText:tabModel.title];
//        NSLog(@"cjw cjw %f",tabModel.titleWidth);
    }
}


- (void)changeSubTabIndex
{
    if (self.tabDataArray.count <=5 ) {
        return;
    }
    IKSubDynamicTabModel *tab = [IKSubDynamicTabModel getSelectedTab];
    if (tab) {
        BOOL __block hasWebTab = NO;
        NSMutableArray *mutableArray = [self.tabDataArray mutableCopy];
        [self.tabDataArray enumerateObjectsUsingBlock:^(IKSubDynamicTabModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            IKSubDynamicTabModel *tmpTab = [mutableArray objectAtIndex:idx];
            if ([tmpTab.tabId isEqualToString:@"web"]) {
                hasWebTab = YES;
            }
            if ([obj.title isEqualToString:tab.title] || ([obj.tabId isEqualToString:SameCityTabId] && [tab.tabId isEqualToString:obj.tabId]))
            {
                [mutableArray removeObjectAtIndex:idx];
                [mutableArray insertObject:tmpTab atIndex:hasWebTab ? 1 : 0];
                *stop = YES;
            }
        }];
        self.tabDataArray = [mutableArray copy];
    }
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.tabDataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IKSubTabCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:kSubTabIdentifier forIndexPath:indexPath];
    [cell setSubTabCellWithModel:[self.tabDataArray objectAtIndex:indexPath.row]];
    NSInteger index = (indexPath.row % self.colors.count);
    NSArray *colors = [self.colors ik_objectAtIndex:index];
    [cell setColorBegin:[colors objectAtIndex:0] colorEnd:[colors objectAtIndex:1]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (RES_OK(@selector(clickSubTab:))) {
        [self.delegate clickSubTab:self.tabDataArray[indexPath.row]];
    }
}

#pragma mark - SubTabFlowLayoutDelegate
- (CGFloat)subTabFlowLayout:(IKSubTabFlowLayout *) layout widthForItemAtIndexPath:(NSIndexPath *) indexPath{
    return [[self.tabDataArray ik_objectAtIndex:indexPath.row] titleWidth];
}

- (void)subTabFlowLayout:(IKSubTabFlowLayout *)layout needMaxWidth:(CGFloat)width{
    if (width >= self.collection.width) {
       self.collection.scrollEnabled = YES;
    }else{
        self.collection.scrollEnabled = NO;
    }
}

- (UICollectionView *)collection {
    if (!_collection) {
        IKSubTabFlowLayout * layout = [[IKSubTabFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, pageLeft, 0, pageLeft);
        layout.minimumLineSpacing = itemVMargin;
        layout.minimumInteritemSpacing = itemHMargin;
        layout.numberOfColumns = 2;
        layout.delegate = self;
        
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = k16RGBAColor(0xffffff, 1);
        _collection.showsHorizontalScrollIndicator = NO;
//        _collection.scrollEnabled = NO;
    }
    return _collection;
}

@end
