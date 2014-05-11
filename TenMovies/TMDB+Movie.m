//
//  TMDB+Movie.m
//  TenMovies
//
//  Created by Scott Kensell on 5/11/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDB+Movie.h"

#import <ReactiveCocoa.h>

#import "HTTPClient.h"
#import "Logging.h"
#import "Movie.h"
#import "Movie+TMDB.h"

@implementation TMDB (Movie)

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
    return [self GET:[TMDB URLForGenre:genre]];
}

+ (RACSignal *OF_TYPE(NSDictionary *))movieInfoFromMovieID:(NSNumber *)movieID {
    return [self GET:[TMDB URLForMovie:movieID]];
}

+ (RACSignal *)GET:(NSString *)url {
    RACSubject *subject = [RACSubject subject];
    [[HTTPClient sharedClient] GET:url parameters:nil
                           success:^(id task, id responseObject) {
                               [subject sendNext:responseObject];
                           } failure:^(id task, NSError *error) {
                               ERROR(@"Failed request: %@", [error localizedDescription]);
                               [subject sendError:error];
                           }];
    
    return subject;
}

@end