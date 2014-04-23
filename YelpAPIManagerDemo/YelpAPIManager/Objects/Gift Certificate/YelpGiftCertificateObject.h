//
//  YelpGiftCertificateObject.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YelpObject.h"

@interface YelpGiftCertificateObject : YelpObject

@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSString *giftCertId;
@property (nonatomic, strong) NSString *unusedBalance;

@property (nonatomic, strong) NSArray *giftCertOptions; //Array of YelpGiftCertificateOption

@property (nonatomic, strong) NSURL *giftCertURL;
@property (nonatomic, strong) NSURL *giftCertImageURL;

@end
