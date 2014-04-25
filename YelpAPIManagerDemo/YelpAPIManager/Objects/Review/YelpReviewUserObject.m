//
//  YelpReviewUserObject.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/25/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpReviewUserObject.h"

@implementation YelpReviewUserObject

- (void)parseWithDataDictionary:(NSDictionary *)data {
    self.userId = data[@"id"];
    self.username = data[@"name"];
    self.userImageURL = [NSURL URLWithString:data[@"image_url"]];
}

@end
