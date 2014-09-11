//
//  YMViewController.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/21/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YMViewController.h"
#import "YelpAPIManager.h"

@interface YMViewController ()

@end

@implementation YMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self search];
    
    //[self business];
}

#pragma mark - Sample Calls

- (void)search {
    
    //TODO: Comment this to disable logging.
    [[YelpAPIManager sharedInstance] setIsLogEnabled:YES];
    
    [[YelpAPIManager sharedInstance] searchTerm:nil
                                   neighborhood:@"New York"
                                     coordinate:kCLLocationCoordinate2DInvalid
                                       location:nil
                                          limit:2
                                         offset:0
                                           sort:YelpSearchSortByBestMatch
                                 categoryFilter:@"food"
                                         radius:0
                                           deal:YES];
}

- (void)business {
    [[YelpAPIManager sharedInstance] findBusinessId:@"juice-hugger-cafe-brooklyn" countryCode:nil languageCode:nil reviewLanguageFilter:NO];
}

@end
