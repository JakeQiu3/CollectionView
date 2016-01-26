//
//  CollectionViewController.m
//  Model
//
//  Created by qsyMac on 16/1/27.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSArray *_dataArray;
    
}

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFlowLayoutAndCollectionView];//初始化布局和CollectionView
    [self registerCellAndheaderFooter];//注册cell和区头区尾
    

}

- (void)initFlowLayoutAndCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    flowLayout.footerReferenceSize = CGSizeMake(100, 100);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 15;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
    flowLayout.itemSize = CGSizeMake(100, 150);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];//frame 是collectionView的可视区域。
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    
}

- (void)registerCellAndheaderFooter {
    [_collectionView registerClass:<#(nullable Class)#> forCellWithReuseIdentifier:<#(nonnull NSString *)#>];
    [_collectionView registerClass:<#(nullable Class)#> forSupplementaryViewOfKind:<#(nonnull NSString *)#> withReuseIdentifier:<#(nonnull NSString *)#>];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
