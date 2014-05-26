//
//  TrailerViewController.m
//  TenMovies
//
//  Created by Scott Kensell on 5/26/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TrailerViewController.h"

@interface TrailerViewController ()

@end

@implementation TrailerViewController

-(void)viewDidLoad {
    if (self.youTubeID) {
        [self.player loadWithVideoId:self.youTubeID];
    } else {
        // do not enable the segue (use gray color for play button to show it's disabled)
    }
}

@end
