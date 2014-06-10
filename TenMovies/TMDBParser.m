//
//  TMDBParser.m
//  TenMovies
//
//  Created by Scott Kensell on 6/10/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDBParser.h"

@implementation TMDBParser

+ (NSString *)youTubeTrailerIDFromVideosArray:(NSArray *)videos {
    for (NSDictionary *video in videos) {
        if ([[video[@"type"] lowercaseString] isEqualToString:@"trailer"] &&
            [[video[@"site"] lowercaseString] isEqualToString:@"youtube"]) {
            return video[@"key"];
        }
    }
    return nil;
}

@end
