//
//  YelpReviewUserObject.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/25/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpObject.h"

@interface YelpReviewUserObject : YelpObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSURL *userImageURL;

@end
