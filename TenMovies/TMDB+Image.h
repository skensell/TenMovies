//
//  TMDB+Image.h
//  TenMovies
//
//  Created by Scott Kensell on 5/12/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDB.h"

@class RACSignal;

@interface TMDB (Image)

+ (RACSignal *)thumbnailImageForPosterPath:(NSString *)posterPath;

@end
