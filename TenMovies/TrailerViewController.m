//
//  TrailerViewController.m
//  TenMovies
//
//  Created by Scott Kensell on 5/26/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TrailerViewController.h"

#import <YTPlayerView.h>

@interface TrailerViewController ()
@property (strong, nonatomic) IBOutlet YTPlayerView *player;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@end

@implementation TrailerViewController

-(void)viewDidLoad {
    if ([self.movie.youtubeID length]) {
        [self.player loadWithVideoId:self.movie.youtubeID];
    }
    self.title = self.movie.title;
    self.summaryTextView.text = self.movie.overview;
}

@end
