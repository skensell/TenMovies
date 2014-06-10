//
//  TMDB+Discover.m
//  TenMovies
//
//  Created by Scott Kensell on 6/7/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDBSignals+Discover.h"

#import "HTTPClient.h"

#import "RACSignal.h"

@implementation TMDBSignals (Discover)

+ (RACSignal *)movieIDsFromDiscoverQueryParameters:(TMDBDiscoverMovieQueryParameters *)params {
    return [[HTTPClient GET:[TMDBUrls URLForDiscoveryFromMovieQueryParameters:params]] map:^NSArray *(id response) {
        return [response valueForKeyPath:TMDB_MOVIE_ID_FULL_PATH];
    }];;
}

@end
