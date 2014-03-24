//
//  NewsCollectionViewController.m
//  PaperUI
//
//  Created by Andy Wang on 2/23/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import "NewsCollectionViewController.h"
#import "NewsCollectionViewCell.h"
#import "SingleNewsViewController.h"
#import "SingleNewsTransitioningAnimator.h"

@interface NewsCollectionViewController () <UICollectionViewDataSource,
                                            UICollectionViewDelegate,
                                            UICollectionViewDelegateFlowLayout,
                                            UIGestureRecognizerDelegate,
                                            UIViewControllerTransitioningDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UIPanGestureRecognizer *panGesture;
@property (nonatomic) CGRect selectedCellFrame;
@end

@implementation NewsCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat x, y, w, h;
    x = 0;
    y = 0;
    w = self.view.bounds.size.width; //320
    h = 220;

    self.view.bounds = CGRectMake(0, 0, w, h);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 4.0f;
    layout.minimumInteritemSpacing = 0.0f;
    layout.itemSize = CGSizeMake(140, h);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[NewsCollectionViewCell class]
            forCellWithReuseIdentifier:[NewsCollectionViewCell reuseIdentifier]];
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.panGesture.minimumNumberOfTouches = 1;
    self.panGesture.maximumNumberOfTouches = 1;
    self.panGesture.delegate = self;
    //[self.collectionView addGestureRecognizer:self.panGesture];

    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NewsCollectionViewCell reuseIdentifier]
                                                                             forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    cell.titleLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *selectedCellView = [self.collectionView cellForItemAtIndexPath:indexPath];
    self.selectedCellFrame = [selectedCellView convertRect:selectedCellView.bounds toView:nil];    
    
    SingleNewsViewController *singleNewsVC = [[SingleNewsViewController alloc] initWithUniqueID:[NSString stringWithFormat:@"%d", indexPath.item]];
    singleNewsVC.transitioningDelegate = self;
    singleNewsVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:singleNewsVC animated:YES completion:nil];
}

#pragma mark - UIPanGestureRecognizer

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer
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
            CGPoint translation = [recognizer translationInView:self.view];
            NSLog(@"Panning with Translation (%f %f)\n", translation.x, translation.y);
            
            // CGPoint location = [recognizer locationInView:self.newsCollectionVC.view];
            // Preset: a y-translation of 40 will have a zoom of 2.28 from lower-left
            if (translation.y < 0) {
                CGFloat scale = MIN(1 + (-1 * translation.y) / 40.0 * 1.28, 3.0);
                self.view.layer.anchorPoint = CGPointMake(0.0, 1.0);
                self.view.transform = CGAffineTransformMakeScale(scale, scale);
                CGRect f = self.view.frame;
                f.origin.x = 0;
                f.origin.y = self.view.superview.bounds.size.height - f.size.height;
                self.view.frame = f;
            } else {
                CGFloat scale = 1;
                self.view.transform = CGAffineTransformMakeScale(scale, scale);
            }
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"******************** ENDED ********************\n");
            self.view.transform = CGAffineTransformIdentity;
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source
{
    SingleNewsTransitioningAnimator *animator = [[SingleNewsTransitioningAnimator alloc] init];
    animator.isPresenting = YES;
    animator.startingFrame = self.selectedCellFrame;
    return animator;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    SingleNewsTransitioningAnimator *animator = [[SingleNewsTransitioningAnimator alloc] init];
    animator.isPresenting = NO;
    animator.startingFrame = self.selectedCellFrame;
    return animator;
}

@end
