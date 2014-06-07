//
//  TMDB+Discover.h
//  TenMovies
//
//  Created by Scott Kensell on 6/7/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDB.h"

#import "TMDBDiscoverMovieQueryParameters.h"

#import "Logging.h"

@class RACSignal;

@interface TMDB (Discover)

// sends next when the request finishes
+ (RACSignal *OF_TYPE(NSArray *))movieIDsFromDiscoverQueryParameters:(TMDBDiscoverMovieQueryParameters *)params;

@end
