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
#import "Movie+TMDB.h"
#import "TMDB+Movie.h"

static NSString *kTableViewCellIdentifier = @"MovieCell";
static CGFloat kMovieCellHeight = 150.0f;

@interface MovieList()

@property (nonatomic,strong) NSArray *movies OF_TYPE(Movie);

@end

@implementation MovieList

- (void)viewDidLoad {
    [super viewDidLoad];

    [[TMDB movieIDsFromGenre:TMDB_GENRE_ACTION] subscribeNext:^(NSArray *movieIDs) {
        [[TMDB movieDictsFromMovieIDs:movieIDs] subscribeNext:^(RACTuple *movieDicts) {
            self.movies = [Movie moviesFromTMDBResults:[movieDicts allObjects]];
            [self.tableView reloadData];
        }];
    }];
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
