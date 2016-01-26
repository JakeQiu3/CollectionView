//
//  ImagesCollectionViewController.m
//  瀑布流
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 QSY. All rights reserved.
//

#import "ImagesCollectionViewController.h"
#import "UserDefinedCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface ImagesCollectionViewController ()
//声明属性
@property (nonatomic, retain)NSArray *array;//数据源用
@end

@implementation ImagesCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
  
// 注册collectionView的cell
    [self.collectionView registerClass:[UserDefinedCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//  注册区头区尾
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    

//  请求数据(本地)
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Data" ofType:@"json"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
//    数据解析放在数组里
            self.array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        }
        if (connectionError) {
            NSLog(@"%@",connectionError);
        }
        [self.collectionView reloadData];
    }];
}


//页眉和页脚重用(UICollectionReusableView)
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor redColor];
        //在其上放label控件
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        headerLabel.text = [NSString stringWithFormat:@"第%ld页眉",indexPath.section];
        [headerView addSubview:headerLabel];
        return headerView;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath ];
       footerView.backgroundColor = [UIColor greenColor];
        UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        footerLabel.text = [NSString stringWithFormat:@"第%ld分区",indexPath.section];
        [footerView addSubview:footerLabel];
        return footerView;
    }
}

#pragma mark <UICollectionViewDataSource>
//分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

//区的行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.array.count;
}
//Cell的重用(内容均在此赋值)
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UserDefinedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    从数组里取字典
    NSDictionary *dic = [self.array objectAtIndex:indexPath.item];
//   从字典里根据key得到value
#pragma mark ====UIImageView+WebCache.h第三方的使用=====
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"thumbURL"]]];
  
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
