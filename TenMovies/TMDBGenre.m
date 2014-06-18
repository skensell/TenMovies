//
//  TMDBGenre.m
//  TenMovies
//
//  Created by Scott Kensell on 6/14/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDBGenre.h"

#import "TMDBMovieGenreTypes.h"

@interface TMDBGenre ()

@property (strong, nonatomic, readwrite) NSString *asText;
@property (nonatomic, readwrite) TMDBMovieGenre_t type;

@end

@implementation TMDBGenre

+ (TMDBGenre *)genreWithAlphabeticalIndex:(NSInteger)index {
    return [[TMDBGenre allGenres] objectAtIndex:index];
}

+ (TMDBGenre *)genreWithType:(TMDBMovieGenre_t)type {
    for (TMDBGenre *genre in [TMDBGenre allGenres]) {
        if (genre.type == type) {
            return genre;
        }
    }
    return nil;
}

+ (TMDBGenre *)genreFromString:(NSString *)stringRep {
    for (TMDBGenre *genre in [TMDBGenre allGenres]) {
        if ([stringRep isEqualToString:[genre asText]]) {
            return genre;
        }
    }
    return nil;
}

#pragma mark - All Genres

static inline NSArray *_allGenres() {
    static NSMutableArray *_allGenres;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _allGenres = [[NSMutableArray alloc] init];
        
        for (NSArray *genreAsArray in [TMDBGenre _allGenreInfo]) {
            
            TMDBGenre *genre = [[TMDBGenre alloc] init];
            genre.type = [[genreAsArray objectAtIndex:0] integerValue];
            genre.asText = [genreAsArray objectAtIndex:1];
            [_allGenres addObject:genre];
            
        }
    });
    
    return _allGenres;
}

+ (NSArray *)allGenres {
    return _allGenres();
}

+ (NSArray *)_allGenreInfo {
    return @[@[@(TMDB_GENRE_ACTION), @"Action"],
             @[@(TMDB_GENRE_ADVENTURE), @"Adventure"],
             @[@(TMDB_GENRE_ANIMATION), @"Animation"],
             @[@(TMDB_GENRE_COMEDY), @"Comedy"],
             @[@(TMDB_GENRE_CRIME), @"Crime"],
             @[@(TMDB_GENRE_DISASTER), @"Disaster"],
             @[@(TMDB_GENRE_DOCUMENTARY), @"Documentary"],
             @[@(TMDB_GENRE_DRAMA), @"Drama"],
             @[@(TMDB_GENRE_EASTERN), @"Eastern"],
             @[@(TMDB_GENRE_EROTIC), @"Erotic"],
             @[@(TMDB_GENRE_FAMILY), @"Family"],
             @[@(TMDB_GENRE_FAN_FILM), @"Fan Film"],
             @[@(TMDB_GENRE_FANTASY), @"Fantasy"],
             @[@(TMDB_GENRE_FILM_NOIR), @"Film Noir"],
             @[@(TMDB_GENRE_FOREIGN), @"Foreign"],
             @[@(TMDB_GENRE_HISTORY), @"History"],
             @[@(TMDB_GENRE_HOLIDAY), @"Holiday"],
             @[@(TMDB_GENRE_HORROR), @"Horror"],
             @[@(TMDB_GENRE_INDIE), @"Indie"],
             @[@(TMDB_GENRE_MUSIC), @"Music"],
             @[@(TMDB_GENRE_MUSICAL), @"Musical"],
             @[@(TMDB_GENRE_MYSTERY), @"Mystery"],
             @[@(TMDB_GENRE_NEO_NOIR), @"Neo Noir"],
             @[@(TMDB_GENRE_ROAD_MOVIE), @"Road Movie"],
             @[@(TMDB_GENRE_ROMANCE), @"Romance"],
             @[@(TMDB_GENRE_SCIENCE_FICTION), @"Science Fiction"],
             @[@(TMDB_GENRE_SHORT), @"Short"],
             @[@(TMDB_GENRE_SPORT), @"Sport"],
             @[@(TMDB_GENRE_SPORTING_EVENT), @"Sporting Event"],
             @[@(TMDB_GENRE_SPORTS_FILM), @"Sports Film"],
             @[@(TMDB_GENRE_SUSPENSE), @"Suspense"],
             @[@(TMDB_GENRE_TV_MOVIE), @"TV Movie"],
             @[@(TMDB_GENRE_THRILLER), @"Thriller"],
             @[@(TMDB_GENRE_WAR), @"War"],
             @[@(TMDB_GENRE_WESTERN), @"Western"]];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[TMDBGenre class]] == NO) {
        return NO;
    }
    TMDBGenre *genre = (TMDBGenre *)object;
    return genre.type == self.type;
}

@end
