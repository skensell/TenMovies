//
//  HTTPClient+RAC.h
//  TenMovies
//
//  Created by Scott Kensell on 5/12/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "HTTPClient.h"

@class RACSignal;

@interface HTTPClient (RAC)

+ (RACSignal *)GET:(NSString *)url;

@end
