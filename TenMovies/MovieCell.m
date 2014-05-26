//
//  MovieCell.m
//
//
//  Created by Scott Kensell on 5/24/14.
//
//

#import "MovieCell.h"
#import "TMDB+Image.h"
#import <RACSignal.h>

@interface MovieCell()
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *rating;
@property (strong, nonatomic) IBOutlet UILabel *runtime;
@property (strong, nonatomic) IBOutlet UILabel *genres;
@property (strong, nonatomic) IBOutlet UILabel *cast;
@property (strong, nonatomic) IBOutlet UIImageView *poster;

@property (strong, nonatomic) Movie *movie;
@property (weak, nonatomic) UITableViewController<MovieCellDelegate> *delegate;
@end

@implementation MovieCell

- (void)setupWithMovie:(Movie *)movie andDelegate:(UITableViewController<MovieCellDelegate> *)delegate {
    _movie = movie;
    _delegate = delegate;
    
    [self _setTitle];
    [self _setRating];
    [self _setRuntime];
    [self _setGenres];
    [self _setActors];
    
    [self _setOrDownloadThumbnail];
}


- (void)_setTitle {
    _title.text = _movie.title;
}

- (void)_setRating {
    int avgTimesTen = (int)([_movie.voteAverage floatValue] * 10);
    int base = avgTimesTen / 10;
    int decimal = avgTimesTen % 10;
    _rating.text = [NSString stringWithFormat:@"%d.%d",base,decimal];
}

- (void)_setRuntime {
    _runtime.text = [NSString stringWithFormat:@"%@m", _movie.runtime];
}

- (void)_setGenres {
    NSArray *genres = [_movie.genres valueForKeyPath:@"name"];
    _genres.text = [[genres subarrayWithRange:NSMakeRange(0, MIN(1, genres.count))] componentsJoinedByString:@", "];
}

- (void)_setActors {
    NSArray *actors = [_movie.cast valueForKeyPath:@"name"];
    _cast.text = [[actors subarrayWithRange:NSMakeRange(0, MIN(4, actors.count))] componentsJoinedByString:@"\n"];
}

- (void)_setOrDownloadThumbnail {
    if (_movie.thumbnail) {
        _poster.image = [UIImage imageWithData:_movie.thumbnail];
    } else {
        [[TMDB thumbnailImageForPosterPath:_movie.posterPath] subscribeNext:^(UIImage *image) {
            _movie.thumbnail = UIImageJPEGRepresentation(image, 1.0);
            [_delegate.tableView reloadData];
        }];
    }
}

#pragma mark - Target-Action

- (IBAction)tapInfoForMovie:(id)sender {
    [_delegate didTapInfoForMovie:self.movie];
}

- (IBAction)tapViewTrailerForMovie:(id)sender {
    [_delegate didTapViewTrailerForMovie:self.movie];
}

@end
