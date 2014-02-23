//
//  NewsFetcher.m
//  PaperUI
//
//  Created by Andy Wang on 2/19/14.
//  Copyright (c) 2014 Andy Wang. All rights reserved.
//

#import "NewsFetcher.h"

@implementation NewsFetcher

+ (instancetype)sharedInstance
{
    static NewsFetcher *gInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gInstance = [[NewsFetcher alloc] init];
    });
    return gInstance;
}

- (NSArray *)fetchedNews
{
    return @[@"A",@"B",@"C",@"D",@"E"];
}

@end
