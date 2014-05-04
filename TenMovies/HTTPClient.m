// HTTPClient.m
//
//

#import "HTTPClient.h"

@implementation HTTPClient

+ (instancetype)sharedClient {
    static HTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HTTPClient alloc] initWithBaseURL:nil];
    });
    
    return _sharedClient;
}

@end
