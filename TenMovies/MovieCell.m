//
//  MovieCell.m
//  
//
//  Created by Scott Kensell on 5/24/14.
//
//

#import "MovieCell.h"

@interface MovieCell()
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *rating;
@property (strong, nonatomic) IBOutlet UILabel *runtime;
@property (strong, nonatomic) IBOutlet UILabel *genres;
@property (strong, nonatomic) IBOutlet UILabel *cast;

@property (strong, nonatomic) IBOutlet UIButton *trailerButton;
@end

@implementation MovieCell

- (void)setMovie:(Movie *)movie {
    _movie = movie;
    _title.text = _movie.title;
    
    int avgTimesTen = (int)([_movie.voteAverage floatValue] * 10);
    int base = avgTimesTen / 10;
    int decimal = avgTimesTen % 10;
    _rating.text = [NSString stringWithFormat:@"%d.%d",base,decimal];
    
    _runtime.text = [NSString stringWithFormat:@"%@m", _movie.runtime];
    
    NSArray *genres = [_movie.genres valueForKeyPath:@"name"];
    _genres.text = [[genres subarrayWithRange:NSMakeRange(0, MIN(1, genres.count))] componentsJoinedByString:@", "];
    
    NSArray *actors = [_movie.cast valueForKeyPath:@"name"];
    _cast.text = [[actors subarrayWithRange:NSMakeRange(0, MIN(4, actors.count))] componentsJoinedByString:@"\n"];
}


@end
