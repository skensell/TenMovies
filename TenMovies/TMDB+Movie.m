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

+ (RACSignal *OF_TYPE(NSArray))movieIDsFromGenre:(TMDBMovieGenre_t)genre {
    RACSubject *subject = [RACSubject subject];
    [[HTTPClient sharedClient] GET:[TMDB URLForGenre:genre] parameters:nil
                           success:^(id task, id responseObject) {
                               NSArray *_movieIDs = [responseObject valueForKeyPath:TMDB_MOVIE_ID_FULL_PATH];
                               [subject sendNext:_movieIDs];
                               
                           } failure:^(id task, NSError *error) {
                               ERROR(@"Failed request: %@", [error localizedDescription]);
                               [subject sendError:nil];
                           }];
    return subject;
}

+ (RACSignal *OF_TYPE(NSDictionary))movieInfoFromMovieID:(NSNumber *)movieID {
    RACSubject *subject = [RACSubject subject];
    [[HTTPClient sharedClient] GET:[TMDB URLForMovie:movieID] parameters:nil
                           success:^(id task, id responseObject) {
                               [subject sendNext:responseObject];
                           } failure:^(id task, NSError *error) {
                               ERROR(@"Failed request: %@", [error localizedDescription]);
                               [subject sendError:nil];
                           }];
    
    return subject;
}

+ (RACSignal *)movieDictsFromMovieIDs:(NSArray *)movieIDs {
    RACSequence *movieInfoSignals = [movieIDs.rac_sequence map:^id(NSNumber *movieID) {
        return [self movieInfoFromMovieID:movieID];
    }];
    RACSignal *combinedMovieInfoSignal = [RACSignal combineLatest:movieInfoSignals];
    return combinedMovieInfoSignal;
}

@end
