//
//  YelpBusinessObject.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/22/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpObject.h"

@class YelpLocationObject;

@interface YelpBusinessObject : YelpObject

@property (nonatomic, strong) NSString *businessId;
@property (nonatomic, strong) NSString *businessName;
@property (nonatomic, strong) NSString *displayPhoneNumber;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *snippetText;
@property (nonatomic, strong) NSDictionary *categories;
@property (nonatomic, strong) NSArray *deals;
@property (nonatomic, strong) NSArray *giftCertificates;
@property (nonatomic, strong) NSArray *reviews;
@property (nonatomic, strong) YelpLocationObject *locationInfo;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSURL *webURL;
@property (nonatomic, strong) NSURL *mobileURL;
@property (nonatomic, strong) NSURL *snippetImageURL;
@property (nonatomic, assign) BOOL isClosed;
@property (nonatomic, assign) BOOL isClaimed;
@property (nonatomic, assign) double rating;
@property (nonatomic, assign) NSUInteger reviewCount;

@end
