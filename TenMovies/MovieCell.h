//
//  MovieCell.h
//  
//
//  Created by Scott Kensell on 5/24/14.
//
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@protocol MovieCellDelegate <NSObject>
- (void)didTapInfoForMovie:(Movie *)movie;
- (void)didTapViewTrailerForMovie:(Movie *)movie;
@end


@interface MovieCell : UITableViewCell

- (void)setupWithMovie:(Movie *)movie andDelegate:(UITableViewController<MovieCellDelegate> *)delegate;

@end
