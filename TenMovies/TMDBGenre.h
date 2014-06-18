//
//  TMDBGenre.h
//  TenMovies
//
//  Created by Scott Kensell on 6/14/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMDBMovieGenreTypes.h"

@interface TMDBGenre : NSObject

@property (strong, nonatomic, readonly) NSString *asText;
@property (nonatomic, readonly) TMDBMovieGenre_t type;

+ (NSArray *)allGenres;
+ (TMDBGenre *)genreWithAlphabeticalIndex:(NSInteger)index;
+ (TMDBGenre *)genreWithType:(TMDBMovieGenre_t)type;
+ (TMDBGenre *)genreFromString:(NSString *)stringRep;

@end
