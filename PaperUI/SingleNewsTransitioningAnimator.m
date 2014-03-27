//
//  SingleNewsTransitioningAnimator.m
//  PaperUI
//
//  Created by Andy Wang on 3/24/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import "SingleNewsTransitioningAnimator.h"

static const NSTimeInterval SingleNewsTransitioningAnimatorDuration = 0.7;

@implementation SingleNewsTransitioningAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return SingleNewsTransitioningAnimatorDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (self.isPresenting) {
        
        [[transitionContext containerView] addSubview:fromViewController.view];
        [[transitionContext containerView] addSubview:toViewController.view];
        
        CGRect endFrame = toViewController.view.frame;
        toViewController.view.frame = self.startingFrame;
        
        [UIView animateWithDuration:SingleNewsTransitioningAnimatorDuration
                              delay:0.0
             usingSpringWithDamping:1.0
              initialSpringVelocity:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             toViewController.view.frame = endFrame;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    } else {
        
        CGRect endFrame = self.startingFrame;
        
        [UIView animateWithDuration:SingleNewsTransitioningAnimatorDuration
                              delay:0.0
             usingSpringWithDamping:1.0
              initialSpringVelocity:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             fromViewController.view.frame = endFrame;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];

    }
}

@end
