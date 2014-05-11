//
//  MovieList.m
//  TenMovies
//
//  Created by Scott Kensell on 5/9/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "MovieList.h"

#import <ReactiveCocoa.h>

#import "HTTPClient.h"
#import "Logging.h"
#import "Movie.h"
#import "MovieFetcher.h"

static NSString *kTableViewCellIdentifier = @"MovieCell";
static CGFloat kMovieCellHeight = 150.0f;

@interface MovieList()

@property (nonatomic,strong) NSArray *movies OF_TYPE(Movie);

@end

@implementation MovieList

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self movieIDsForGenre:TMDB_GENRE_ACTION] subscribeNext:^(NSArray *movieIDs) {
        [[self moviesFromMovieIDs:movieIDs] subscribeNext:^(RACTuple *movieInfos) {
            self.movies = [Movie moviesFromTMDBResults:[movieInfos allObjects]];
            [self.tableView reloadData];
        }];
    }];
}

- (RACSignal *OF_TYPE(NSArray *OF_TYPE(NSNumber)))movieIDsForGenre:(TMDBMovieGenre_t)genre {
    RACSubject *subject = [RACSubject subject];
    [[HTTPClient sharedClient] GET:[MovieFetcher URLForGenre:genre] parameters:nil
                           success:^(id task, id responseObject) {
                               NSArray *_movieIDs = [responseObject valueForKeyPath:TMDB_MOVIE_ID_FULL_PATH];
                               [subject sendNext:_movieIDs];
                               
                           } failure:^(id task, NSError *error) {
                               ERROR(@"Failed request: %@", [error localizedDescription]);
                               [subject sendError:nil];
                           }];
    return subject;
}

- (RACSignal *OF_TYPE(NSDictionary))movieInfoFromMovieID:(NSNumber *)movieID {
    RACSubject *subject = [RACSubject subject];
    [[HTTPClient sharedClient] GET:[MovieFetcher URLForMovie:movieID] parameters:nil
                           success:^(id task, id responseObject) {
                               [subject sendNext:responseObject];
                           } failure:^(id task, NSError *error) {
                               ERROR(@"Failed request: %@", [error localizedDescription]);
                               [subject sendError:nil];
                           }];
    
    return subject;
}

- (RACSignal *)moviesFromMovieIDs:(NSArray *)movieIDs {
    RACSequence *movieInfoSignals = [movieIDs.rac_sequence map:^id(NSNumber *movieID) {
        return [self movieInfoFromMovieID:movieID];
    }];
    RACSignal *combinedMovieInfoSignal = [RACSignal combineLatest:movieInfoSignals];
    return combinedMovieInfoSignal;
}

- (void)populateMovies:(NSArray *)results {
    DEBUG(@"%d results", results.count);
    
    self.movies = [Movie moviesFromTMDBResults:results];
}

#pragma mark - TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier];
    Movie *movie = [self movieAtIndexPath:indexPath];
    cell.textLabel.text = movie.title;
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [movie.voteAverage description];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? self.movies.count : 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kMovieCellHeight;
}

#pragma mark - Private

- (Movie *)movieAtIndexPath:(NSIndexPath *)indexPath {
    return self.movies[indexPath.row];
}

@end
