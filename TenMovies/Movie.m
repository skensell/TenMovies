//
//  Movie.m
//  
//
//  Created by Scott Kensell on 5/10/14.
//
//

#import "Movie.h"

@implementation Movie

+ (NSArray *)moviesFromTMDBResults:(NSArray *)results {
    NSMutableArray *movies = [NSMutableArray new];
    [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [movies addObject:[Movie movieFromTMDBMovieDict:obj]];
    }];
    return movies;
}

+ (Movie *)movieFromTMDBMovieDict:(NSDictionary *)movieDict {
    Movie *movie = [Movie new];
    movie.title = movieDict[@"title"];
    movie.popularity = movieDict[@"popularity"];
    return movie;
}

@end
