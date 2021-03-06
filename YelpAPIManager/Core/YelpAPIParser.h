//
//  YelpAPIParser.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/22/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpBusinessObject.h"

@interface YelpAPIParser : NSObject

+ (NSArray *)parseYelpSearchResponse:(id)response;

+ (YelpBusinessObject *)parseYelpBusinessResponse:(id)response;

@end
