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
#import "HTTPClient.h"
#import "Logging.h"
#import "Movie+TMDB.h"
#import "TMDB+Movie.h"
#import "TMDB+Image.h"

static NSString *kTableViewCellIdentifier = @"MovieCell";
static CGFloat kMovieCellHeight = 200.0f;

@interface MovieList()
@property (nonatomic,strong) NSArray *movies OF_TYPE(Movie);
@end

@implementation MovieList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _downloadMoviesForGenre:TMDB_GENRE_ACTION];
}

- (void)_downloadMoviesForGenre:(TMDBMovieGenre_t)genre {
    ActivityView *activityView = [[ActivityView alloc] initWithBackgroundColor:[UIColor whiteColor]
                                                                         style:UIActivityIndicatorViewStyleGray
                                                                         scale:2.0f
                                                                         color:[UIColor blackColor]
                                                                   coverScreen:YES
                                                             isInNavController:YES
                                                                     labelText:@"Downloading movies..."];
    [self.tableView addSubview:activityView];
    [activityView startAnimating];
    
    [[TMDB movieIDsFromGenre:genre] subscribeNext:^(NSArray *movieIDs) {
        [[TMDB movieDictsFromMovieIDs:movieIDs] subscribeNext:^(RACTuple *movieDicts) {
            self.movies = [Movie moviesFromTMDBResults:[movieDicts allObjects]];
            [activityView stopAnimating];
            [self.tableView reloadData];
        }];
    }];
}

#pragma mark - TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier];
    Movie *movie = [self movieAtIndexPath:indexPath];
    cell.textLabel.text = movie.title;
//    cell.detailTextLabel.numberOfLines = 0;
//    cell.detailTextLabel.text = [movie.voteAverage description];
    if (movie.thumbnail) {
        cell.imageView.image = [UIImage imageWithData:movie.thumbnail];
    } else {
        [[TMDB thumbnailImageForPosterPath:movie.posterPath] subscribeNext:^(UIImage *image) {
            movie.thumbnail = UIImageJPEGRepresentation(image, 1.0);
            [tableView reloadData];
        }];
    }
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
