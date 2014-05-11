//
//  TMDB+Movie.h
//  TenMovies
//
//  Created by Scott Kensell on 5/11/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDB.h"

#import "Logging.h"

@class RACSignal;

@interface TMDB (Movie)

+ (RACSignal *OF_TYPE(NSArray))movieIDsFromGenre:(TMDBMovieGenre_t)genre;
+ (RACSignal *OF_TYPE(RACTuple))movieDictsFromMovieIDs:(NSArray *)movieIDs;

@end
