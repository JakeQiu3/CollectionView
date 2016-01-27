//
//  ViewController.m
//  Model
//
//  Created by qsyMac on 16/1/22.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "ViewController.h"
#import "QSYCollectionViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_fileNameArray;
    NSMutableArray *_titileArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setUI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadData {
    _fileNameArray = @[@"瀑布流 controller版",@"瀑布流 view版"].mutableCopy;
    _titileArray = @[@"QSYCollectionViewController",@"CollectionViewController"].mutableCopy;
}
- (void)setUI {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    _tableView.rowHeight = 50;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor blackColor];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titileArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *qsyIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:qsyIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:qsyIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@" %ld: %@",(long)indexPath.row,_fileNameArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cls;
//    不同类型(特指出结构体类型)和字符串之间转换
    cls = NSClassFromString(_titileArray[indexPath.row]);
    
//  CollectionView的布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//  区头区尾的宽度默认都是屏宽（竖向是屏宽，竖向是屏高）
    flowLayout.headerReferenceSize = CGSizeMake(100, 100);
    flowLayout.footerReferenceSize = CGSizeMake(100, 100);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 15;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
    flowLayout.itemSize = CGSizeMake(100, 150);
    
    
    UIViewController *viewC;
    if (indexPath.item == 0) {
        viewC = [[cls alloc] initWithCollectionViewLayout:flowLayout];
    } else {
        viewC = [[cls alloc] init];
    }
    [self.navigationController pushViewController:viewC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

@end
