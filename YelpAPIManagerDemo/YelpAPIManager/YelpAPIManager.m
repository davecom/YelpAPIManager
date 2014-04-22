//
//  YelpAPIManager.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/21/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpAPIManager.h"

@interface YelpAPIManager()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation YelpAPIManager

- (id)init {
    self = [super init];
    if (self) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return self;
}


#pragma mark - Singleton

+ (id)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [YelpAPIManager new];
    });
    return sharedInstance;
}


#pragma mark - Helper

- (NSDictionary *)APIConstantsDictionary {
    NSURL *file = [[NSBundle mainBundle] URLForResource:@"YelpAPIConstants" withExtension:@"plist"];
    return [NSDictionary dictionaryWithContentsOfURL:file];
}

- (NSDictionary *)oauthDictionary {
    NSDictionary *consumer = [self APIConstantsDictionary];
    NSDictionary *oauth = @{@"oauth_consumer_key": consumer[@"ConsumerKey"],
                            @"oauth_token": consumer[@"Token"],
                            @"oauth_signature_method": @"hmac-sha1",
                            @"oauth_timestamp": @([[NSDate date] timeIntervalSince1970])};
}

@end
