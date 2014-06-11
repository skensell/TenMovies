//
//  DefaultsManager.m
//  TenMovies
//
//  Created by Scott Kensell on 6/11/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "DefaultsManager.h"

#import "TMDBDiscoverMovieQueryParameters.h"

static NSString *kDiscoverMovieQueryParamsKey = @"DiscoverMovieQueryParamsKey";

@implementation DefaultsManager

+ (TMDBDiscoverMovieQueryParameters *)discoverMovieQueryParameters {
    TMDBDiscoverMovieQueryParameters *params = [[NSUserDefaults standardUserDefaults] objectForKey:kDiscoverMovieQueryParamsKey];
    if (!params) {
        params = [[TMDBDiscoverMovieQueryParameters alloc] init];
    }
    return params;
}

+ (void)setDiscoverMovieQueryParameters:(TMDBDiscoverMovieQueryParameters *)params {
    [[NSUserDefaults standardUserDefaults] setObject:params forKey:kDiscoverMovieQueryParamsKey];
}

@end
