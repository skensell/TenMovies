//
//  TrailerViewController.h
//  TenMovies
//
//  Created by Scott Kensell on 5/26/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YTPlayerView.h>

@interface TrailerViewController : UIViewController
@property (strong, nonatomic) IBOutlet YTPlayerView *player;
@property (strong, nonatomic) NSString *youTubeID;
@end
