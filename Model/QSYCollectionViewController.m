//
//  QSYCollectionViewController.m
//  Model
//
//  Created by qsyMac on 16/1/27.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "QSYCollectionViewController.h"
#import "ImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface QSYCollectionViewController ()<UICollectionViewDelegateFlowLayout>
{
    NSArray *_titleArray;
    NSArray *_imageArray;
}
@end

@implementation QSYCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const headerIndetifier = @"headerInden";
static NSString * const footerIndetifier = @"footerInden";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self registerCellAndheaderFooter];//注册cell和区头区尾
    [self addData];//添加数据

}
- (void)registerCellAndheaderFooter {
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIndetifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIndetifier];
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
        [self.collectionView reloadData];
    }];

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIndetifier forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor yellowColor];
        UILabel *label = [[UILabel alloc] init];
//        label.frame = CGRectMake(0, 0, headerView.bounds.size.width, headerView.bounds.size.height);
        label.frame = CGRectMake(10, 0, 100, 100);
        label.text = @"我是区头";
        [headerView addSubview:label];
        return headerView;
        
    } else {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIndetifier forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor yellowColor];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, footerView.bounds.size.width, footerView.bounds.size.height);
        label.text = @"我是区尾";
        [footerView addSubview:label];
        return footerView;
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.titlLabel.text = _titleArray[indexPath.item];
    NSDictionary *dic = [_imageArray objectAtIndex:indexPath.item];
    NSURL *imageUrl = [NSURL URLWithString:[dic objectForKey:@"thumbURL"]];
    [cell.imageV sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"占位图"]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}


@end
