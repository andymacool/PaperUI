//
//  SingleNewsViewController.m
//  PaperUI
//
//  Created by Andy Wang on 2/14/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import "SingleNewsViewController.h"
#import "UIView+Util.h"

@interface SingleNewsViewController ()
@property (nonatomic, readwrite) NSString *uniqueID;
@end

@implementation SingleNewsViewController

- (id)initWithUniqueID:(NSString *)uniqueID
{
    self = [self initWithNibName:nil bundle:nil];
    
    if (self) {
        _uniqueID = uniqueID;
    }
    return self;
}

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
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UILabel *uniqueIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    uniqueIDLabel.text = self.uniqueID;
    [self.view addSubview:uniqueIDLabel];
}

@end
