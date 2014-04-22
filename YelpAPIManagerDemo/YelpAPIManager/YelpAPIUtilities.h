//
//  YelpAPIUtilities.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/22/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpAPIUtilities : NSObject

+ (NSString *)uniqueNonceString;
+ (NSString *)hmacsha1:(NSString *)source secret:(NSString *)key;

@end
