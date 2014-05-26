//
//  MovieList.m
//  TenMovies
//
//  Created by Scott Kensell on 5/9/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "MovieList.h"

#import <ReactiveCocoa.h>

#import "ActivityView.h"
#import "CoreHTTPClient.h"
#import "Logging.h"
#import "Movie+TMDB.h"
#import "MovieCell.h"
#import "TMDB+Movie.h"
#import "TMDB+Image.h"

static NSString *kMovieCellIdentifier = @"MovieCell";

@interface MovieList()<MovieCellDelegate>
@property (nonatomic, strong) ActivityView *activityView;
@property (nonatomic,strong) NSArray *movies OF_TYPE(Movie);
@end

@implementation MovieList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _downloadMoviesForGenre:TMDB_GENRE_ADVENTURE];
}

- (void)_downloadMoviesForGenre:(TMDBMovieGenre_t)genre {
    [self.activityView startAnimating];
    
    [[TMDB movieIDsFromGenre:genre] subscribeNext:^(NSArray *movieIDs) {
        [[TMDB movieDictsFromMovieIDs:movieIDs] subscribeNext:^(RACTuple *movieDicts) {
            self.movies = [Movie moviesFromTMDBResults:[movieDicts allObjects]];
        }];
    }];
}

- (ActivityView *)activityView {
    if (!_activityView) {
        _activityView = [[ActivityView alloc] initWithBackgroundColor:[UIColor whiteColor]
                                                                style:UIActivityIndicatorViewStyleGray
                                                                scale:2.0f
                                                                color:[UIColor blackColor]
                                                          coverScreen:YES
                                                    isInNavController:YES
                                                            labelText:@"Downloading movies..."];
        [self.tableView addSubview:_activityView];
    }
    return _activityView;
}

- (void)setMovies:(NSArray *)movies {
    _movies = movies;
    [self.activityView stopAnimating];
    [self.tableView reloadData];
}

#pragma mark - TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:kMovieCellIdentifier];
    Movie *movie = [self _movieAtIndexPath:indexPath];
    [cell setupWithMovie:movie andDelegate:self];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? self.movies.count : 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - MovieCell delegate

- (void)didTapViewTrailerForMovie:(Movie *)movie {
    DEBUG(@"tapped view trailer.");
}

- (void)didTapInfoForMovie:(Movie *)movie {
    DEBUG(@"tapped view info.");
}



#pragma mark - Private

- (Movie *)_movieAtIndexPath:(NSIndexPath *)indexPath {
    return self.movies[indexPath.row];
}

@end
