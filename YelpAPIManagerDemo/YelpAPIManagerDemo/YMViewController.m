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
    
    [[YelpAPIManager sharedInstance] search];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
