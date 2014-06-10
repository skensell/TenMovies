//
//  TMDB+Movie.m
//  TenMovies
//
//  Created by Scott Kensell on 5/11/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDBSignals+Movie.h"

#import "HTTPClient.h"
#import "Movie.h"
#import "Movie+TMDB.h"

#import <ReactiveCocoa.h>

@implementation TMDBSignals (Movie)

+ (RACSignal *OF_TYPE(NSArray *))movieIDsFromGenre:(TMDBMovieGenre_t)genre {
    return [[self moviesInGenre:genre] map:^NSArray *(id response) {
        return [response valueForKeyPath:TMDB_MOVIE_ID_FULL_PATH];
    }];
}

+ (RACSignal *)movieDictsFromMovieIDs:(NSArray *)movieIDs {
    RACSequence *movieInfoSignals = [movieIDs.rac_sequence map:^id(NSNumber *movieID) {
        return [self movieInfoFromMovieID:movieID];
    }];
    RACSignal *combinedMovieInfoSignal = [RACSignal combineLatest:movieInfoSignals];
    return combinedMovieInfoSignal;
}

#pragma mark - Private

+ (RACSignal *OF_TYPE(NSDictionary *))moviesInGenre:(TMDBMovieGenre_t)genre {
    return [HTTPClient GET:[TMDBUrls URLForGenre:genre]];
}

+ (RACSignal *OF_TYPE(NSDictionary *))movieInfoFromMovieID:(NSNumber *)movieID {
    return [HTTPClient GET:[TMDBUrls URLForMovie:movieID]];
}

@end
