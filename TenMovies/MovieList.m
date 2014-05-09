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
#import "MovieFetcher.h"

static NSString *kTableViewCellIdentifier = @"";

// TODO put this in a separate class

@interface Movie : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSNumber * rating;
@property (nonatomic, strong) NSString * genre;
@property (nonatomic, strong) NSString * cast;
@property (nonatomic, strong) NSString * thumbnailURL;
@property (nonatomic, strong) NSData * thumbnail;
@property (nonatomic, strong) NSString * summary;
@property (nonatomic, strong) NSString * crew;
@property (nonatomic, strong) NSNumber * duration;
@property (nonatomic, strong) NSString * youtubeID;
@end

@implementation Movie

@end


@interface MovieList()

@property (nonatomic,strong) NSArray *moviesByRating OF_TYPE(Movie);

@end

@implementation MovieList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchMovies];
}

- (void)fetchMovies {
    [[HTTPClient sharedClient] GET:[MovieFetcher URLForGenre:TMDB_GENRE_ACTION] parameters:nil
                           success:^(NSURLSessionDataTask *task, id responseObject) {
                               
                               NSDictionary *results = (NSDictionary *)responseObject;
                               [self populateMoviesByRating:results];
                               [self.tableView reloadData];

                           } failure:^(NSURLSessionDataTask *task, NSError *error) {
                               ERROR(@"Failed request");
                           }];
}

- (void)populateMoviesByRating:(NSDictionary *)results {
    
}

#pragma mark - TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    return cell;
}


@end
