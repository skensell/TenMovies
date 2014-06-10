//
//  TMDB+Image.h
//  TenMovies
//
//  Created by Scott Kensell on 5/12/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDBSignals.h"

@interface TMDBSignals (Image)

+ (RACSignal *OF_TYPE(UIImage *))thumbnailImageForPosterPath:(NSString *)posterPath;

@end
