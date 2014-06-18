//
//  TMDB+Discover.m
//  TenMovies
//
//  Created by Scott Kensell on 6/7/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDBSignals+Discover.h"

#import "HTTPClient.h"
#import "TMDBErrors.h"

#import "RACSignal.h"
#import "RACSubject.h"

@implementation TMDBSignals (Discover)

+ (RACSignal *)movieIDsFromDiscoverQueryParameters:(TMDBDiscoverMovieQueryParameters *)params {
    RACSubject *subject = [RACSubject subject];
    [[HTTPClient GET:[TMDBUrls URLForDiscoveryFromMovieQueryParameters:params]] subscribeNext:^(id response) {
        NSArray *movieIds = [response valueForKeyPath:TMDB_MOVIE_ID_FULL_PATH];
        if (movieIds.count) {
            [subject sendNext:movieIds];
        } else {
            NSError *error = [NSError errorWithDomain:TMDB_ERROR_DOMAIN code:TMDB_ERROR_NO_MOVIES userInfo:@{NSLocalizedDescriptionKey : @"No movies."}];
            [subject sendError:error];
        }
    }];
    return subject;
}

@end
