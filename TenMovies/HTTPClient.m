// HTTPClient.m
//
//

#import "HTTPClient.h"

#import <AFHTTPRequestOperation.h>

@implementation HTTPClient

+ (instancetype)sharedClient {
    static HTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HTTPClient alloc] initWithBaseURL:nil];
    });
    
    return _sharedClient;
}

+ (BOOL)hasRequestInQueueWithURL:(NSString *)url {
    NSArray *operations = [[HTTPClient sharedClient].operationQueue operations];
    __block BOOL hasRequest = NO;
    [operations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSOperation *op = (NSOperation *)obj;
        if ([op isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *aOp = (AFHTTPRequestOperation *)op;
            if ([[aOp.request.URL absoluteString] rangeOfString:url].location != NSNotFound) {
                hasRequest = YES;
                *stop = YES;
            }
        }
    }];
    return hasRequest;
}

@end
