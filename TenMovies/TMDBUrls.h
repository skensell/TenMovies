//
//  TMDBUrls.h
//  
//
//  Created by Scott Kensell on 6/10/14.
//
//

#import <Foundation/Foundation.h>

#import "TMDBMovieGenreTypes.h"
#import "TMDBDiscoverMovieQueryParameters.h"
#import "TMDBKeyPaths.h"

@interface TMDBUrls : NSObject

+ (NSString *)URLForConfiguration;
+ (NSString *)URLForGenre:(TMDBMovieGenre_t)genre;
+ (NSString *)URLForGenreList;
+ (NSString *)URLForDiscovery;
+ (NSString *)URLForMovie:(NSNumber *)movieID;
+ (NSString *)URLForDiscoveryFromMovieQueryParameters:(TMDBDiscoverMovieQueryParameters *)params;

@end
