//
//  MovieCell.h
//  
//
//  Created by Scott Kensell on 5/24/14.
//
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *cast;
@property (weak, nonatomic) IBOutlet UILabel *genres;
@property (weak, nonatomic) IBOutlet UIButton *trailerButton;

@end
