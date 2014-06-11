//
//  MovieQueryCustomize.m
//  TenMovies
//
//  Created by Scott Kensell on 6/11/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "MovieQueryCustomize.h"

#import "TMDBDiscoverMovieQueryParameters.h"
#import "DefaultsManager.h"

@interface MovieQueryCustomize ()
@property (nonatomic, strong) TMDBDiscoverMovieQueryParameters *params;
@end

@implementation MovieQueryCustomize

- (TMDBDiscoverMovieQueryParameters *)params {
    if (!_params) {
        _params = [DefaultsManager discoverMovieQueryParameters];
    }
    return _params;
}

- (void)viewWillDisappear:(BOOL)animated {
    [DefaultsManager setDiscoverMovieQueryParameters:self.params];
}

@end
