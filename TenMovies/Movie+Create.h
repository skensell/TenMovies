//
//  Movie+Create.h
//  TenMovies
//
//  Created by Scott Kensell on 5/4/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "Movie.h"

@interface Movie (Create)

+ (Movie *)movieFromTMDBInfo:(NSDictionary *)movieDictionary
      inManagedObjectContext:(NSManagedObjectContext *)context;

//+ (void)deleteMovies:(NSArray *)movies;

@end
