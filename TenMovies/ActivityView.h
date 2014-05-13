//
//  ActivityView.h
//  
//
//  Created by Scott Kensell on 5/13/14.
//
//

#import <UIKit/UIKit.h>

// To use, simply add as a subview
// After startAnimating is called, it will become visible, covering it's parent view and animate
// After stopAnimating it will be hidden


@interface ActivityView : UIView

// TODO: add a label
- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor activityStyle:(UIActivityIndicatorViewStyle)activityStyle;

- (void)startAnimating;
- (void)stopAnimating;

@end
