//
//  HTTPClient+RAC.m
//  TenMovies
//
//  Created by Scott Kensell on 5/12/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "HTTPClient+RAC.h"

#import <ReactiveCocoa.h>

#import "Logging.h"

@implementation HTTPClient (RAC)

+ (RACSignal *)GET:(NSString *)url {
    RACSubject *subject = [RACSubject subject];
    [[HTTPClient sharedClient] GET:url parameters:nil
                           success:^(id task, id responseObject) {
                               [subject sendNext:responseObject];
                           } failure:^(id task, NSError *error) {
                               ERROR(@"%@ %@", url, [error localizedDescription]);
                               [subject sendError:error];
                           }];
    
    return subject;
}

@end
