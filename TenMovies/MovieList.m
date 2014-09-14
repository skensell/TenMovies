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
#import "DefaultsManager.h"
#import "CoreHTTPClient.h"
#import "Logging.h"
#import "Movie+TMDB.h"
#import "MovieCell.h"
#import "MovieDetail.h"
#import "TMDB.h"
#import "TMDBErrors.h"


static NSString *kMovieCellIdentifier = @"MovieCell";
static NSString *kViewTrailerSegueIdentifier = @"viewTrailerSegue";

@interface MovieList()
@property (nonatomic, strong) ActivityView *activityView;
@property (nonatomic, strong) NSArray *movies OF_TYPE(Movie);
@property (nonatomic, strong) TMDBDiscoverMovieQueryParameters *params;
@property (nonatomic) BOOL isDownloadingMore;
@property (nonatomic) BOOL noMoreMovies;
@end

@implementation MovieList

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if (!self.movies) {
                    [self _downloadMoviesForDiscoveryWithParams:self.params];
                } else {
                    [self.activityView stopAnimating];
                }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusUnknown:
            default:
                [self.activityView showOnlyMessage:@"No connection :("];
                break;
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.noMoreMovies = NO;
    
    TMDBDiscoverMovieQueryParameters *params = [DefaultsManager discoverMovieQueryParameters];
    BOOL hasCustomized = [params isEqual:self.params] == NO;
    
    if (hasCustomized) {
        self.params = params;
        self.movies = nil;
        [self.tableView reloadData];
        [self _downloadMoviesForDiscoveryWithParams:params];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [DefaultsManager setDiscoverMovieQueryParameters:self.params];
}

- (void)_downloadMoviesForDiscoveryWithParams:(TMDBDiscoverMovieQueryParameters *)params {
    if ([AFNetworkReachabilityManager sharedManager].reachableViaWWAN &&
        [DefaultsManager allowsWWAN] == NO) {
        UIAlertView *noWifiAlert = [[UIAlertView alloc] initWithTitle:@"No wifi"
                                                             message:@"To give you great movie suggestions, Ten Movies needs to use the internet. Is it okay if we use 3G?"
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:@"No", nil];
        [noWifiAlert show];
        return;
    }
    
    [self.activityView startAnimating];
    [self.activityView changeMessage:@"Finding movies..."];
    
    [[TMDBSignals movieIDsFromDiscoverQueryParameters:params] subscribeNext:^(NSArray *movieIDs) {
        [[TMDBSignals movieDictsFromMovieIDs:movieIDs] subscribeNext:^(NSArray *movieDicts) {
            self.movies = [Movie moviesFromTMDBResults:movieDicts];
        }];
    } error:^(NSError *error) {
        if ([error.domain isEqualToString:TMDB_ERROR_DOMAIN]) {
            self.movies = nil;
            [self.activityView showOnlyMessage:error.localizedDescription];
        }
    }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [DefaultsManager setAllowsWWAN:YES];
        [self _downloadMoviesForDiscoveryWithParams:self.params];
    } else {
        [self.activityView showOnlyMessage:@"No movies :("];
    }
}

#pragma mark - Properties

- (ActivityView *)activityView {
    if (!_activityView) {
        _activityView = [[ActivityView alloc] initWithBackgroundColor:[UIColor whiteColor]
                                                                style:UIActivityIndicatorViewStyleGray
                                                                scale:1.0f
                                                                color:[UIColor blackColor]
                                                          coverScreen:YES
                                                    isInNavController:YES
                                                            labelText:@"Finding movies..."];
        [self.tableView addSubview:_activityView];
    }
    return _activityView;
}

- (void)setMovies:(NSArray *)movies {
    _movies = movies;
    if (movies != nil) {
        [self.activityView stopAnimating];
        [self.tableView reloadData];
    }
}

- (TMDBDiscoverMovieQueryParameters *)params {
    if (!_params) {
        _params = [DefaultsManager discoverMovieQueryParameters];
    }
    return _params;
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

#pragma mark - Private

- (Movie *)_movieAtIndexPath:(NSIndexPath *)indexPath {
    return self.movies[indexPath.row];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kViewTrailerSegueIdentifier] &&
        [segue.destinationViewController isKindOfClass:[MovieDetail class]] &&
        [sender isKindOfClass:[MovieCell class]]) {
        
        Movie *movie = ((MovieCell *)sender).movie;
        MovieDetail *tvc = (MovieDetail *)segue.destinationViewController;
        tvc.movie = movie;
    }
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = scrollView.contentSize.height;
    CGFloat currentY = scrollView.contentOffset.y + [[UIScreen mainScreen] bounds].size.height;
    if (!self.isDownloadingMore && !self.noMoreMovies && height > 0 && currentY > 0.90 * height) {
        self.isDownloadingMore = YES;
        self.params.page += 1;
        [[TMDBSignals movieIDsFromDiscoverQueryParameters:self.params] subscribeNext:^(NSArray *movieIDs) {
            [[TMDBSignals movieDictsFromMovieIDs:movieIDs] subscribeNext:^(NSArray *movieDicts) {
                NSArray *moreMovies = [Movie moviesFromTMDBResults:movieDicts];
                if ([moreMovies count]) {
                    self.movies = [self.movies arrayByAddingObjectsFromArray:moreMovies];
                }
                self.isDownloadingMore = NO;
            }];
        } error:^(NSError *error) {
            DEBUG(@"Downloading More Movies failed: %@", error.localizedDescription);
            if ([error.domain isEqualToString:TMDB_ERROR_DOMAIN]) {
                if (error.code == TMDB_ERROR_NO_MOVIES) {
                    self.noMoreMovies = YES;
                }
            }
            self.isDownloadingMore = NO;
        }];
        
    }
}


@end
