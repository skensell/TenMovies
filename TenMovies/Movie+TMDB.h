//
//  Movie+TMDB.h
//  TenMovies
//
//  Created by Scott Kensell on 5/11/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "Movie.h"

@interface Movie (TMDB)

+ (NSArray *)moviesFromTMDBResults:(NSArray *)results;

@end
