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
@property (nonatomic) NSArray *OF_TYPE(TMDBGenre *) genres;
@property (nonatomic) BOOL isRandom;
@property (nonatomic) NSUInteger minNumberOfVotes;
@property (nonatomic) NSUInteger page;

- (NSString *)queryString;

// for storage in NSUserDefaults
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)asDictionary;

@end
