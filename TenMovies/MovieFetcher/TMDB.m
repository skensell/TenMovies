//
//  TMDB.m
//  TenMovies
//
//  Created by Scott Kensell on 5/3/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "TMDB.h"

#import "TMDBAPIKey.h"
#import "NSString+Contains.h"

static NSString *kBaseUrl = @"http://api.themoviedb.org/3/";

static NSString *kDiscoveryQuery = @"discover/movie";
static NSString *kGenreQuery = @"genre/%d/movies";
static NSString *kGenreListQuery = @"genre/list";
static NSString *kMovieQuery = @"movie/%@";
static NSString *kMovieQuerySuffix = @"&append_to_response=images,credits,videos&include_image_language=en,null";


@implementation TMDB

+ (NSString *)URLForGenre:(TMDBMovieGenre_t)genre {
    return [self _URLStringFromQuery:[NSString stringWithFormat:kGenreQuery, genre]];
}

+ (NSString *)URLForGenreList {
    return [self _URLStringFromQuery:kGenreListQuery];
}

+ (NSString *)URLForDiscovery {
    return [self _URLStringFromQuery:kDiscoveryQuery];
}

+ (NSString *)URLForMovie:(NSNumber *)movieID {
    NSString *queryString = [NSString stringWithFormat:kMovieQuery, movieID];
    return [self _URLStringFromQuery:queryString appendSuffix:nil];
}


#pragma mark - Private

+ (NSString *)_URLStringFromQuery:(NSString *)query {
    return [self _URLStringFromQuery:query appendSuffix:nil];
}

+ (NSString *)_URLStringFromQuery:(NSString *)query appendSuffix:(NSString *)_suffix {
    if ([query length] && [query hasPrefix:@"/"]) query = [query substringFromIndex:1];
    
    NSString *separator = [query containsSubstring:@"?"] ? @"&" : @"?";
    NSString *suffix = _suffix ? _suffix : @"" ;
    
    NSString *nonEscaped = [NSString stringWithFormat:@"%@%@%@api_key=%@%@", kBaseUrl, query, separator, TMDB_API_KEY, suffix];
    return [nonEscaped stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSURL *)_URLFromQuery:(NSString *)query {
    NSString *asString = [self _URLStringFromQuery:query];
    return [NSURL URLWithString:asString];
}

@end
