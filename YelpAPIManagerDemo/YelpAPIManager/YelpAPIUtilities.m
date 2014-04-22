//
//  YelpAPIUtilities.m
//  YelpAPIManagerDemo
//
//  Created by Zian Chen on 4/22/14.
//  Copyright (c) 2014 Zian Mobile Development. All rights reserved.
//

#import "YelpAPIUtilities.h"
#import "NSData+Base64Encoder.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation YelpAPIUtilities

+ (NSString *)uniqueNonceString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    return (__bridge NSString *)(string);
}


+ (NSString *)hmacsha1:(NSString *)source secret:(NSString *)key {
    
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [source cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    NSString *hash = [HMAC base64EncodedString];
    
    return hash;
}

@end
