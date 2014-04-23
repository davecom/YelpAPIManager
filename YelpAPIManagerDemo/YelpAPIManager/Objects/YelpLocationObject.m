//
//  YelpLocationObject.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpLocationObject.h"

@implementation YelpLocationObject

- (NSString *)description {
    return [NSString stringWithFormat:@"\n============\nAddressArray: %@\nNeighborhood: %@\nPostal Code: %@\nState Code: %@\nCity: %@\nCountry Code: %@\n============\n", _addressArray, _neighborhoods, _postalCode, _stateCode, _city, _countryCode];
}

@end
