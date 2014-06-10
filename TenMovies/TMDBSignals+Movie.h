//
//  TMDB+Movie.h
//  TenMovies
//
//  Created by Scott Kensell on 5/11/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDBSignals.h"

@interface TMDBSignals (Movie)

// sends next when the one request finishes
+ (RACSignal *OF_TYPE(NSArray *))movieIDsFromGenre:(TMDBMovieGenre_t)genre;

// sends next only after all movie requests (about 20) have finished
+ (RACSignal *OF_TYPE(RACTuple))movieDictsFromMovieIDs:(NSArray *)movieIDs;

@end
