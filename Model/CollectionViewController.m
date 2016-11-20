//
//  CollectionViewController.m
//  Model
//
//  Created by qsyMac on 16/1/27.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "CollectionViewController.h"
#import "ImageHeaderCollectionReusableView.h"
#import "ImageFooterCollectionReusableView.h"
#import "ImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
static NSString * const cellIndetifier = @"imageCollceitonCell";
static NSString * const headerIndetifier = @"qsyHeaderIndetifier";
static NSString * const footerIndetifier = @"qsyFooterIndetifier";
@interface CollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    UICollectionView *_collectionView;
    NSArray *_titleArray;
    NSArray *_imageArray;
    UIScrollView *bgScrollview;
}

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addbgScrollview];//添加父视图为 Scrollview
    [self initFlowLayoutAndCollectionView];//初始化布局和CollectionView
    [self registerCellAndheaderFooter];//注册cell和区头区尾
    [self addData];//添加数据
    
}

- (void)addbgScrollview {
    bgScrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:bgScrollview];
}

- (void)initFlowLayoutAndCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.headerReferenceSize = CGSizeMake(100, 100); //区头区尾的宽度默认都是屏宽（竖向是屏宽，竖向是屏高）
    flowLayout.footerReferenceSize = CGSizeMake(100, 100);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 15;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//横向滚动UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
    flowLayout.itemSize = CGSizeMake(100, 150);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, bgScrollview.bounds.size.width, bgScrollview.bounds.size.height-64)  collectionViewLayout:flowLayout];// 不能直接使用 bgScrollview.bounds，contentSize本身是从 （0，0） 开始，但_collectionView实际可视的位置是（64，0），是contentSize的位置上移了
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [bgScrollview addSubview:_collectionView];
}

- (void)addData {
    _titleArray = @[@"我帅故我在",@"我思故我存",@"我知故我明",@"我理故我雅"];
    
    NSString *fileStr = [[NSBundle mainBundle]pathForResource:@"Data" ofType:@"json"];
    NSURL *url = [NSURL fileURLWithPath:fileStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSLog(@"数据请求失败");
        }
        NSError *error;
        _imageArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        [_collectionView reloadData];
    }];
}

// 注册cell和headerfooter
- (void)registerCellAndheaderFooter {
    
    [_collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:cellIndetifier];
    
    [_collectionView registerClass:[ImageHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIndetifier];
    
    [_collectionView registerClass:[ImageFooterCollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIndetifier];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *resusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        ImageHeaderCollectionReusableView *headerView = (ImageHeaderCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIndetifier forIndexPath:indexPath];
        headerView.titleLabel.text = [NSString stringWithFormat:@"我是区头的%d，我骄傲",indexPath.section];
        CGSize headerSize =   [ImageHeaderCollectionReusableView sizeForCell];
        headerView.size = headerSize;
        resusableView = headerView;
    } else {
        ImageFooterCollectionReusableView *footerView = (ImageFooterCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIndetifier forIndexPath:indexPath];
        footerView.titleLabel.text = [NSString stringWithFormat:@"我是区尾的%d，我特么自豪",indexPath.section];
        [ImageFooterCollectionReusableView sizeForCell];
        resusableView = footerView;
    }
    return resusableView;
}

#pragma mark 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;//_imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndetifier forIndexPath:indexPath];
    
    cell.titlLabel.text = @"我思故我在";//_titleArray[indexPath.item];
    NSDictionary *dic = [_imageArray objectAtIndex:indexPath.item];
    NSURL *imageUrl = [NSURL URLWithString:[dic objectForKey:@"thumbURL"]];
    [cell.imageV sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"占位图"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"我就是测一测是%d区的%d",indexPath.section,indexPath.item);
}

#pragma mark layout布局方法
// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0 ) {
        return 10;
    } else return 20;
    
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0 ) {
        return 5;
    } else return 15;
    
}

@end
