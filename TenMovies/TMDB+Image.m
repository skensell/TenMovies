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
    //[self configurationSignal];
    return nil;
}

#pragma mark - Private

+ (RACSignal *)configurationSignal {
    RACSubject *subject = [RACSubject subject];
    if ((!baseImageURL || !posterSizes) && [HTTPClient hasRequestInQueueWithURL:[TMDB URLForConfiguration]] == NO) {
        [[HTTPClient GET:[TMDB URLForConfiguration]] subscribeNext:^(NSDictionary *response) {
            baseImageURL = [response valueForKeyPath:TMDB_IMAGE_BASE_URL_KEY_PATH];
            posterSizes = [response valueForKeyPath:TMDB_IMAGE_POSTER_SIZES_KEY_PATH];
            [subject sendNext:@[baseImageURL, posterSizes]];
        }];
    } else if (baseImageURL && posterSizes) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [subject sendNext:@[baseImageURL, posterSizes]];
        });
    } else {
        ERROR(@"Configuration request may have failed.");
    }
    return subject;
}

@end
