//
//  UIView+Util.m
//  PaperUI
//
//  Created by Andy Wang on 2/19/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import "UIView+Util.h"

@implementation UIView (Util)

// helper to show subview colors (recursive)
//
- (void)showColoredBordersForSubviews
{
    int t = 100;
    CGFloat r = ((rand() % t) / (float)t);
    CGFloat g = ((rand() % t) / (float)t);
    CGFloat b = ((rand() % t) / (float)t);
    
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    for (UIView *v in self.subviews)
    {
        v.layer.borderColor = color.CGColor;
        v.layer.borderWidth = 2.0;
        [v showColoredBordersForSubviews];
    }
}

@end
