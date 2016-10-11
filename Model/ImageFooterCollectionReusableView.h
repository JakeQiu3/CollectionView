//
//  ImageFooterCollectionReusableView.h
//  Model
//
//  Created by 邱少依 on 16/9/28.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageFooterCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong) UILabel *titleLabel;
+ (CGSize)sizeForCell;
@end
