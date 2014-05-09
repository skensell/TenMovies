//
//  MovieList.m
//  TenMovies
//
//  Created by Scott Kensell on 5/9/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "MovieList.h"

#import "HTTPClient.h"
#import "Logging.h"
#import "Movie.h"
#import "MovieFetcher.h"

static NSString *kTableViewCellIdentifier = @"MovieCell";

@interface MovieList()

@property (nonatomic,strong) NSArray *movies OF_TYPE(Movie);

@end

@implementation MovieList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchMovies];
}

- (void)fetchMovies {
    [[HTTPClient sharedClient] GET:[MovieFetcher URLForGenre:TMDB_GENRE_ACTION] parameters:nil
                           success:^(NSURLSessionDataTask *task, id responseObject) {
                               
                               NSArray *results = [(NSDictionary *)responseObject valueForKeyPath:@"results"];
                               [self populateMovies:results];
                               [self.tableView reloadData];

                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                               ERROR(@"Failed request");
                           }];
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
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? self.movies.count : 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Private

- (Movie *)movieAtIndexPath:(NSIndexPath *)indexPath {
    return self.movies[indexPath.row];
}

@end
