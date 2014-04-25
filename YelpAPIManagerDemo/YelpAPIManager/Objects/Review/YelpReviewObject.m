//
//  YelpReviewObject.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/25/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpReviewObject.h"

@implementation YelpReviewObject

- (void)parseWithDataDictionary:(NSDictionary *)data {
    self.excerpt = data[@"excerpt"];
    self.reviewId = data[@"id"];
    self.rating = [data[@"rating"] floatValue];
    self.ratingImageLargeURL = [NSURL URLWithString:data[@"rating_image_large_url"]];
    self.ratingImageSmallURL = [NSURL URLWithString:data[@"rating_image_small_url"]];
    self.ratingImageURL = [NSURL URLWithString:data[@"rating_image_url"]];
    self.timeCreated = [data[@"time_created"] integerValue];
    
    NSDictionary *reviewUser = data[@"user"];
    if (reviewUser) {
        YelpReviewUserObject *userObject = [YelpReviewUserObject objectWithDictionary:reviewUser];
        self.reviewUser = userObject;
    }
}

@end
