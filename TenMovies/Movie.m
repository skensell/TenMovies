//
//  Movie.m
//  
//
//  Created by Scott Kensell on 5/10/14.
//
//

#import "Movie.h"

#import "TMDB.h"

@implementation Movie

- (NSString *)description {
    NSArray *props = @[self.releaseDate, self.ID, self.popularity, self.voteAverage, self.posterPath, self.title];
    return [props description];
}

@end
