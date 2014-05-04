//
//  MovieFetcher.m
//  TenMovies
//
//  Created by Scott Kensell on 5/3/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "MovieFetcher.h"
#import "MovieFetcherAPIKey.h"
#import "NSString+Contains.h"

static NSString *kBaseUrl = @"http://api.themoviedb.org/3/";
static NSString *kDiscoveryQuery = @"discover/movie";

@implementation MovieFetcher


+ (NSString *)URLForDiscovery {
    return [self _URLStringFromQuery:kDiscoveryQuery];
}

#pragma mark - Private

+ (NSString *)_URLStringFromQuery:(NSString *)query {
    if ([query length] && [query hasPrefix:@"/"]) {
        query = [query substringFromIndex:1];
    }
    NSString *separator = @"?";
    if ([query containsSubstring:@"?"]) {
        separator = @"&";
    }
    NSString *nonEscaped = [NSString stringWithFormat:@"%@%@%@api_key=%@", kBaseUrl, query, separator, TMDB_API_KEY];
    return [nonEscaped stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSURL *)_URLFromQuery:(NSString *)query {
    NSString *asString = [self _URLStringFromQuery:query];
    return [NSURL URLWithString:asString];
}

@end
