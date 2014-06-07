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

@implementation TMDBDiscoverMovieQueryParameters

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

@end
