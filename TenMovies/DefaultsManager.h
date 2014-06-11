//
//  DefaultsManager.h
//  TenMovies
//
//  Created by Scott Kensell on 6/11/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMDBDiscoverMovieQueryParameters;

@interface DefaultsManager : NSObject

+ (TMDBDiscoverMovieQueryParameters *)discoverMovieQueryParameters;
+ (void)setDiscoverMovieQueryParameters:(TMDBDiscoverMovieQueryParameters *)params;

@end
