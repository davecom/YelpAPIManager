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
#import "YelpGiftCertificateObject.h"
#import "YelpGiftCertificateOption.h"
#import "YelpDealObject.h"
#import "YelpDealOption.h"

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
        object.snippetText = businessItem[@"snippet_text"];
        
        object.isClosed = [businessItem[@"is_closed"] boolValue];
        object.isClaimed = [businessItem[@"is_claimed"] boolValue];
        
        object.rating = [businessItem[@"rating"] doubleValue];
        object.reviewCount = [businessItem[@"review_count"] unsignedIntegerValue];
        
        object.webURL = [NSURL URLWithString:businessItem[@"url"]];
        object.imageURL = [NSURL URLWithString:businessItem[@"image_url"]];
        object.mobileURL = [NSURL URLWithString:businessItem[@"mobile_url"]];
        object.snippetImageURL = [NSURL URLWithString:businessItem[@"snippet_image_url"]];
        
        //Location
        NSDictionary *locationDictionary = businessItem[@"location"];
        YelpLocationObject *locationInfo = [YelpLocationObject new];
        locationInfo.addressArray = locationDictionary[@"display_address"];
        locationInfo.city = locationDictionary[@"city"];
        locationInfo.countryCode = locationDictionary[@"country_code"];
        locationInfo.neighborhoods = locationDictionary[@"neighborhoods"];
        locationInfo.postalCode = locationDictionary[@"postal_code"];
        locationInfo.stateCode = locationDictionary[@"state_code"];
        object.locationInfo = locationInfo;
        
        //Deal
        NSDictionary *dealsArray = businessItem[@"deals"];
        
        if ([dealsArray count] > 0) {
            
            NSMutableArray *parsedDeals = [NSMutableArray array];
            
            for (NSDictionary *deal in dealsArray) {
                YelpDealObject *dealObject = [YelpDealObject new];
                dealObject.additionalRestriction = deal[@"additional_restrictions"];
                dealObject.importantRestriction = deal[@"important_restrictions"];
                dealObject.currencyCode = deal[@"currency_code"];
                dealObject.dealId = deal[@"id"];
                dealObject.dealImageURL = [NSURL URLWithString:deal[@"image_url"]];
                dealObject.isPopular = [deal[@"is_popular"] boolValue];
                dealObject.dealStartTimeSinceUnixEpoch = [deal[@"time_start"] doubleValue];
                dealObject.dealTitle = deal[@"title"];
                dealObject.dealURL = [NSURL URLWithString:deal[@"url"]];
                dealObject.whatYouGet = deal[@"what_you_get"];
                
                NSArray *dealOptions = deal[@"options"];
                if ([dealOptions count] > 0) {
                    NSMutableArray *parsedDealOptions = [NSMutableArray array];
                    for (NSDictionary *option in dealOptions) {
                        YelpDealOption *dealOption = [YelpDealOption new];
                        dealOption.formattedOriginalPrice = option[@"formatted_original_price"];
                        dealOption.formattedCurrentPrice = option[@"formatted_price"];
                        dealOption.isQuantityLimited = [option[@"is_quantity_limited"] integerValue];
                        dealOption.originalPriceInCent = [option[@"original_price"] integerValue];
                        dealOption.currentPriceInCent = [option[@"price"] integerValue];
                        dealOption.purchaseURL = [NSURL URLWithString:option[@"purchase_url"]];
                        dealOption.title = option[@"title"];
                        [parsedDealOptions addObject:dealOption];
                    }
                    dealObject.dealOptions = [parsedDealOptions copy];
                }
                [parsedDeals addObject:dealObject];
            }
            object.deals = [parsedDeals copy];
        }
        
        
        
        //Gift Certificate
        NSArray *giftCerts = businessItem[@"gift_certificates"];
        
        if ([giftCerts count] > 0) {
            NSMutableArray *parsedGiftCerts = [NSMutableArray new];
            for (NSDictionary *giftCert in giftCerts) {
                YelpGiftCertificateObject *giftCertObject = [YelpGiftCertificateObject new];
                giftCertObject.currencyCode = giftCert[@"currency_code"];
                giftCertObject.giftCertId = giftCert[@"id"];
                giftCertObject.giftCertImageURL = giftCert[@"image_url"];
                giftCertObject.unusedBalance = giftCert[@"unused_balances"];
                giftCertObject.giftCertURL = giftCert[@"url"];
                
                NSArray *giftCertOptions = giftCert[@"options"];
                if ([giftCertOptions count] > 0) {
                    NSMutableArray *parsedGiftCertOptions = [NSMutableArray array];
                    for (NSDictionary *giftOption in giftCertOptions) {
                        YelpGiftCertificateOption *giftCertOption = [YelpGiftCertificateOption new];
                        giftCertOption.formattedPrice = giftOption[@"formatted_price"];
                        giftCertOption.priceInCent = [giftOption[@"price"] integerValue];
                        [parsedGiftCertOptions addObject:giftCertOption];
                    }
                    giftCertObject.giftCertOptions = [parsedGiftCertOptions copy];
                }
                [parsedGiftCerts addObject:giftCertObject];
            }
            object.giftCertificates = [parsedGiftCerts copy];
        }
        
        NSLog(@"Business object: %@", object);
        [yelpItems addObject:object];
    }
    
    return [yelpItems copy];
}


@end
