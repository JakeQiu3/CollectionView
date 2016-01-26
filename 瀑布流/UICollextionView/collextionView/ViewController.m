//
//  ViewController.m
//  collectionView  collextionView
//
//  Created by qsy on 15/7/6.
//  Copyright (c) 2015年 qsy. All rights reserved.
//

#import "ViewController.h"
#import "PicCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain)NSArray *dataArry;//作为collectionview的数据源来使用;
@end

@implementation ViewController
static NSString * const reuseIdentifier = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//  创建flowlayout类对象   来管理cell的属性；
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
//    设置行之间的间隔；
    layout.minimumLineSpacing=40;
//    设置列之间的间隔；
    layout.minimumInteritemSpacing=40;
//设置item（cell）的大小；
    layout.itemSize=CGSizeMake(150, 150);
//   collectionView  可以设置横向和竖向的滚动；默认滚动方向是竖向的；在横向和竖向滚动状态下他的行和列的设置是不同的；横向状态下他的行是竖向状态下的列；横向的列是竖向的行；
    layout.scrollDirection=UICollectionViewScrollDirectionVertical
    ;
    
//   设置页眉的大小；
    layout.headerReferenceSize=CGSizeMake(0, 50);
//    设置页脚的大小；
    layout.footerReferenceSize=CGSizeMake(0, 50);
//    设置分区上下左右的边距；
    layout.sectionInset=UIEdgeInsetsMake(20, 10, 20, 10);
    
//    2.设置代理，创建collectionView对象，设置代理，设置数据源，它只能利用它的子类layout来实现元素；
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate=self;
    collectionView.dataSource=self;
    
    [self.view addSubview:collectionView];
 

    
//    3.注册cell   collectionviewcell 上面只有一个子视图是contentview，不像tableview一样有系统提供的四种样式；所以使用时必须自定义；
    [collectionView registerClass:[PicCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
//    注册页眉和页脚;页眉和页脚的类型UICollectionReusableView；kind表示是页眉和页脚;
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
//    注册页脚
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];

//  4.请求数据
    //    创建url对象；使用工程中的本地文件创建url对象，文件地址不要使用绝对路径，使用相对路径，相对于工程bundle;
    NSURL *url=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Data" ofType:@"json"]];
    
    //    创建一个request的对象
    NSURLRequest *requset=[NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:requset queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //        请求到数据进行解析;
        self.dataArry=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //        刷新collectionview
        [collectionView reloadData];
    }];

//设置collectionView的背景
      collectionView.backgroundColor = [UIColor grayColor];
    
}


#pragma mark -代理方法 -
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArry.count;
}

//设置collectionview的页眉页脚   kind判断设置的是页眉还是页脚；
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind==UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.backgroundColor=[UIColor redColor];
        //        创建label
        UILabel *sectionLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        sectionLabel.backgroundColor = [UIColor whiteColor];
        sectionLabel.text=[NSString stringWithFormat:@"在第%ld个分区",indexPath.section];
        [headerView addSubview:sectionLabel];
        return headerView;
    }else{
        UICollectionReusableView *footer=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.backgroundColor=[UIColor blueColor];
        return footer;
        
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PicCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
//    在tavelview 中indexpath中有两个值section和row；
//    在conllectionview中没有row的概念，只有section和item；item是元素的位置;
    NSDictionary *dic=[self.dataArry objectAtIndex:indexPath.item];
    
//    SDWebImage主要显示uiimageview的分类，所有uiimageview对象和它的子类对象都可以直接使用分类的方法；

    [cell.imageView sd_setImageWithURL:[NSURL  URLWithString:[dic objectForKey:@"thumbURL"]]];
    

    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
