//
//  Movie.h
//  
//
//  Created by Scott Kensell on 5/10/14.
//
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSArray * cast;
@property (nonatomic, strong) NSArray * crew;
@property (nonatomic, strong) NSArray * genres;
@property (nonatomic, strong) NSData * thumbnail;
@property (nonatomic, strong) NSDate * releaseDate;
@property (nonatomic, strong) NSNumber * ID;
@property (nonatomic, strong) NSNumber * runtime;
@property (nonatomic, strong) NSNumber * popularity;
@property (nonatomic, strong) NSNumber * voteAverage;
@property (nonatomic, strong) NSString * posterPath;
@property (nonatomic, strong) NSString * overview;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * youtubeID;

@end
