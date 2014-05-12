// HTTPClient.h
//
// Copied from the AFNetworking Example
// 


#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface HTTPClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

+ (BOOL)hasRequestInQueueWithURL:(NSString *)url;

@end
