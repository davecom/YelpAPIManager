//
//  YelpBusinessObject.h
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/22/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface YelpBusinessObject : NSObject

@property (nonatomic, strong) NSString *businessId;
@property (nonatomic, strong) NSString *businessName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *neighborhood;
@property (nonatomic, strong) NSDictionary *categories;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) BOOL isClosed;
@property (nonatomic, assign) CGFloat rating;
@property (nonatomic, assign) NSUInteger reviewCount;

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSURL *mobileURL;

@end
