//
//  YelpDealOption.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpDealOption.h"

@implementation YelpDealOption

- (void)parseWithDataDictionary:(NSDictionary *)data {
    self.formattedOriginalPrice = data[@"formatted_original_price"];
    self.formattedCurrentPrice = data[@"formatted_price"];
    self.isQuantityLimited = [data[@"is_quantity_limited"] integerValue];
    self.originalPriceInCent = [data[@"original_price"] integerValue];
    self.currentPriceInCent = [data[@"price"] integerValue];
    self.purchaseURL = [NSURL URLWithString:data[@"purchase_url"]];
    self.title = data[@"title"];
}

@end
