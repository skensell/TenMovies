//
//  AppDelegate_Private.h
//  TenMovies
//
//  Created by Scott Kensell on 5/4/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Database.h"

@interface AppDelegate()

//  Database
@property (strong, nonatomic) NSManagedObjectContext *databaseContext;

@end
