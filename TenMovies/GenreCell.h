//
//  GenreCell.h
//  TenMovies
//
//  Created by Scott Kensell on 6/13/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMDBGenre;

static NSString *kAllGenresString = @"All";

@protocol SwitchGenreDelegate <NSObject>
- (void)genre:(TMDBGenre *)genre shouldBeIncluded:(BOOL)shouldBeIncluded;
- (void)toggleAllGenres:(BOOL)includeAll;
@end

@interface GenreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *onSwitch;
@property (weak, nonatomic) id<SwitchGenreDelegate> delegate;

@end
