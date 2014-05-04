//
//  AppDelegate+Database.h
//  TopRegions
//
//  Created by Scott Kensell on 2/14/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "AppDelegate.h"

// To use this category, call openManagedDocument after app launch.
// It will set the property databaseContext and post a DatabaseAvailabilityNotification on success.

@interface AppDelegate (Database)
- (void)openManagedDocument; // call immediately after app launch
@end