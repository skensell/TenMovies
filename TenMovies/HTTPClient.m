//
//  RACHTTPClient.m
//  TenMovies
//
//  Created by Scott Kensell on 5/15/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "HTTPClient.h"

#import "Logging.h"

#import <ReactiveCocoa.h>

@implementation HTTPClient

+ (RACSignal *)GET:(NSString *)url {
    RACSubject *subject = [RACSubject subject];
    [[CoreHTTPClient sharedClient] GET:url parameters:nil
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               [subject sendNext:responseObject];
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               [subject sendError:error];
                           }];
    return subject;
}

@end
