// HTTPClient.h
//
// Copied from the AFNetworking Example
// 


#import <Foundation/Foundation.h>
#import <AFHTTPRequestOperationManager.h>

@interface CoreHTTPClient : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;
- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (BOOL)hasRequestInQueueWithURL:(NSString *)url;

@end
