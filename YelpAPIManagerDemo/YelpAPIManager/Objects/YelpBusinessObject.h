//
//  YelpBusinessObject.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/22/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YelpLocationObject;

@interface YelpBusinessObject : NSObject

@property (nonatomic, strong) NSString *businessId;
@property (nonatomic, strong) NSString *businessName;
@property (nonatomic, strong) NSString *displayPhoneNumber;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSDictionary *categories;
@property (nonatomic, strong) YelpLocationObject *locationInfo;

@property (nonatomic, assign) BOOL isClosed;
@property (nonatomic, assign) BOOL isClaimed;
@property (nonatomic, assign) double rating;
@property (nonatomic, assign) NSUInteger reviewCount;

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSURL *webURL;
@property (nonatomic, strong) NSURL *mobileURL;

@end
