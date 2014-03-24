//
//  MultiPageViewController.m
//  PaperUI
//
//  Created by Andy Wang on 3/24/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import "MultiPageViewController.h"
#import "SingleNewsViewController.h"

@interface MultiPageViewController ()
@property (nonatomic) UIScrollView *scrollView;
@end

@implementation MultiPageViewController

- (void)addNewChildController:(UIViewController *)newChildController
{
    CGFloat x, y, w, h;
    x = self.scrollView.frame.origin.x + self.scrollView.contentSize.width;
    y = 0;
    w = 140;
    h = self.scrollView.bounds.size.height;

    newChildController.view.frame = CGRectMake(x, y, w, h);

    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width + 140,
                                             self.scrollView.contentSize.height);
    
    [self addChildViewController:newChildController];
    [self.scrollView addSubview:newChildController.view];
    [newChildController didMoveToParentViewController:self];
}

- (void)removeOldChildController:(UIViewController *)oldChildController
{
    [oldChildController willMoveToParentViewController:nil];
    if (oldChildController.isViewLoaded) {
        [oldChildController.view removeFromSuperview];
    }
    [oldChildController removeFromParentViewController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat x, y, w, h;
    x = 0;
    y = 0;
    w = self.view.bounds.size.width;
    h = 220;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.scrollView.contentSize = CGSizeZero;
    [self.view addSubview:self.scrollView];
    
    SingleNewsViewController *vc1 = [[SingleNewsViewController alloc] initWithUniqueID:@"1"];
    SingleNewsViewController *vc2 = [[SingleNewsViewController alloc] initWithUniqueID:@"2"];
    SingleNewsViewController *vc3 = [[SingleNewsViewController alloc] initWithUniqueID:@"3"];
    SingleNewsViewController *vc4 = [[SingleNewsViewController alloc] initWithUniqueID:@"4"];
    SingleNewsViewController *vc5 = [[SingleNewsViewController alloc] initWithUniqueID:@"5"];

    [self addNewChildController:vc1];
    [self addNewChildController:vc2];
    [self addNewChildController:vc3];
    [self addNewChildController:vc4];
    [self addNewChildController:vc5];
}

@end
