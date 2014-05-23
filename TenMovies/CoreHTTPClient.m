// HTTPClient.m
//
//

#import "CoreHTTPClient.h"

#import <AFHTTPRequestOperation.h>
#import <RACEXTScope.h>

#import "Logging.h"
#import "NSString+Contains.h"

@interface CoreHTTPClient ()
@property (strong, nonatomic) NSMutableSet *urlCache;
@end

@implementation CoreHTTPClient

+ (instancetype)sharedClient {
    static CoreHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [CoreHTTPClient manager];
        _sharedClient.responseSerializer =
        [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:@[
            [AFJSONResponseSerializer serializerWithReadingOptions:0],
            [AFImageResponseSerializer serializer]
        ]];
        _sharedClient.urlCache = [[NSMutableSet alloc] init];
    });
    
    return _sharedClient;
}

+ (BOOL)hasRequestInQueueWithURL:(NSString *)url {
    return [[CoreHTTPClient sharedClient].urlCache containsObject:url];
}


#pragma mark - Instance methods

- (AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    if ([self.urlCache containsObject:URLString]) {
        DEBUG(@"caught a duplicate request: %@", URLString);
        return nil;
    }
    [self.urlCache addObject:URLString];
    
    NSURLRequest *r = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    @weakify(self)
    AFHTTPRequestOperation *op = [super HTTPRequestOperationWithRequest:r
                                                                success:^(AFHTTPRequestOperation *op, id responseObject) {
                                                                    @strongify(self)
                                                                    DEBUG(@"GET succeeded %@", URLString);
                                                                    [self.urlCache removeObject:URLString];
                                                                    success(op, responseObject);
                                                                } failure:^(AFHTTPRequestOperation *op, NSError *error) {
                                                                    @strongify(self)
                                                                    ERROR(@"GET failed %@", URLString);
                                                                    [self.urlCache removeObject:URLString];
                                                                    failure(op, error);
                                                                }];
    [self.operationQueue addOperation:op];
    return op;
}

@end
