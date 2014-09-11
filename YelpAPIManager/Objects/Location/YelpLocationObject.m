//
//  YelpLocationObject.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpLocationObject.h"

@implementation YelpLocationObject

- (void)parseWithDataDictionary:(NSDictionary *)data {
    self.addressArray = data[@"display_address"];
    self.city = data[@"city"];
    self.countryCode = data[@"country_code"];
    self.neighborhoods = data[@"neighborhoods"];
    self.postalCode = data[@"postal_code"];
    self.stateCode = data[@"state_code"];
}

@end
