//
//  ImageHeaderCollectionReusableView
//
//  Created by 邱少依 on 16/1/27.
//  Copyright © 2016年 QSY. All rights reserved.
//


#import "ImageHeaderCollectionReusableView.h"
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define headerViewH 100
#define titleLabelH 40
@implementation ImageHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}
- (void)initLayout {
    //  背景view
    UIView *backView = [[UIView alloc]init];
    backView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    backView.backgroundColor = [UIColor yellowColor];
    [self addSubview:backView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, backView.bounds.size.width, titleLabelH)];
    _titleLabel.textColor = [UIColor redColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [backView addSubview:_titleLabel];
}

+ (CGSize)sizeForCell {
    static CGSize size = {0,0};
    if (!size.width) {
        size.width = screenWidth;
        size.height = headerViewH;
    }
    return size;
}
@end

