//
//  YelpReviewObject.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/25/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpObject.h"
#import "YelpReviewUserObject.h"

@interface YelpReviewObject : YelpObject
@property (nonatomic, strong) NSString *excerpt;
@property (nonatomic, strong) NSString *reviewId;
@property (nonatomic, assign) CGFloat rating;

@property (nonatomic, strong) NSURL *ratingImageLargeURL;
@property (nonatomic, strong) NSURL *ratingImageSmallURL;
@property (nonatomic, strong) NSURL *ratingImageURL;

@property (nonatomic, assign) NSTimeInterval timeCreated; //sinceUnixEpoch
@property (nonatomic, strong) YelpReviewUserObject *reviewUser;
@end
