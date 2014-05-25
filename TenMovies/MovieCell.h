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

@property (strong, nonatomic) IBOutlet UIImageView *poster;

@property (strong, nonatomic) Movie *movie;
@property (weak, nonatomic) id<MovieCellDelegate> delegate;

@end
