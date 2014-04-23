//
//  YelpBusinessObject.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/22/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpBusinessObject.h"
#import "YelpLocationObject.h"

@implementation YelpBusinessObject

- (id)init {
    self = [super init];
    if (self) {
        _locationInfo = [YelpLocationObject new];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\n++++++++++++++\nBusiness ID: %@\nBusiness Name: %@\nDisplay phone: %@\nPhone: %@\nCategories: %@\nLocation:%@\nIsClaimed: %d\nIsClosed: %d\nRating: %f\nReview Count: %d\nImageURL: %@\nWebURL: %@\nMobileURL: %@\n++++++++++++++\n", _businessId, _businessName, _displayPhoneNumber, _phoneNumber, _categories, _locationInfo, _isClaimed, _isClosed, _rating, _reviewCount, _imageURL, _webURL, _mobileURL];
}

@end
