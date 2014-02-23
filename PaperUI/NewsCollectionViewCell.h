//
//  NewsCollectionViewCell.h
//  PaperUI
//
//  Created by Andy Wang on 2/23/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIImageView *iconView;
@property (nonatomic) UILabel *titleLabel;

+ (NSString *)reuseIdentifier;

@end
