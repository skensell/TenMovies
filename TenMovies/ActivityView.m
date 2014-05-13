//
//  ActivityView.m
//  
//
//  Created by Scott Kensell on 5/13/14.
//
//

#import "ActivityView.h"

@interface ActivityView()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation ActivityView {
    UIColor *_tableViewSeparatorColor;
}

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor activityStyle:(UIActivityIndicatorViewStyle)activityStyle {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = backgroundColor;
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:activityStyle];
        _activityIndicator.hidesWhenStopped = YES;
        [self addSubview:_activityIndicator];
    }
    return self;
}

- (void)startAnimating {
    if (self.superview) {
        if ([self.superview isKindOfClass:[UITableView class]]) {
            UITableView *tv = (UITableView *)self.superview;
            _tableViewSeparatorColor = tv.separatorColor;
            tv.separatorColor = [UIColor clearColor];
        }
        self.frame = self.superview.frame;
        self.hidden = NO;
        _activityIndicator.center = self.center;
        _activityIndicator.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
        [_activityIndicator startAnimating];
    }
}

- (void)stopAnimating {
    if ([self.superview isKindOfClass:[UITableView class]]) {
        ((UITableView *)self.superview).separatorColor = _tableViewSeparatorColor;
    }
    [_activityIndicator stopAnimating];
    self.hidden = YES;
}

@end
