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

@interface MainViewController () <UIPageViewControllerDataSource>
@property (nonatomic) UIPanGestureRecognizer *panGesture;
@property (nonatomic) UIPageViewController *newsPageVC;
@property (nonatomic) NewsCollectionViewController *newsCollectionVC;
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.newsCollectionVC = [[NewsCollectionViewController alloc] init];
    
    CGFloat x, y, w, h;
    w = self.view.bounds.size.width;
    h = 220;
    x = 0;
    y = self.view.bounds.size.height - h;
    self.newsCollectionVC.view.frame = CGRectMake(x, y, w, h);

    [self addChildViewController:self.newsCollectionVC];
    [self.view addSubview:self.newsCollectionVC.view];
    [self.newsCollectionVC didMoveToParentViewController:self];

    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.panGesture.minimumNumberOfTouches = 1;
    self.panGesture.maximumNumberOfTouches = 1;
    [self.newsCollectionVC.view addGestureRecognizer:self.panGesture];

#if 0
    // create a child view controller to display "pages of news"
    NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey: [NSNumber numberWithFloat:10.0f],
                              UIPageViewControllerOptionSpineLocationKey: [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMid]};
    
    self.newsPageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                      navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                    options:options];
    
    CGFloat x, y, w, h;
    w = self.view.bounds.size.width;
    h = 250;
    x = 0;
    y = self.view.bounds.size.height - h;
    self.newsPageVC.view.frame = CGRectMake(x, y, w, h);
    self.newsPageVC.dataSource = self;
    
    // create first page
    NSString *firstID = [[NewsFetcher sharedInstance].fetchedNews objectAtIndex:0];
    SingleNewsViewController *firstNewsVC = [[SingleNewsViewController alloc] initWithUniqueID:firstID];

    [self.newsPageVC setViewControllers:@[firstNewsVC]
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];

    // add child vc
    [self addChildViewController:self.newsPageVC];
    [self.view addSubview:self.newsPageVC.view];
    [self.newsPageVC didMoveToParentViewController:self];
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.newsPageVC.view addGestureRecognizer:self.panGesture];
#endif

    [self.view showColoredBordersForSubviews];
}

#pragma mark - UIPanGestureRecognizer
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.newsCollectionVC.view];
    NSLog(@"Panning with Translation (%f %f)\n", translation.x, translation.y);
    
    // Preset: a y-translation of 40 will have a zoom of 2.28 from lower-left
    if (translation.y < 0) {
        CGFloat scale = 1 + (-1 * translation.y) / 40.0 * 1.28;
        self.newsCollectionVC.view.transform = CGAffineTransformMakeScale(scale, scale);
    } else {
        CGFloat scale = 1;
        self.newsCollectionVC.view.transform = CGAffineTransformMakeScale(scale, scale);
    }
}


#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    SingleNewsViewController *currentVC = (SingleNewsViewController *)viewController;
    
    NSUInteger currentIndex = [[NewsFetcher sharedInstance].fetchedNews indexOfObject:currentVC.uniqueID];

    if (currentIndex == 0) {
        return nil;
    }
    
    NSString *beforeID = [[NewsFetcher sharedInstance].fetchedNews objectAtIndex:currentIndex - 1];
    SingleNewsViewController *beforeVC = [[SingleNewsViewController alloc] initWithUniqueID:beforeID];
    return beforeVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    SingleNewsViewController *currentVC = (SingleNewsViewController *)viewController;
    
    NSUInteger currentIndex = [[NewsFetcher sharedInstance].fetchedNews indexOfObject:currentVC.uniqueID];
    
    if (currentIndex == [NewsFetcher sharedInstance].fetchedNews.count - 1) {
        return nil;
    }
    
    NSString *afterID = [[NewsFetcher sharedInstance].fetchedNews objectAtIndex:currentIndex + 1];
    SingleNewsViewController *afterVC = [[SingleNewsViewController alloc] initWithUniqueID:afterID];
    return afterVC;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [[NewsFetcher sharedInstance] fetchedNews].count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
