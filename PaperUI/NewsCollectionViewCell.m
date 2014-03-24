//
//  NewsCollectionViewCell.m
//  PaperUI
//
//  Created by Andy Wang on 2/23/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import "NewsCollectionViewCell.h"

@implementation NewsCollectionViewCell

+ (NSString *)reuseIdentifier
{
    return @"NewsCollectionViewCell";
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_titleLabel];
        
        _iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_iconView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    
    x = 10;
    y = 10;
    w = 40;
    h = 40;
    self.iconView.frame = CGRectMake(x, y, w, h);

    x = x;
    y = CGRectGetMaxY(self.iconView.frame) + 4.0;
    w = self.contentView.bounds.size.width - 2 * x;
    h = 20;
    
    self.titleLabel.frame = CGRectMake(0, 0, w, h);
}

@end
