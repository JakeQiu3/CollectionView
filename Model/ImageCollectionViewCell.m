//
//  ImageCollectionViewCell.m
//  Model
//
//  Created by 邱少依 on 16/1/27.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        [self initLayout];
    }
    return self;
}
//根据item的尺寸来布局
- (void)initLayout {
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20);
    imageV.contentMode = UIViewContentModeScaleAspectFit;//UIViewContentModeScaleToFill 平铺满imgeView;
    [self.contentView addSubview:imageV];
    self.imageV = imageV;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, CGRectGetMaxY(imageV.frame), imageV.frame.size.width, 20);
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    self.titlLabel = titleLabel;
}

@end
