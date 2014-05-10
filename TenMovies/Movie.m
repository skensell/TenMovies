//
//  Movie.m
//  
//
//  Created by Scott Kensell on 5/10/14.
//
//

#import "Movie.h"

#import "MovieFetcher.h"

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
    
    movie.releaseDate = [self _dateFromString:movieDict[TMDB_RELEASE_DATE_KEY_PATH]];
    movie.ID = movieDict[TMDB_MOVIE_ID_KEY_PATH];
    
    movie.popularity = movieDict[TMDB_POPULARITY_KEY_PATH];
    movie.voteAverage = movieDict[TMDB_VOTE_AVERAGE_KEY_PATH];
    
    movie.posterPath = movieDict[TMDB_POSTER_PATH_KEY_PATH];
    
    movie.title = movieDict[TMDB_TITLE_KEY_PATH];
    
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
