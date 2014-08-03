//
//  MovieCell.m
//
//
//  Created by Scott Kensell on 5/24/14.
//
//

#import "MovieCell.h"
#import "TMDBSignals+Image.h"
#import <RACSignal.h>

@interface MovieCell()
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *rating;
@property (strong, nonatomic) IBOutlet UILabel *runtime;
@property (strong, nonatomic) IBOutlet UILabel *cast;
@property (strong, nonatomic) IBOutlet UILabel *director;
@property (strong, nonatomic) IBOutlet UILabel *year;
@property (strong, nonatomic) IBOutlet UIImageView *poster;

@property (strong, nonatomic, readwrite) Movie *movie;
@property (weak, nonatomic) UITableViewController *delegate;
@end

@implementation MovieCell

- (void)setupWithMovie:(Movie *)movie andDelegate:(UITableViewController *)delegate {
    _movie = movie;
    _delegate = delegate;
    
    [self _setTitle];
    [self _setRating];
    [self _setRuntime];
    [self _setDirector];
    [self _setYear];
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

- (void)_setActors {
    NSArray *actors = [_movie.cast valueForKeyPath:@"name"];
    _cast.text = [[actors subarrayWithRange:NSMakeRange(0, MIN(4, actors.count))] componentsJoinedByString:@"\n"];
}

- (void)_setDirector {
    NSString *director = nil;
    for (NSDictionary *person in _movie.crew) {
        if ([person[@"job"] isEqualToString:@"Director"]) {
            director = person[@"name"];
            break;
        }
    }
    _director.text = director;
}

- (void)_setYear {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy"];
    NSString *releaseYear = [df stringFromDate:_movie.releaseDate];
    _year.text = [NSString stringWithFormat:@"%@", releaseYear];
}

- (void)_setOrDownloadThumbnail {
    if (_movie.thumbnail) {
        _poster.image = [UIImage imageWithData:_movie.thumbnail];
    } else {
        _poster.image = nil;
        if (_movie.posterPath == (id)[NSNull null] || _movie.posterPath.length == 0) {
            // TODO: say no Image available
        } else {
            [[TMDBSignals thumbnailImageForPosterPath:_movie.posterPath] subscribeNext:^(UIImage *image) {
                _movie.thumbnail = UIImageJPEGRepresentation(image, 1.0);
                [_delegate.tableView reloadData];
            }];
        }
    }
}

@end
