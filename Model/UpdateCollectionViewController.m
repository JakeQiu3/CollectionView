//
//  UpdateCollectionViewController.m
//  Model
//
//  Created by 邱少依 on 16/1/28.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "UpdateCollectionViewController.h"

@interface UpdateCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *letterArray;

@end

@implementation UpdateCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _letterArray = [[NSMutableArray alloc] init];
    [_letterArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_letterArray addObject:[NSString stringWithFormat:@"http://www.cnblogs.com/wayne23/p/4062197.html",]];
    } ];
}

- (void)setUI {
    
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
