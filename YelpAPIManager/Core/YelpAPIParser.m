//
//  YelpAPIParser.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/22/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpAPIParser.h"

#import "YelpLocationObject.h"
#import "YelpGiftCertificateObject.h"
#import "YelpGiftCertificateOption.h"
#import "YelpDealObject.h"
#import "YelpDealOption.h"
#import "YelpReviewObject.h"
#import "YelpReviewUserObject.h"

@implementation YelpAPIParser

+ (NSArray *)parseYelpSearchResponse:(id)response {
    NSMutableArray *yelpItems = [NSMutableArray array];
    
    NSArray *businessArray = response[@"businesses"];
    
    for (NSDictionary *businessItem in businessArray) {
        YelpBusinessObject *object = [YelpBusinessObject objectWithDictionary:businessItem];
        [yelpItems addObject:object];
        //NSLog(@"Object: %@", object);
    }
    return [yelpItems copy];
}


+ (YelpBusinessObject *)parseYelpBusinessResponse:(id)response {
    YelpBusinessObject *object = [YelpBusinessObject objectWithDictionary:response];
    //NSLog(@"Object: %@", object);
    return object;
}

@end
