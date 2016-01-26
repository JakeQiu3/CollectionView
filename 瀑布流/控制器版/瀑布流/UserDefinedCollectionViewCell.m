//
//  UserDefinedCollectionViewCell.m
//  瀑布流
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 QSY. All rights reserved.
//

#import "UserDefinedCollectionViewCell.h"

@implementation UserDefinedCollectionViewCell
//图片布局
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width/2,self.bounds.size.height);
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
