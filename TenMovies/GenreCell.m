//
//  GenreCell.m
//  TenMovies
//
//  Created by Scott Kensell on 6/13/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "GenreCell.h"

#import "TMDBGenre.h"

@implementation GenreCell

- (IBAction)valueChangedForSwitch:(UISwitch *)sender {
    NSString *genreAsText = self.label.text;
    if ([genreAsText isEqualToString:kAllGenresString]) {
        [self.delegate toggleAllGenres:sender.on];
    } else {
        TMDBGenre *genre = [TMDBGenre genreFromString:genreAsText];
        if (genre) {
            [self.delegate genre:genre shouldBeIncluded:sender.on];
        }
    }
}

@end
