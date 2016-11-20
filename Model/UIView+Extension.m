//
//  UIView+Extension.m
//  Model
//
//  Created by qsyMac on 16/11/20.
//  Copyright © 2016年 QSY. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
-(void)setX:(CGFloat)x
 {
    CGRect frame = self.frame;
    frame.origin.x = x;
     self.frame = frame;
    }
-(CGFloat)x {
       return self.frame.origin.x;
    }

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size =size;
    self.frame = frame;
    }
-(CGSize)size{
    return self.frame.size;
    }
@end
