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
    
    self.distance = [data[@"distance"] doubleValue];
    self.rating = [data[@"rating"] doubleValue];
    self.reviewCount = [data[@"review_count"] unsignedIntegerValue];
    self.ratingImageURL = [NSURL URLWithString:data[@"rating_img_url"]];
    self.ratingImageURLLarge = [NSURL URLWithString:data[@"rating_img_url_large"]];
    self.ratingImageURLSmall = [NSURL URLWithString:data[@"rating_img_url_small"]];
    
    self.webURL = [NSURL URLWithString:data[@"url"]];
    self.imageURL = [NSURL URLWithString:data[@"image_url"]];
    self.mobileURL = [NSURL URLWithString:data[@"mobile_url"]];
    self.snippetImageURL = [NSURL URLWithString:data[@"snippet_image_url"]];
    self.reservationURL = [NSURL URLWithString:data[@"reservation_url"]];
    self.orderOnlineURL = [NSURL URLWithString:data[@"eat24_url"]];
    
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
    //NSLog(@"%lu reviews", (unsigned long)[reviews count]);
    if ([reviews count] > 0) {
        NSMutableArray *parsedReviews = [NSMutableArray new];
        for (NSDictionary *reviewItem in reviews) {
            YelpReviewObject *reviewObject = [YelpReviewObject objectWithDictionary:reviewItem];
            [parsedReviews addObject:reviewObject];
        }
        self.reviews = [parsedReviews copy];
    }
}

-(NSString *)distanceOrStreet
{
    if (self.distance > 0.0) {
        if ([[[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem] boolValue]){
            return [NSString stringWithFormat:@"%.1f km", self.distance / 1000];
        } else {
            return [NSString stringWithFormat:@"%.1f mi", self.distance * 0.000621371192];
        }
    }
    return self.locationInfo.addressArray[0];
}

@end
