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

static NSString *kYelpAPIBaseURL = @"http://api.yelp.com";

@interface YelpAPIManager()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;
@property (nonatomic, strong) AFHTTPRequestOperation *requestOperation;
@end

@implementation YelpAPIManager

- (id)init {
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kYelpAPIBaseURL]];
        _operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kYelpAPIBaseURL]];
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

    NSError *error = nil;
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer new];
    NSURLRequest *request = [requestSerializer requestWithMethod:@"GET" URLString:@"http://api.yelp.com/v2/search" parameters:params error:&error];
    
    NSString *tokenString = request.URL.absoluteString;
    NSString *encodedToken = [self encodedURLParameterString:request.URL.absoluteString];
    
    //Replace the first encountered encoded "&"
    NSRange rOriginal = [encodedToken rangeOfString:@"%3F"];
    if (NSNotFound != rOriginal.location) {
        encodedToken = [encodedToken stringByReplacingCharactersInRange:rOriginal withString:@"&"];
    }
    
    NSString *tokenStringEncoded = [NSString stringWithFormat:@"GET&%@", encodedToken];
    
    NSDictionary *consumer = [self APIConstantsDictionary];
    NSString *encodedTokenSecret = [self encodedURLParameterString:consumer[@"TokenSecret"]];
    NSString *encodedConsumerSecret = [self encodedURLParameterString:consumer[@"ConsumerSecret"]];
    
    
    NSLog(@"Token string: %@\n\n", tokenString);
    NSLog(@"TOken string: %@\n\n", tokenStringEncoded);
    
    NSString *signature = [self hmacsha1:tokenStringEncoded secret:[NSString stringWithFormat:@"%@&%@", encodedConsumerSecret, encodedTokenSecret]];
    [params setObject:signature forKey:@"oauth_signature"];
    
    [_sessionManager GET:@"/v2/search" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
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

- (NSDictionary *)APIConstantsDictionary {
    NSURL *file = [[NSBundle mainBundle] URLForResource:@"YelpAPIConstants" withExtension:@"plist"];
    return [NSDictionary dictionaryWithContentsOfURL:file];
}

- (NSDictionary *)oauthDictionary {
    NSDictionary *consumer = [self APIConstantsDictionary];
    NSString *consumerKey = consumer[@"ConsumerKey"];
    NSString *token = consumer[@"Token"];
    //NSString *signature = [self hmacsha1:token secret:secret];
    NSString *nonce = [self generateNonce];
    
    NSLog(@"key: %@, token: %@, once: %@", consumerKey, token, nonce);
    
    
    NSDictionary *oauth = @{@"oauth_consumer_key": consumer[@"ConsumerKey"],
                            @"oauth_token": consumer[@"Token"],
                            @"oauth_signature_method": @"HMAC-SHA1",
                            //@"oauth_signature": signature,
                            @"oauth_timestamp": [[NSString alloc]initWithFormat:@"%ld", time(NULL)],
                            @"oauth_nonce": [self generateNonce]
                            };
    return oauth;
}


- (NSString *)hmacsha1:(NSString *)data secret:(NSString *)key {
    
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    NSString *hash = [HMAC base64EncodedString];
    
    return hash;
}

- (NSString *)generateNonce {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    return (__bridge NSString *)(string);
}

- (NSString *)encodedURLParameterString:(NSString *)string {
    NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)string,
                                                                           NULL,
                                                                           CFSTR(":/=,!$&'()*+;[]@#?"),
                                                                           kCFStringEncodingUTF8);
    return result;
}


@end
