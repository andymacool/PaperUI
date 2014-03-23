//
//  SettingsViewController.m
//  PaperUI
//
//  Created by Andy Wang on 3/21/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];
}

- (void)dismiss
{
    NSLog(@"Dismissing SettingsVC: MainVC.view is %@, SettingsVC.view is %@ \n", self.presentingViewController.view, self.view);

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
