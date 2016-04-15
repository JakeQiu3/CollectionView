//
//  CollectionViewController.m
//  Model
//
//  Created by qsyMac on 16/1/27.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "CollectionViewController.h"
#import "ImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"
static NSString * const cellIndetifier = @"imageCollceitonCell";
static NSString * const headerIndetifier = @"headerIndetifier";
static NSString * const footerIndetifier = @"footerIndetifier";
@interface CollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSArray *_titleArray;
    NSArray *_imageArray;
    
}

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFlowLayoutAndCollectionView];//初始化布局和CollectionView
    [self registerCellAndheaderFooter];//注册cell和区头区尾
    [self addData];//添加数据

}

- (void)initFlowLayoutAndCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    区头区尾的宽度默认都是屏宽（竖向是屏宽，竖向是屏高）
    flowLayout.headerReferenceSize = CGSizeMake(100, 100);
    flowLayout.footerReferenceSize = CGSizeMake(100, 100);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 15;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
    flowLayout.itemSize = CGSizeMake(100, 150);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];//frame 是collectionView的可视区域。
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];

    
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

- (void)registerCellAndheaderFooter {
    
    [_collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:cellIndetifier];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIndetifier];
    
    [_collectionView registerClass:[UICollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIndetifier];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
 
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIndetifier forIndexPath:indexPath];
//      背景视图
        UIView *backView = [[UIView alloc]init];
        backView.frame = CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height);
        backView.backgroundColor = [UIColor yellowColor];
        [headerView addSubview:backView];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, backView.bounds.size.width, backView.bounds.size.height);
         [backView addSubview:label];
        if (indexPath.section == 0) {//分区0
            label.text = @"我是区头0";
        } else {
            label.text = @"我是区头1";
        }
        return headerView;
    } else {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIndetifier forIndexPath:indexPath];
        //      背景视图
        UIView *backView = [[UIView alloc]init];
        backView.frame = CGRectMake(0, 0, footerView.frame.size.width, footerView.frame.size.height);
        backView.backgroundColor = [UIColor redColor];
        [footerView addSubview:backView];

        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, backView.bounds.size.width, backView.bounds.size.height);
        [footerView addSubview:label];
        if (indexPath.section == 0) {//分区0
            label.text = @"我是区尾0";
        } else {
            label.text = @"我是区尾1";
        }

        return footerView;
    }
  
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
    
    cell.titlLabel.text = _titleArray[indexPath.item];
    NSDictionary *dic = [_imageArray objectAtIndex:indexPath.item];
    NSURL *imageUrl = [NSURL URLWithString:[dic objectForKey:@"thumbURL"]];
    [cell.imageV sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"占位图"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
