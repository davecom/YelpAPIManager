//
//  YelpGiftCertificateObject.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpGiftCertificateObject.h"
#import "YelpGiftCertificateOption.h"

@implementation YelpGiftCertificateObject

- (void)parseWithDataDictionary:(NSDictionary *)data {
    self.currencyCode = data[@"currency_code"];
    self.giftCertId = data[@"id"];
    self.giftCertImageURL = data[@"image_url"];
    self.unusedBalance = data[@"unused_balances"];
    self.giftCertURL = data[@"url"];
    
    NSArray *giftCertOptions = data[@"options"];
    if ([giftCertOptions count] > 0) {
        NSMutableArray *parsedGiftCertOptions = [NSMutableArray array];
        for (NSDictionary *giftOption in giftCertOptions) {
            YelpGiftCertificateOption *giftCertOption = [YelpGiftCertificateOption objectWithDictionary:giftOption];
            [parsedGiftCertOptions addObject:giftCertOption];
        }
        self.giftCertOptions = [parsedGiftCertOptions copy];
    }
}

@end
