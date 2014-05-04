//
//  Movie.h
//  TenMovies
//
//  Created by Scott Kensell on 5/4/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Movie : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * genre;
@property (nonatomic, retain) NSString * cast;
@property (nonatomic, retain) NSString * thumbnailURL;
@property (nonatomic, retain) NSData * thumbnail;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * crew;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSString * youtubeID;

@end
