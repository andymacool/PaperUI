//
//  SingleNewsTransitioningAnimator.h
//  PaperUI
//
//  Created by Andy Wang on 3/24/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleNewsTransitioningAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) BOOL isPresenting;    // YES if preseting, NO if dismissing

// the starting frame of toViewController
@property (nonatomic) CGRect startingFrame;

@end
