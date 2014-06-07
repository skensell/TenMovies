//
//  MovieCell.h
//  
//
//  Created by Scott Kensell on 5/24/14.
//
//

#import <UIKit/UIKit.h>
#import "Movie.h"


@interface MovieCell : UITableViewCell

- (void)setupWithMovie:(Movie *)movie andDelegate:(UITableViewController *)delegate;

@property (strong, nonatomic, readonly) Movie *movie;

@end
