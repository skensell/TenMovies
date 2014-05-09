//
//  Movie.h
//  
//
//  Created by Scott Kensell on 5/10/14.
//
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSNumber * popularity;
@property (nonatomic, strong) NSNumber * voteAverage;
@property (nonatomic, strong) NSString * genre;
@property (nonatomic, strong) NSString * cast;
@property (nonatomic, strong) NSString * thumbnailURL;
@property (nonatomic, strong) NSData * thumbnail;
@property (nonatomic, strong) NSString * summary;
@property (nonatomic, strong) NSString * crew;
@property (nonatomic, strong) NSNumber * duration;
@property (nonatomic, strong) NSString * youtubeID;

+ (NSArray *)moviesFromTMDBResults:(NSArray *)results;

@end
