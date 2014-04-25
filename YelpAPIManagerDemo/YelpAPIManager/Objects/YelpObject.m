//
//  YelpObject.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/23/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpObject.h"
#import <objc/objc-runtime.h>

@implementation YelpObject

+ (instancetype)objectWithDictionary:(NSDictionary *)dictionary {
    id object = [self.class new];
    [object parseWithDataDictionary:dictionary];
    return object;
}


- (void)parseWithDataDictionary:(NSDictionary *)data {
    NSAssert(NO, @"This is an abstract method and should be overridden");
}


//TODO: Need to fix this when description is in array.
- (NSString *)description {
    unsigned int count;
    Ivar* ivars = class_copyIvarList([self class], &count);
    
    NSMutableArray *descriptionArray = [NSMutableArray array];
    
    for(unsigned int i = 0; i < count; ++i)
    {
        NSString *key = [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding];
        NSString *value = [self valueForKey:key];
        NSString *keyValue = [NSString stringWithFormat:@"%@: %@", key, value];
        [descriptionArray addObject:keyValue];
    }
    free(ivars);
    
    return [descriptionArray componentsJoinedByString:@"\n"];
}

@end
