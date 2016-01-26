//
//  PicCollectionViewCell.m
//  collectionView  collextionView
//
//  Created by qsy on 15/7/6.
//  Copyright (c) 2015年 qsy. All rights reserved.
//

#import "PicCollectionViewCell.h"

@implementation PicCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
//        给cell的添加一个视图;
        self.imageView=[[UIImageView alloc]init];
        self.imageView.frame= self.contentView.bounds;
        _imageView.backgroundColor=[UIColor yellowColor];
//     contentciew是cell的自带视图;
        [self.contentView addSubview:_imageView];
    
         
        /*
       self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.bounds.origin.x, self.contentView.bounds.origin.y, self.contentView.bounds.size.height, self.contentView.bounds.size.width-10)];
        
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.height,self.contentView.bounds.size.width+5, self.contentView.bounds.size.height, 5)];
        
        self.contentView.backgroundColor=[UIColor yellowColor];
        self.imageView.backgroundColor=[UIColor redColor];
        title.backgroundColor=[UIColor blueColor];
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:title];
       
 */
        
        
    }
    
        
        
        
    return self;
}







@end
