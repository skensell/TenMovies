//
//  UINavControllerNoRotate.m
//  TenMovies
//
//  Created by Scott Kensell on 8/3/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "UINavControllerNoRotate.h"

@implementation UINavControllerNoRotate

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
