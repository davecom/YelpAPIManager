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
#import "YelpAPIParser.h"
#import "AFHTTPRequestOperationManager.h"

static NSString *kYelpAPIBaseURL = @"http://api.yelp.com/v2";
static NSString *kSignatureMethod = @"HMAC-SHA1";

@interface YelpAPIManager()
@property (nonatomic, strong) AFHTTPRequestOperationManager *sessionManager;
@property (nonatomic, strong) NSString *consumerKey;
@property (nonatomic, strong) NSString *consumerSecret;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *tokenSecret;
@end

@implementation YelpAPIManager

- (id)init {
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kYelpAPIBaseURL]];
        
        NSURL *file = [[NSBundle mainBundle] URLForResource:@"YelpAPIConstants" withExtension:@"plist"];
        NSDictionary *APIConstants = [NSDictionary dictionaryWithContentsOfURL:file];
        
        self.consumerKey = APIConstants[@"ConsumerKey"];
        self.consumerSecret = APIConstants[@"ConsumerSecret"];
        self.token = APIConstants[@"Token"];
        self.tokenSecret = APIConstants[@"TokenSecret"];
    }
    return self;
}


#pragma mark - Search API

- (void)searchTerm:(NSString *)term
      neighborhood:(NSString *)neighborhood
        coordinate:(CLLocationCoordinate2D)coordinate
          location:(CLLocation *)location
             limit:(NSUInteger)limit
            offset:(NSUInteger)offset
              sort:(YelpSearchSortBy)sort
    categoryFilter:(NSString *)categoryFilter
            radius:(NSUInteger)radius
              deal:(BOOL)deal
            result:(void (^)(NSArray *results, NSError *error))resultBlock{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self oauthDictionary]];
    
    if (term.length > 0)    {
        params[@"term"] = term;
    }
    
    //Should be either location or coordinate displaying this year.
    if (location != nil) {
        params[@"ll"] = [NSString stringWithFormat:@"%f,%f,%f,%f,%f",
                         location.coordinate.latitude,
                         location.coordinate.longitude,
                         location.horizontalAccuracy,
                         location.altitude,
                         location.verticalAccuracy];
    
    } else {
        if (neighborhood.length > 0) {
            params[@"location"] = neighborhood;
        }
        
        if (CLLocationCoordinate2DIsValid(coordinate)) {
            params[@"cll"] = [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
        }
    }
    
    
    if (limit > 0) {
        params[@"limit"]  = @(limit);
    }
    
    if (offset > 0) {
        params[@"offset"] = @(offset);
    }
    
    if (sort <= 2) {
        params[@"sort"] = @(sort);
    }
    
    if (categoryFilter.length > 0) {
        params[@"category_filter"] = categoryFilter;
    }
    
    if (radius > 0) {
        params[@"radius_filter"] = @(radius);
    }
    
    if (deal) {
        params[@"deals_filter"] = @(deal);
    }

    NSString *signature = [self generateSignatureWithMethod:@"GET" endPoint:@"search" params:params];
    [params setObject:signature forKey:@"oauth_signature"];
    
    [_sessionManager GET:@"search" parameters:params success:^(AFHTTPRequestOperation *task, id responseObject) {
        
        if (self.isLogEnabled) {
            NSLog(@"Response: %@", responseObject);
        }
        
        NSArray *response = [YelpAPIParser parseYelpSearchResponse:responseObject];
        resultBlock(response, nil);
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        
        NSLog(@"error: %@", error);
        NSLog(@"%@", task.responseString);
        resultBlock(nil, error);
    }];
}



#pragma mark - Business API

- (void)findBusinessId:(NSString *)businessId countryCode:(NSString *)countryCode languageCode:(NSString *)languageCode reviewLanguageFilter:(BOOL)shouldFilter {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self oauthDictionary]];
    
    if (countryCode.length > 0) {
        params[@"cc"] = countryCode;
    }
    
    if (languageCode.length > 0) {
        params[@"lang"] = languageCode;
    }
    
    if (shouldFilter) {
        params[@"lang_filter"] = @(shouldFilter);
    }
    
    NSString *endpoint = [NSString stringWithFormat:@"business/%@", businessId];
    NSString *signature = [self generateSignatureWithMethod:@"GET" endPoint:endpoint params:params];
    [params setObject:signature forKey:@"oauth_signature"];
    
    [_sessionManager GET:endpoint parameters:params success:^(AFHTTPRequestOperation *task, id responseObject) {
        
        if (self.isLogEnabled) {
            NSLog(@"Response: %@", responseObject);
        }
        
        [YelpAPIParser parseYelpBusinessResponse:responseObject];
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        NSLog(@"error: %@", error);
        NSLog(@"%@", task.responseString);
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
    
    NSString *encodedToken = [request.URL.absoluteString encodedURLParameterString];
    
    //Replace the first encountered encoded "&"
    NSRange rOriginal = [encodedToken rangeOfString:@"%3F"];
    if (NSNotFound != rOriginal.location) {
        encodedToken = [encodedToken stringByReplacingCharactersInRange:rOriginal withString:@"&"];
    }
    
    NSString *tokenStringEncoded = [NSString stringWithFormat:@"GET&%@", encodedToken];
    
    //NSLog(@"TOken string: %@\n\n", tokenStringEncoded);
    
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
