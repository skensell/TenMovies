//
//  MovieFetcher.h
//  TenMovies
//
//  Created by Scott Kensell on 5/3/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TMDB_GENRE_ACTION = 28,
    TMDB_GENRE_ADVENTURE = 12,
    TMDB_GENRE_ANIMATION = 16,
    TMDB_GENRE_COMEDY = 35,
    TMDB_GENRE_CRIME = 80,
    TMDB_GENRE_DISASTER = 105,
    TMDB_GENRE_DOCUMENTARY = 99,
    TMDB_GENRE_DRAMA = 18,
    TMDB_GENRE_EASTERN = 82,
    TMDB_GENRE_EROTIC = 2916,
    TMDB_GENRE_FAMILY = 10751,
    TMDB_GENRE_FAN_FILM = 10750,
    TMDB_GENRE_FANTASY = 14,
    TMDB_GENRE_FILM_NOIR = 10753,
    TMDB_GENRE_FOREIGN = 10769,
    TMDB_GENRE_HISTORY = 36,
    TMDB_GENRE_HOLIDAY = 10595,
    TMDB_GENRE_HORROR = 27,
    TMDB_GENRE_INDIE = 10756,
    TMDB_GENRE_MUSIC = 10402,
    TMDB_GENRE_MUSICAL = 22,
    TMDB_GENRE_MYSTERY = 9648,
    TMDB_GENRE_NEO_NOIR = 10754,
    TMDB_GENRE_ROAD_MOVIE = 1115,
    TMDB_GENRE_ROMANCE = 10749,
    TMDB_GENRE_SCIENCE_FICTION = 878,
    TMDB_GENRE_SHORT = 10755,
    TMDB_GENRE_SPORT = 9805,
    TMDB_GENRE_SPORTING_EVENT = 10758,
    TMDB_GENRE_SPORTS_FILM = 10757,
    TMDB_GENRE_SUSPENSE = 10748,
    TMDB_GENRE_TV_MOVIE = 10770,
    TMDB_GENRE_THRILLER = 53,
    TMDB_GENRE_WAR = 10752,
    TMDB_GENRE_WESTERN = 37
} TMDBMovieGenre_t;

#define TMDB_MOVIE_ID_FULL_PATH @"results.id"

#define TMDB_MOVIE_ID_KEY_PATH @"id"
#define TMDB_RELEASE_DATE_KEY_PATH @"release_date"
#define TMDB_POPULARITY_KEY_PATH @"popularity"
#define TMDB_VOTE_AVERAGE_KEY_PATH @"vote_average"
#define TMDB_POSTER_PATH_KEY_PATH @"poster_path"
#define TMDB_TITLE_KEY_PATH @"title"


@interface MovieFetcher : NSObject

+ (NSString *)URLForGenre:(TMDBMovieGenre_t)genre;
+ (NSString *)URLForGenreList;
+ (NSString *)URLForDiscovery;
+ (NSString *)URLForMovie:(NSNumber *)movieID;

@end
