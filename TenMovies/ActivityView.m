//
//  ActivityView.m
//  
//
//  Created by Scott Kensell on 5/13/14.
//
//

#import "ActivityView.h"

static const float kDefaultLabelFontSize = 16.0f;
static const int kNavBarVerticalOffset = -64.0f;
static const float kVerticalPaddingBetweenLabelAndIndicator = 8.0f;

@interface ActivityView()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation ActivityView {
    UIColor *_tableViewSeparatorColor;
    UILabel *_label;
    BOOL _coverScreen;
    BOOL _isInNavController;
}

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor style:(UIActivityIndicatorViewStyle)activityStyle scale:(CGFloat)scale color:(UIColor *)color coverScreen:(BOOL)coverScreen isInNavController:(BOOL)isInNavController labelText:(NSString *)text{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = backgroundColor;
        _coverScreen = coverScreen;
        _isInNavController = isInNavController;
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
        if (_isInNavController && _coverScreen) {
            transform = CGAffineTransformConcat(transform, CGAffineTransformMakeTranslation(0, kNavBarVerticalOffset));
        }
        
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:activityStyle];
        _activityIndicator.color = color;
        _activityIndicator.hidesWhenStopped = YES;
        _activityIndicator.transform = transform;
        
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.text = text;
        _label.font = [_label.font fontWithSize:kDefaultLabelFontSize];
        CGSize labelSize = [text sizeWithAttributes:@{NSFontAttributeName:_label.font}];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
        _label.textColor = color;
        _label.transform = transform;
        
        [self addSubview:_label];
        [self addSubview:_activityIndicator];
    }
    return self;
}

- (void)startAnimating {
    if (self.superview) {
        [self _hideTableViewLinesIfNeeded];
        self.hidden = NO;
        [self _setGeometryBasedOnSuperview];
        [_activityIndicator startAnimating];
    }
}

- (void)stopAnimating {
    [self _showTableViewLinesIfNeeded];
    [_activityIndicator stopAnimating];
    self.hidden = YES;
}

- (void)hideSpinner {
    [_activityIndicator stopAnimating];
}

- (void)changeMessage:(NSString *)message {
    _label.text = message;
    [self setNeedsDisplay];
}

- (void)showOnlyMessage:(NSString *)message {
    if (self.superview) {
        [self _hideTableViewLinesIfNeeded];
        self.hidden = NO;
        [self _setGeometryBasedOnSuperview];
        [_activityIndicator stopAnimating];
        [self changeMessage:message];
    }
}

#pragma mark - Private

- (void)_setGeometryBasedOnSuperview {
    self.frame = (_coverScreen) ? [UIScreen mainScreen].bounds : self.superview.frame;
    _activityIndicator.center = self.center;
    _label.center = CGPointMake(self.center.x, self.center.y + _activityIndicator.frame.size.height/2 + _label.frame.size.height/2 + kVerticalPaddingBetweenLabelAndIndicator);
}

- (void)_hideTableViewLinesIfNeeded {
    if ([self.superview isKindOfClass:[UITableView class]]) {
        UITableView *tv = (UITableView *)self.superview;
        _tableViewSeparatorColor = tv.separatorColor;
        tv.separatorColor = [UIColor clearColor];
    }
}

- (void)_showTableViewLinesIfNeeded {
    if ([self.superview isKindOfClass:[UITableView class]]) {
        ((UITableView *)self.superview).separatorColor = _tableViewSeparatorColor;
    }
}

@end
