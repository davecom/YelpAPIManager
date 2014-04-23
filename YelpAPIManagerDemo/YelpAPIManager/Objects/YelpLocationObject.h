//
//  YelpLocationObject.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpObject.h"

@interface YelpLocationObject : YelpObject

@property (nonatomic, strong) NSArray *addressArray;
@property (nonatomic, strong) NSSet *neighborhoods;

@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *stateCode;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *countryCode;

@end
