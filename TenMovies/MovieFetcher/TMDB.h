//
//  TMDB.h
//  TenMovies
//
//  Created by Scott Kensell on 5/3/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMDBMovieGenreTypes.h"
#import "TMDBDiscoverMovieQueryParameters.h"

#define TMDB_MOVIE_ID_FULL_PATH @"results.id"

#define TMDB_MOVIE_ID_KEY_PATH @"id"
#define TMDB_RELEASE_DATE_KEY_PATH @"release_date"
#define TMDB_POPULARITY_KEY_PATH @"popularity"
#define TMDB_VOTE_AVERAGE_KEY_PATH @"vote_average"
#define TMDB_POSTER_PATH_KEY_PATH @"poster_path"
#define TMDB_OVERVIEW_KEY_PATH @"overview"
#define TMDB_TITLE_KEY_PATH @"title"
#define TMDB_RUNTIME_KEY_PATH @"runtime"
#define TMDB_VIDEOS_KEY_PATH @"videos.results"
#define TMDB_CAST_KEY_PATH @"credits.cast"
#define TMDB_CREW_KEY_PATH @"credits.crew"
#define TMDB_GENRES_KEY_PATH @"genres"

#define TMDB_IMAGE_BASE_URL_KEY_PATH @"images.base_url"
#define TMDB_IMAGE_POSTER_SIZES_KEY_PATH @"images.poster_sizes"


@interface TMDB : NSObject

+ (NSString *)URLForConfiguration;
+ (NSString *)URLForGenre:(TMDBMovieGenre_t)genre;
+ (NSString *)URLForGenreList;
+ (NSString *)URLForDiscovery;
+ (NSString *)URLForMovie:(NSNumber *)movieID;
+ (NSString *)URLForDiscoveryFromMovieQueryParameters:(TMDBDiscoverMovieQueryParameters *)params;

+ (NSString *)youTubeTrailerIDFromVideosArray:(NSArray *)videos;

@end
