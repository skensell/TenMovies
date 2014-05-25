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

@property (strong, nonatomic) IBOutlet UIImageView *poster;

@property (strong, nonatomic) Movie *movie;

@end
