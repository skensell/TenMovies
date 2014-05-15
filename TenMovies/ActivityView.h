//
//  ActivityView.h
//  
//
//  Created by Scott Kensell on 5/13/14.
//
//

#import <UIKit/UIKit.h>

// Add as a subview to something
// call startAnimating
// call stopAnimating
// remove from superview


@interface ActivityView : UIView


- (instancetype)initWithBackgroundColor:(UIColor *)backgroundcolor
                                  style:(UIActivityIndicatorViewStyle)activityStyle
                                  scale:(CGFloat)scale
                                  color:(UIColor *)tintColor
                            coverScreen:(BOOL)coverScreen
                      isInNavController:(BOOL)isInNavController
                              labelText:(NSString *)text;


- (void)startAnimating;
- (void)stopAnimating;

@end
