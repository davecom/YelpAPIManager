//
//  YelpAPIManager.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/21/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpAPIManager.h"
#import <CommonCrypto/CommonCrypto.h>
#import "NSData+Base64Encoder.h"
#import "NSString+Encoding.h"
#import "YelpAPIUtilities.h"

static NSString *kYelpAPIBaseURL = @"http://api.yelp.com/v2";
static NSString *kSignatureMethod = @"HMAC-SHA1";

@interface YelpAPIManager()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSString *consumerKey;
@property (nonatomic, strong) NSString *consumerSecret;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *tokenSecret;
@end

@implementation YelpAPIManager

- (id)init {
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kYelpAPIBaseURL]];
        
        NSURL *file = [[NSBundle mainBundle] URLForResource:@"YelpAPIConstants" withExtension:@"plist"];
        NSDictionary *APIConstants = [NSDictionary dictionaryWithContentsOfURL:file];
        
        self.consumerKey = APIConstants[@"ConsumerKey"];
        self.consumerSecret = APIConstants[@"ConsumerSecret"];
        self.token = APIConstants[@"Token"];
        self.tokenSecret = APIConstants[@"TokenSecret"];
    }
    return self;
}


#pragma mark - Search
/*
- (void)searchTerm:(NSString *)term
             limit:(NSUInteger)limit
            offset:(NSUInteger)offset
              sort:(NSUInteger)sort
    categoryFilter:(NSString *)categoryFilter
            radius:(NSUInteger)radius
              deal:(BOOL)deal {
 
 */

- (void)search {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self oauthDictionary]];
    [params setObject:@"restaurant" forKey:@"term"];
    [params setObject:@"New York" forKey:@"location"];

    NSString *signature = [self generateSignatureWithMethod:@"GET" endPoint:@"search" params:params];
    [params setObject:signature forKey:@"oauth_signature"];
    
    [_sessionManager GET:@"search" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error: %@", error);
    }];
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

- (NSDictionary *)oauthDictionary {
    
    NSDictionary *oauth = @{@"oauth_consumer_key": self.consumerKey,
                            @"oauth_token": self.token,
                            @"oauth_signature_method": kSignatureMethod,
                            //@"oauth_signature": signature,
                            @"oauth_timestamp": [YelpAPIUtilities stringForSecondsSinceUnixEpoch],
                            @"oauth_nonce": [YelpAPIUtilities uniqueNonceString]
                            };
    return oauth;
}


- (NSString *)generateSignatureWithMethod:(NSString *)method endPoint:(NSString *)endPoint params:(NSDictionary *)params {
    
    NSError *error = nil;
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer new];
    
    NSString *baseURLString = [NSString stringWithFormat:@"%@/%@", kYelpAPIBaseURL, endPoint];
    NSURLRequest *request = [requestSerializer requestWithMethod:method URLString:baseURLString parameters:params error:&error];
    
    NSString *tokenString = request.URL.absoluteString;
    NSString *encodedToken = [request.URL.absoluteString encodedURLParameterString];
    
    //Replace the first encountered encoded "&"
    NSRange rOriginal = [encodedToken rangeOfString:@"%3F"];
    if (NSNotFound != rOriginal.location) {
        encodedToken = [encodedToken stringByReplacingCharactersInRange:rOriginal withString:@"&"];
    }
    
    NSString *tokenStringEncoded = [NSString stringWithFormat:@"GET&%@", encodedToken];
    
    NSLog(@"Token string: %@\n\n", tokenString);
    NSLog(@"TOken string: %@\n\n", tokenStringEncoded);
    
    NSString *APISecret = [self APISecret];
    NSString *signature = [YelpAPIUtilities hmacsha1:tokenStringEncoded secret:APISecret];
    
    return signature;
}


- (NSString *)APISecret {
    NSString *encodedTokenSecret = [self.tokenSecret encodedURLParameterString];
    NSString *encodedConsumerSecret = [self.consumerSecret encodedURLParameterString];
    return [NSString stringWithFormat:@"%@&%@", encodedConsumerSecret, encodedTokenSecret];
}

@end
