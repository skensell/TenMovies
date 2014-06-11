//
//  TMDBDiscoverMovieQueryParameters.m
//  TenMovies
//
//  Created by Scott Kensell on 6/7/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDBDiscoverMovieQueryParameters.h"

#import "Logging.h"

static NSString *kVoteAverageDesc = @"vote_average.desc";
static NSString *kVoteAverageAsc = @"vote_average.asc";
static NSString *kReleaseDateDesc = @"release_date.desc";
static NSString *kReleaseDateAsc = @"release_date.asc";
static NSString *kPopularityDesc = @"popularity.desc";
static NSString *kPopularityAsc = @"popularity.asc";

static NSString *kDictRepFromYearKey = @"fromYear";
static NSString *kDictRepToYearKey = @"toYear";
static NSString *kDictRepSortByTypeKey = @"sortByType";
static NSString *kDictRepGenresKey = @"genres";
static NSString *kDictRepIsRandomKey = @"isRandom";



@implementation TMDBDiscoverMovieQueryParameters

- (instancetype)init {
    return [self initWithDictionary:nil];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if (dict) {
            _fromYear = [dict[kDictRepFromYearKey] integerValue];
            _toYear = [dict[kDictRepToYearKey] integerValue];
            _sortByType = [dict[kDictRepSortByTypeKey] intValue];
            _genres = (NSArray *)dict[kDictRepGenresKey];
            _isRandom = [dict[kDictRepIsRandomKey] boolValue];
        } else {
            _fromYear = 2013;
            _toYear = 2014;
            _sortByType = SORT_BY_POPULARITY_DESC;
            _genres = [TMDBDiscoverMovieQueryParameters allGenres];
            _isRandom = NO;
        }
    }
    return self;
}

- (NSDictionary *)asDictionary {
    return [NSDictionary dictionaryWithObjectsAndKeys:@(self.fromYear), kDictRepFromYearKey,
            @(self.toYear), kDictRepToYearKey,
            @(self.sortByType), kDictRepSortByTypeKey,
            self.genres, kDictRepGenresKey,
            @(self.isRandom), kDictRepIsRandomKey,
            nil];
}

- (NSString *)genreQueryString {
    if (![self.genres count]) {
        return @"";
    } else {
        return [self.genres componentsJoinedByString:@"|"];
    }
}

+ (NSString *)sortByTypeAsString:(TMDBDSortBy_t)sortByType {
    NSString *s = nil;
    switch (sortByType) {
        case SORT_BY_POPULARITY_ASC:
            s = kPopularityAsc;
            break;
        case SORT_BY_POPULARITY_DESC:
            s = kPopularityDesc;
            break;
        case SORT_BY_RELEASE_DATE_ASC:
            s = kReleaseDateAsc;
            break;
        case SORT_BY_RELEASE_DATE_DESC:
            s = kReleaseDateDesc;
            break;
        case SORT_BY_VOTE_AVERAGE_ASC:
            s = kVoteAverageAsc;
            break;
        case SORT_BY_VOTE_AVERAGE_DESC:
            s = kVoteAverageDesc;
            break;
        default:
            ERROR(@"Invalid sortByType");
            break;
    }
    return s;
}

+ (NSArray *)allGenres {
    return @[@(TMDB_GENRE_ACTION),
             @(TMDB_GENRE_ADVENTURE),
             @(TMDB_GENRE_ANIMATION),
             @(TMDB_GENRE_COMEDY),
             @(TMDB_GENRE_CRIME),
             @(TMDB_GENRE_DISASTER),
             @(TMDB_GENRE_DOCUMENTARY),
             @(TMDB_GENRE_DRAMA),
             @(TMDB_GENRE_EASTERN),
             @(TMDB_GENRE_EROTIC),
             @(TMDB_GENRE_FAMILY),
             @(TMDB_GENRE_FAN_FILM),
             @(TMDB_GENRE_FANTASY),
             @(TMDB_GENRE_FILM_NOIR),
             @(TMDB_GENRE_FOREIGN),
             @(TMDB_GENRE_HISTORY),
             @(TMDB_GENRE_HOLIDAY),
             @(TMDB_GENRE_HORROR),
             @(TMDB_GENRE_INDIE),
             @(TMDB_GENRE_MUSIC),
             @(TMDB_GENRE_MUSICAL),
             @(TMDB_GENRE_MYSTERY),
             @(TMDB_GENRE_NEO_NOIR),
             @(TMDB_GENRE_ROAD_MOVIE),
             @(TMDB_GENRE_ROMANCE),
             @(TMDB_GENRE_SCIENCE_FICTION),
             @(TMDB_GENRE_SHORT),
             @(TMDB_GENRE_SPORT),
             @(TMDB_GENRE_SPORTING_EVENT),
             @(TMDB_GENRE_SPORTS_FILM),
             @(TMDB_GENRE_SUSPENSE),
             @(TMDB_GENRE_TV_MOVIE),
             @(TMDB_GENRE_THRILLER),
             @(TMDB_GENRE_WAR),
             @(TMDB_GENRE_WESTERN)];
}

#pragma mark - NSObject

-(BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[TMDBDiscoverMovieQueryParameters class]] == NO) {
        return NO;
    }
    
    TMDBDiscoverMovieQueryParameters *params = (TMDBDiscoverMovieQueryParameters *)object;
    BOOL hasSameGenres = [[NSSet setWithArray:self.genres] isEqualToSet:[NSSet setWithArray:params.genres]];
    
    return (self.fromYear == params.fromYear &&
            self.toYear == params.toYear &&
            self.isRandom == params.isRandom &&
            self.sortByType == params.sortByType &&
            hasSameGenres);
}

- (NSString *)description {
    return [[self asDictionary] description];
}

@end
