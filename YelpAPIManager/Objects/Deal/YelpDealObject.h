//
//  YelpDealObject.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpObject.h"

@interface YelpDealObject : YelpObject

@property (nonatomic, strong) NSString *dealId;
@property (nonatomic, strong) NSString *dealTitle;
@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSString *additionalRestriction;
@property (nonatomic, strong) NSString *importantRestriction;
@property (nonatomic, strong) NSString *whatYouGet;
@property (nonatomic, assign) NSTimeInterval dealStartTimeSinceUnixEpoch;
@property (nonatomic, assign) BOOL isPopular;
@property (nonatomic, strong) NSArray *dealOptions; //Array of YelpDealOption object.
@property (nonatomic, strong) NSURL *dealImageURL;
@property (nonatomic, strong) NSURL *dealURL;

@end
