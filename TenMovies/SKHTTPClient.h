//
//  RACHTTPClient.h
//  TenMovies
//
//  Created by Scott Kensell on 5/15/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "HTTPClient.h"

@class RACSignal;

@interface SKHTTPClient : HTTPClient

+ (RACSignal *)GET:(NSString *)url;

@end
