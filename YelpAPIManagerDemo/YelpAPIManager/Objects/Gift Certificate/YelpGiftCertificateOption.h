//
//  YelpGiftCertificateOption.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpObject.h"

@interface YelpGiftCertificateOption : YelpObject

@property (nonatomic, strong) NSString *formattedPrice;
@property (nonatomic, assign) NSUInteger priceInCent;

@end
