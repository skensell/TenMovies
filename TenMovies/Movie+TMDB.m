//
//  Movie+TMDB.m
//  TenMovies
//
//  Created by Scott Kensell on 5/11/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "Movie+TMDB.h"

#import "TMDB.h"

@implementation Movie (TMDB)

+ (NSArray *)moviesFromTMDBResults:(NSArray *)results {
    NSMutableArray *movies = [NSMutableArray new];
    [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [movies addObject:[Movie movieFromTMDBMovieDict:obj]];
    }];
    return movies;
}

+ (Movie *)movieFromTMDBMovieDict:(NSDictionary *)movieDict {
    Movie *movie = [Movie new];
    
    movie.cast = [movieDict valueForKeyPath:TMDB_CAST_KEY_PATH];
    movie.crew = [movieDict valueForKeyPath:TMDB_CREW_KEY_PATH];
    movie.genres = [movieDict valueForKeyPath:TMDB_GENRES_KEY_PATH];
    
    movie.releaseDate = [self _dateFromString:movieDict[TMDB_RELEASE_DATE_KEY_PATH]];
    movie.ID = movieDict[TMDB_MOVIE_ID_KEY_PATH];
    
    movie.popularity = movieDict[TMDB_POPULARITY_KEY_PATH];
    movie.voteAverage = movieDict[TMDB_VOTE_AVERAGE_KEY_PATH];
    movie.runtime = [movieDict valueForKeyPath:TMDB_RUNTIME_KEY_PATH];
    
    movie.posterPath = movieDict[TMDB_POSTER_PATH_KEY_PATH];
   
    movie.overview = movieDict[TMDB_OVERVIEW_KEY_PATH];
    movie.title = movieDict[TMDB_TITLE_KEY_PATH];
    
    movie.youtubeID = [TMDBParser youTubeTrailerIDFromVideosArray:[movieDict valueForKeyPath:TMDB_VIDEOS_KEY_PATH]];
    
    return movie;
}

#pragma mark - Private

+ (NSDate *)_dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter dateFromString:dateString];
}

@end
