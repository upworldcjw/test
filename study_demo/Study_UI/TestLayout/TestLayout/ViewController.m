//
//  ViewController.m
//  TestLayout
//
//  Created by JianweiChen on 2018/10/28.
//  Copyright © 2018 inke. All rights reserved.
//

#import "ViewController.h"
#import "BGPhotoPreviewCell.h"

#define MainScreenWidth  [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic ,assign) NSInteger selectIndex;
@property (nonatomic, strong) NSMutableArray<CellModel *> *models;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BGPhotoPreviewCell *selectedCell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imageNameArr = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", @"6.jpg", @"7.jpg", @"8.jpg", @"9.jpg", @"10.jpg", @"11.jpg", @"12.jpg", @"13.jpg"];
//    NSArray *imageNameArr = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];
    self.models = [NSMutableArray array];
    for (NSInteger i =0; i < imageNameArr.count; i++) {
        CellModel *model = [CellModel new];
        model.imgName = imageNameArr[i];
        model.expand = NO;
        [self.models addObject:model];
    }
    [self createCollectionView];
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.layout = layout;
    CGRect frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight-250);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.translatesAutoresizingMaskIntoConstraints = false;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

    [collectionView registerClass:[BGPhotoPreviewCell class] forCellWithReuseIdentifier:@"BGPhotoPreviewCell"];
}

#pragma mark - IKTLTimeLineCollectionLayoutDataSource <NSObject>

//- (IKTLTimeLineCollectionLayoutDataSourceInfo *)timeLineCollectionLayout:(IKTLTimeLineCollectionLayout *)layout indexPath:(NSIndexPath *)indexPath{
//    CellModel *model = self.models[indexPath.row];
//    IKTLTimeLineCollectionLayoutDataSourceInfo *souceInfo = [[IKTLTimeLineCollectionLayoutDataSourceInfo alloc] init];
//    return model;
//}


#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CellModel *model = self.models[indexPath.row];
    if (!model.expand) {
        return CGSizeMake(MainScreenWidth, 60+20);
    }else{
        return CGSizeMake(MainScreenWidth, 120+20);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.selectIndex && self.selectedCell) {
        CellModel *model = self.models[indexPath.row];
        self.selectedCell.model = model;
        return self.selectedCell;
    }
    BGPhotoPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BGPhotoPreviewCell" forIndexPath:indexPath];
    cell.imgView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imgView.clipsToBounds = YES;
    [cell setText:@(indexPath.row).description];
    CellModel *model = self.models[indexPath.row];
    cell.model = model;
    NSLog(@"cjw == after indexPath %d ==> cell %p",indexPath.row, cell);
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.row;
    self.selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    [self.selectedCell doAnimation];
    
    CellModel *model = self.models[indexPath.row];
    model.expand = !model.expand;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"cjw == before invoke reloload cell %p",[collectionView cellForItemAtIndexPath:indexPath]);
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        NSLog(@"cjw == after invoke reloload cell %p",[collectionView cellForItemAtIndexPath:indexPath]);
    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.layout handleReloadItem:indexPath];
//        [self.layout handleReloadItem:nil];
//    });
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cjw == willDisplayCell %p",cell);
}

@end
