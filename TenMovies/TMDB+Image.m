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
#import "TMDBAPIKey.h"

static NSString *kThumbnailImageWidthPreferred = @"w92";
static NSString *kThumbnailImageWidthSecondary = @"w154";

@implementation TMDB (Image)

+ (RACSignal *OF_TYPE(NSData))thumbnailImageForPosterPath:(NSString *)posterPath {
    RACSubject *subject = [RACSubject subject];
    [[self _configurationSignal] subscribeNext:^(NSArray *config) {
        NSParameterAssert([config count] == 2);
        NSString *baseImageURL = config[0];
        NSString *thumbnailWidth = [self _thumbnailWidthFromPosterSizes:config[1]];
        NSString *url = [self _imageURLwithBase:baseImageURL width:thumbnailWidth path:posterPath];
        [[HTTPClient GET:url] subscribeNext:^(UIImage *image) {
            [subject sendNext:image];
        }];
    }];
    return subject;
}

#pragma mark - Private

+ (RACSignal *)_configurationSignal {
    static RACReplaySubject *subject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        subject = [RACReplaySubject replaySubjectWithCapacity:RACReplaySubjectUnlimitedCapacity];
        [[HTTPClient GET:[TMDB URLForConfiguration]] subscribeNext:^(NSDictionary *response) {
            NSString *baseImageURL = [response valueForKeyPath:TMDB_IMAGE_BASE_URL_KEY_PATH];
            NSArray *posterSizes = [response valueForKeyPath:TMDB_IMAGE_POSTER_SIZES_KEY_PATH];
            if (!baseImageURL || !posterSizes) {
                ERROR(@"No baseImageURL or posterSizes.");
                [subject sendError:nil];
            } else {
                [subject sendNext:@[baseImageURL, posterSizes]];
            }
        }];
    });
    return subject;
}

+ (NSString *)_thumbnailWidthFromPosterSizes:(NSArray *)posterSizes {
    NSParameterAssert([posterSizes count] > 0);
    NSMutableArray *preferred = [NSMutableArray new];
    [posterSizes enumerateObjectsUsingBlock:^(NSString *width, NSUInteger idx, BOOL *stop) {
        if ([width isEqualToString:kThumbnailImageWidthPreferred]) {
            [preferred insertObject:width atIndex:0];
        } else if ([width isEqualToString:kThumbnailImageWidthSecondary]) {
            [preferred addObject:width];
        }
    }];
    return (preferred.count > 0) ? preferred[0] : posterSizes[0];
}

+ (NSString *)_imageURLwithBase:(NSString *)base width:(NSString *)width path:(NSString *)path {
    NSParameterAssert([path hasPrefix:@"/"]);
    return [NSString stringWithFormat:@"%@%@%@?api_key=%@", base, width, path, TMDB_API_KEY];
}

@end
