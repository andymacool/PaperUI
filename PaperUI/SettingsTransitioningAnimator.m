//
//  SettingsTransitioningAnimator.m
//  PaperUI
//
//  Created by Andy Wang on 3/21/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import "SettingsTransitioningAnimator.h"

static const CGFloat SettingsTransitioningAnimatorDuration = 1.0;

@implementation SettingsTransitioningAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return SettingsTransitioningAnimatorDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    if (self.isPresenting) {

        /* The fromViewController.view is already a subview of the containerView,
           but it is OK to call addSubview: again, it will not add a second one.
           The order here is important to keep the view hierarchy correct.
         */
        [[transitionContext containerView] addSubview:toViewController.view];
        [[transitionContext containerView] addSubview:fromViewController.view];

        toViewController.view.frame = CGRectMake(0, 0, 320, 568);
        toViewController.view.transform = CGAffineTransformMakeScale(0.95, 0.95);
        toViewController.view.alpha = 0.5;

        CGRect f = fromViewController.view.frame;
        f.origin.y = 500;

        [UIView animateWithDuration:SettingsTransitioningAnimatorDuration
                              delay:0.0
             usingSpringWithDamping:1.0
              initialSpringVelocity:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{

                             // move down the fromVC
                             fromViewController.view.frame = f;
                             
                             toViewController.view.transform = CGAffineTransformIdentity;
                             toViewController.view.alpha = 1.0;
                             
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    } else {
        
        NSLog(@"Dismissing SettingsVC: MainVC.view is %@, SettingsVC.view is %@ \n", toViewController.view, fromViewController.view);

        CGRect endFrame = CGRectMake(0, 100, 320, 568);
        
        [UIView animateWithDuration:2.0
                              delay:0.0
             usingSpringWithDamping:1.0
              initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             fromViewController.view.alpha = 0.5;
                             fromViewController.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                             
                             toViewController.view.frame = endFrame;
                             
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }];
    }
}

@end
