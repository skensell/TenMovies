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
    
    movie.releaseDate = [self _dateFromString:movieDict[@"release_date"]];
    movie.ID = movieDict[@"id"];
    
    movie.popularity = movieDict[@"popularity"];
    movie.voteAverage = movieDict[@"vote_average"];
    
    movie.posterPath = movieDict[@"poster_path"];
    
    movie.title = movieDict[@"title"];
    
    return movie;
}

- (NSString *)description {
    NSArray *props = @[self.releaseDate, self.ID, self.popularity, self.voteAverage, self.posterPath, self.title];
    return [props description];
}

#pragma mark - Private

+ (NSDate *)_dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter dateFromString:dateString];
}

@end
