//
//  MinVotesCell.h
//  TenMovies
//
//  Created by Scott Kensell on 6/18/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinVotesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberOfVotesLabel;
@property (weak, nonatomic) IBOutlet UIStepper *numberOfVotesStepper;

@end
