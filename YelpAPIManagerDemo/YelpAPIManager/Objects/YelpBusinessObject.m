//
//  YelpBusinessObject.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/22/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpBusinessObject.h"
#import "YelpLocationObject.h"
#import "YelpDealObject.h"
#import "YelpGiftCertificateObject.h"
#import "YelpGiftCertificateOption.h"
#import "YelpReviewObject.h"
#import "YelpReviewUserObject.h"
#import "YelpDealOption.h"

@implementation YelpBusinessObject

- (void)parseWithDataDictionary:(NSDictionary *)data {
    //Parse categories
    NSArray *categories = data[@"categories"];
    NSMutableDictionary *categoryDictionary = [NSMutableDictionary dictionary];
    for (NSArray *categoryItem in categories) {
        categoryDictionary[categoryItem[1]] = categoryItem[0];
    }
    self.categories = [categoryDictionary copy];
    
    self.displayPhoneNumber = data[@"display_phone"];
    self.phoneNumber = data[@"phone"];
    self.businessId = data[@"id"];
    self.businessName = data[@"name"];
    self.snippetText = data[@"snippet_text"];
    
    self.isClosed = [data[@"is_closed"] boolValue];
    self.isClaimed = [data[@"is_claimed"] boolValue];
    
    self.rating = [data[@"rating"] doubleValue];
    self.reviewCount = [data[@"review_count"] unsignedIntegerValue];
    
    self.webURL = [NSURL URLWithString:data[@"url"]];
    self.imageURL = [NSURL URLWithString:data[@"image_url"]];
    self.mobileURL = [NSURL URLWithString:data[@"mobile_url"]];
    self.snippetImageURL = [NSURL URLWithString:data[@"snippet_image_url"]];
    
    //Location
    self.locationInfo = [YelpLocationObject objectWithDictionary:data[@"location"]];
    
    //Deal
    NSDictionary *dealsArray = data[@"deals"];
    
    if ([dealsArray count] > 0) {
        
        NSMutableArray *parsedDeals = [NSMutableArray array];
        
        for (NSDictionary *deal in dealsArray) {
            YelpDealObject *dealObject = [YelpDealObject objectWithDictionary:deal];
            [parsedDeals addObject:dealObject];
        }
        self.deals = [parsedDeals copy];
    }
    
    
    
    //Gift Certificate
    NSArray *giftCerts = data[@"gift_certificates"];
    
    if ([giftCerts count] > 0) {
        NSMutableArray *parsedGiftCerts = [NSMutableArray new];
        for (NSDictionary *giftCert in giftCerts) {
            YelpGiftCertificateObject *giftCertObject = [YelpGiftCertificateObject objectWithDictionary:giftCert];
            [parsedGiftCerts addObject:giftCertObject];
        }
        self.giftCertificates = [parsedGiftCerts copy];
    }
    
    
    //Reviews
    NSArray *reviews = data[@"reviews"];
    
    if ([reviews count] > 0) {
        NSMutableArray *parsedReviews = [NSMutableArray new];
        for (NSDictionary *reviewItem in reviews) {
            YelpReviewObject *reviewObject = [YelpReviewObject objectWithDictionary:reviewItem];
            [parsedReviews addObject:reviewObject];
        }
        self.reviews = [parsedReviews copy];
    }
}

@end
