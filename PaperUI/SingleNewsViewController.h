//
//  SingleNewsViewController.h
//  PaperUI
//
//  Created by Andy Wang on 2/14/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleNewsViewController : UIViewController

@property (nonatomic, readonly) NSString *uniqueID;

- (id)initWithUniqueID:(NSString *)uniqueID;

@end
