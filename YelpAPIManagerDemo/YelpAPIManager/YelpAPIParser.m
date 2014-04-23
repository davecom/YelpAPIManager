//
//  YelpAPIParser.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/22/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpAPIParser.h"
#import "YelpBusinessObject.h"
#import "YelpLocationObject.h"

@implementation YelpAPIParser

+ (NSArray *)parseYelpSearchResponse:(id)response {
    
    NSMutableArray *yelpItems = [NSMutableArray array];
    
    NSArray *businessArray = response[@"businesses"];
    
    for (NSDictionary *businessItem in businessArray) {
        
        YelpBusinessObject *object = [YelpBusinessObject new];
        
        //Parse categories
        NSArray *categories = businessItem[@"categories"];
        NSMutableDictionary *categoryDictionary = [NSMutableDictionary dictionary];
        for (NSArray *categoryItem in categories) {
            categoryDictionary[categoryItem[1]] = categoryItem[0];
        }
        object.categories = [categoryDictionary copy];
        
        object.displayPhoneNumber = businessItem[@"display_phone"];
        object.phoneNumber = businessItem[@"phone"];
        object.businessId = businessItem[@"id"];
        object.businessName = businessItem[@"name"];
        
        object.isClosed = [businessItem[@"is_closed"] boolValue];
        object.isClaimed = [businessItem[@"is_claimed"] boolValue];
        
        object.rating = [businessItem[@"rating"] doubleValue];
        object.reviewCount = [businessItem[@"review_count"] unsignedIntegerValue];
        
        object.webURL = [NSURL URLWithString:businessItem[@"url"]];
        object.imageURL = [NSURL URLWithString:businessItem[@"image_url"]];
        object.mobileURL = [NSURL URLWithString:businessItem[@"mobile_url"]];
        
        //Location
        NSDictionary *locationDictionary = businessItem[@"location"];
        object.locationInfo.addressArray = locationDictionary[@"display_address"];
        object.locationInfo.city = locationDictionary[@"city"];
        object.locationInfo.countryCode = locationDictionary[@"country_code"];
        object.locationInfo.neighborhoods = locationDictionary[@"neighborhoods"];
        object.locationInfo.postalCode = locationDictionary[@"postal_code"];
        object.locationInfo.stateCode = locationDictionary[@"state_code"];
        
        NSLog(@"Business object: %@", object);
        [yelpItems addObject:object];
    }
    
    return [yelpItems copy];
}


@end
