//
//  YelpDealObject.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpDealObject.h"
#import "YelpDealOption.h"
#import <objc/objc-runtime.h>

@implementation YelpDealObject

- (void)parseWithDataDictionary:(NSDictionary *)data {
    
    self.additionalRestriction = data[@"additional_restrictions"];
    self.importantRestriction = data[@"important_restrictions"];
    self.currencyCode = data[@"currency_code"];
    self.dealId = data[@"id"];
    self.dealImageURL = [NSURL URLWithString:data[@"image_url"]];
    self.isPopular = [data[@"is_popular"] boolValue];
    self.dealStartTimeSinceUnixEpoch = [data[@"time_start"] doubleValue];
    self.dealTitle = data[@"title"];
    self.dealURL = [NSURL URLWithString:data[@"url"]];
    self.whatYouGet = data[@"what_you_get"];
    
    NSArray *dealOptions = data[@"options"];
    if ([dealOptions count] > 0) {
        NSMutableArray *parsedDealOptions = [NSMutableArray array];
        for (NSDictionary *option in dealOptions) {
            YelpDealOption *dealOption = [YelpDealOption objectWithDictionary:option];
            [parsedDealOptions addObject:dealOption];
        }
        self.dealOptions = [parsedDealOptions copy];
    }
}

@end
