//
//  YelpDealOption.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpObject.h"

@interface YelpDealOption : YelpObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *formattedOriginalPrice;
@property (nonatomic, strong) NSString *formattedCurrentPrice;

@property (nonatomic, assign) BOOL isQuantityLimited;
@property (nonatomic, assign) NSUInteger originalPriceInCent;
@property (nonatomic, assign) NSUInteger currentPriceInCent;
@property (nonatomic, assign) NSUInteger remainCount;

@property (nonatomic, strong) NSURL *purchaseURL;

@end
