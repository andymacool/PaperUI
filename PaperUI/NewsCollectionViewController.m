//
//  NewsCollectionViewController.m
//  PaperUI
//
//  Created by Andy Wang on 2/23/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import "NewsCollectionViewController.h"
#import "NewsCollectionViewCell.h"

@interface NewsCollectionViewController () <UICollectionViewDataSource,
                                            UICollectionViewDelegate,
                                            UICollectionViewDelegateFlowLayout>

@property (nonatomic) UICollectionView *collectionView;
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


@end
