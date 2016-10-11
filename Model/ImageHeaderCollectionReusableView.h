//
//  ImageHeaderCollectionReusableView
//
//  Created by 邱少依 on 16/1/27.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageHeaderCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;

+ (CGSize)sizeForCell;
@end
