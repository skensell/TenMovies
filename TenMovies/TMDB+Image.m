//
//  TMDB+Image.m
//  TenMovies
//
//  Created by Scott Kensell on 5/12/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDB+Image.h"

#import <ReactiveCocoa.h>

#import "HTTPClient+RAC.h"
#import "Logging.h"

static NSString *baseImageURL = nil;
static NSArray *posterSizes = nil;

@implementation TMDB (Image)

+ (RACSignal *OF_TYPE(NSData))thumbnailImageForPosterPath:(NSString *)posterPath {
    RACSignal *configSignal;
    if (!baseImageURL || !posterSizes) {
        configSignal = [HTTPClient GET:[TMDB URLForConfiguration]];
        [configSignal subscribeNext:^(NSDictionary *response) {
            baseImageURL = [response valueForKeyPath:TMDB_IMAGE_BASE_URL_KEY_PATH];
            posterSizes = [response valueForKeyPath:TMDB_IMAGE_POSTER_SIZES_KEY_PATH];
            DEBUG(@"succesful request");
            
        }];
    } else {
        
    }
    return nil;
}

@end
