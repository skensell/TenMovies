//
//  TMDBDiscoverMovieQueryParameters.m
//  TenMovies
//
//  Created by Scott Kensell on 6/7/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDBDiscoverMovieQueryParameters.h"

#import "Logging.h"
#import "TMDBGenre.h"

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
            _isRandom = [dict[kDictRepIsRandomKey] boolValue];
            
            NSMutableArray *genres = [NSMutableArray new];
            for (NSNumber *genreType in (NSArray *)dict[kDictRepGenresKey]) {
                TMDBGenre *genre = [TMDBGenre genreWithType:[genreType integerValue]];
                [genres addObject:genre];
            }
            _genres = genres;
            
        } else {
            _fromYear = 2013;
            _toYear = 2014;
            _sortByType = SORT_BY_POPULARITY_DESC;
            _genres = [TMDBGenre allGenres];
            _isRandom = NO;
        }
    }
    return self;
}

- (NSDictionary *)asDictionary {
    NSMutableArray *genreTypes = [NSMutableArray new];
    for (TMDBGenre *genre in self.genres) {
        [genreTypes addObject:[NSNumber numberWithInteger:genre.type]];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:@(self.fromYear), kDictRepFromYearKey,
            @(self.toYear), kDictRepToYearKey,
            @(self.sortByType), kDictRepSortByTypeKey,
            genreTypes, kDictRepGenresKey,
            @(self.isRandom), kDictRepIsRandomKey,
            nil];
}

- (NSString *)genreQueryString {
    if (![self.genres count]) {
        return @"";
    } else {
        NSMutableArray *types = [NSMutableArray new];
        for (TMDBGenre *genre in self.genres) {
            [types addObject:[NSNumber numberWithInt:genre.type]];
        }
        return [types componentsJoinedByString:@"|"];
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
