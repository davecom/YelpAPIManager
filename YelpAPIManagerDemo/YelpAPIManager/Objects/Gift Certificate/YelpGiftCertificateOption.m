//
//  YelpGiftCertificateOption.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpGiftCertificateOption.h"

@implementation YelpGiftCertificateOption

- (void)parseWithDataDictionary:(NSDictionary *)data {
    self.formattedPrice = data[@"formatted_price"];
    self.priceInCent = [data[@"price"] integerValue];
}

@end
