    //
//  MainViewController.m
//  PaperUI
//
//  Created by Andy Wang on 2/14/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import "MainViewController.h"
#import "NewsCollectionViewController.h"
#import "SettingsViewController.h"
#import "SettingsTransitioningAnimator.h"
#import "UIView+Util.h"

@interface MainViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic) NewsCollectionViewController *newsCollectionVC;
@property (nonatomic) UISwipeGestureRecognizer *swipeDownGesture;
@property (nonatomic) UITapGestureRecognizer *singleTap;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];
    
    self.newsCollectionVC = [[NewsCollectionViewController alloc] init];
    
    CGFloat x, y, w, h;
    w = self.view.bounds.size.width;
    h = 220;
    x = 0;
    y = self.view.bounds.size.height - h;

    [self addChildViewController:self.newsCollectionVC];
    [self.view addSubview:self.newsCollectionVC.view];
    [self.newsCollectionVC didMoveToParentViewController:self];
    
    
    // re-position y
    CGRect f = self.newsCollectionVC.view.frame;
    f.origin.y = y;
    self.newsCollectionVC.view.frame = f;
    
    self.swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    self.swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
    self.swipeDownGesture.enabled = YES;
    [self.view addGestureRecognizer:self.swipeDownGesture];

    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    
    [self.view showColoredBordersForSubviews];
}

#pragma mark - UISwipeGestureRecognizer
- (IBAction)handleSwipeDown:(UIPanGestureRecognizer *)recognizer
{
    NSLog(@"handleSwipeDown ... \n");
    SettingsViewController *settingsVC = [[SettingsViewController alloc] init];
    settingsVC.modalPresentationStyle = UIModalPresentationCustom;
    settingsVC.transitioningDelegate = self;
    [self presentViewController:settingsVC animated:YES completion:^{
        self.swipeDownGesture.enabled = NO;
        NSLog(@"Presented SettingsVC: MainVC.view is %@, SettingsVC.view is %@ \n", self.view, settingsVC.view);
    }];
}

#pragma mark - UIPanGestureRecognizer
- (IBAction)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.view.frame = CGRectMake(0, 0, 320, 568);
                         
                     } completion:^(BOOL finished) {
                         
                         [self dismissViewControllerAnimated:NO completion:^{
                             self.swipeDownGesture.enabled = YES;
                         }];
                     }];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    SettingsTransitioningAnimator *animator = [[SettingsTransitioningAnimator alloc] init];
    animator.isPresenting = YES;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    SettingsTransitioningAnimator *animator = [[SettingsTransitioningAnimator alloc] init];
    animator.isPresenting = NO;
    return animator;
}

@end
