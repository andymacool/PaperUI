//
//  MainViewController.m
//  PaperUI
//
//  Created by Andy Wang on 2/14/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import "MainViewController.h"
#import "NewsCollectionViewController.h"
#import "SingleNewsViewController.h"
#import "UIView+Util.h"
#import "NewsFetcher.h"

@interface MainViewController () <UIGestureRecognizerDelegate>
@property (nonatomic) NewsCollectionViewController *newsCollectionVC;
@property (nonatomic) UIPanGestureRecognizer *panGesture;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.panGesture.minimumNumberOfTouches = 1;
    self.panGesture.maximumNumberOfTouches = 1;
    self.panGesture.delegate = self;
    [self.newsCollectionVC.view addGestureRecognizer:self.panGesture];

    [self.view showColoredBordersForSubviews];
}

#pragma mark - UIPanGestureRecognizer
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"******************** BEGIN ********************\n");
            break;
        }
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.newsCollectionVC.view];
            NSLog(@"Panning with Translation (%f %f)\n", translation.x, translation.y);
            
            // CGPoint location = [recognizer locationInView:self.newsCollectionVC.view];
            // Preset: a y-translation of 40 will have a zoom of 2.28 from lower-left
            if (translation.y < 0) {
                CGFloat scale = MIN(1 + (-1 * translation.y) / 40.0 * 1.28, 3.0);
                self.newsCollectionVC.view.layer.anchorPoint = CGPointMake(0.0, 1.0);
                self.newsCollectionVC.view.transform = CGAffineTransformMakeScale(scale, scale);
                CGRect f = self.newsCollectionVC.view.frame;
                f.origin.x = 0;
                f.origin.y = self.view.bounds.size.height - f.size.height;
                self.newsCollectionVC.view.frame = f;
            } else {
                CGFloat scale = 1;
                self.newsCollectionVC.view.transform = CGAffineTransformMakeScale(scale, scale);
            }
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"******************** ENDED ********************\n");
            self.newsCollectionVC.view.transform = CGAffineTransformIdentity;
            break;
        }

        default:
            break;
    }
}

@end
