//
//  TMDBDiscoverMovieQueryParameters.h
//  TenMovies
//
//  Created by Scott Kensell on 6/7/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Logging.h"
#import "TMDBMovieGenreTypes.h"
#import "TMDBSortByTypes.h"


@interface TMDBDiscoverMovieQueryParameters : NSObject

@property (nonatomic) NSUInteger fromYear;
@property (nonatomic) NSUInteger toYear;
@property (nonatomic) TMDBDSortBy_t sortByType;
@property (nonatomic) NSArray *OF_TYPE(NSNumber *) genres;
@property (nonatomic) BOOL isRandom;

- (NSString *)genreQueryString;

+ (NSString *)sortByTypeAsString:(TMDBDSortBy_t)sortByType;

@end
