//
//  NewsFetcher.h
//  PaperUI
//
//  Created by Andy Wang on 2/19/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Serve as Data Model Provider
 */

@interface NewsFetcher : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)fetchedNews;

@end
