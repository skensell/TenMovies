//
//  AppDelegate.m
//  TenMovies
//
//  Created by Scott Kensell on 5/3/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "AppDelegate_Private.h"

#import "Logging.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self openManagedDocument];
    return YES;
}

@end
