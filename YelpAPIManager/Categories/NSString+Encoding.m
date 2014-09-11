//
//  NSString+Encoding.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/22/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "NSString+Encoding.h"

@implementation NSString (Encoding)

- (NSString *)encodedURLParameterString {
    NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                    (CFStringRef)self,
                                                                                    NULL,
                                                                                    CFSTR(":/=,!$&'()*+;[]@#?"),
                                                                                    kCFStringEncodingUTF8);
    return result;
}

@end
