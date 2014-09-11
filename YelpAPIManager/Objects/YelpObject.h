//
//  YelpObject.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpObject : NSObject

+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary;

//Abstract method. Must be overridden
- (void)parseWithDataDictionary:(NSDictionary *)data;

@end
