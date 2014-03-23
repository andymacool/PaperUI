//
//  SettingsTransitioningAnimator.h
//  PaperUI
//
//  Created by Andy Wang on 3/21/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsTransitioningAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) BOOL isPresenting;    // YES if preseting, NO if dismissing

@end
