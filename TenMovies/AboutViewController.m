//
//  AboutViewController.m
//  TenMovies
//
//  Created by Scott Kensell on 8/3/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "AboutViewController.h"

#import "Logging.h"

@interface AboutViewController ()
@property (nonatomic) BOOL dismissedAlready;
@end

@implementation AboutViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *attrDic = @{NSFontAttributeName : [UIFont fontWithName:@"MarkerFelt-Wide"
                                                                    size:40]};
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"Ten Movies"
                                                               attributes:attrDic];
    self.titleLabel.attributedText = text;
    
    UIPinchGestureRecognizer *pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(dismissSelf:)];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf:)];
    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf:)];
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf:)];
    UIRotationGestureRecognizer *rotationGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf:)];
    
    [self.view addGestureRecognizer:tapGR];
    [self.view addGestureRecognizer:pinchGR];
    [self.view addGestureRecognizer:swipeGR];
    [self.view addGestureRecognizer:panGR];
    [self.view addGestureRecognizer:rotationGR];
    self.dismissedAlready = NO;
}


- (void)dismissSelf:(UIGestureRecognizer *)gr {
    if (!self.dismissedAlready) {
        self.dismissedAlready = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
