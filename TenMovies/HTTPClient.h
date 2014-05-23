//
//  RACHTTPClient.h
//  TenMovies
//
//  Created by Scott Kensell on 5/15/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "CoreHTTPClient.h"

@class RACSignal;

@interface HTTPClient : CoreHTTPClient

+ (RACSignal *)GET:(NSString *)url;

@end
