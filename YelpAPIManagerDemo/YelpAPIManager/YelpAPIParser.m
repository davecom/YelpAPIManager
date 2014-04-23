//
//  YelpAPIParser.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/22/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpAPIParser.h"
#import "YelpBusinessObject.h"

@implementation YelpAPIParser

+ (NSArray *)parseYelpSearchResponse:(id)response {
    
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
        
        object.phoneNumber = businessItem[@"display_phone"];
        object.businessId = businessItem[@"id"];
        
        
    }
    
    
    NSMutableArray *yelpItems = [NSMutableArray array];
    
    return [yelpItems copy];
}


@end
