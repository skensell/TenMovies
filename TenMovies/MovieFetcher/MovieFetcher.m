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


+ (NSURL *)URLForDiscovery {
    return [self _URLFromQuery:kDiscoveryQuery];
}

#pragma mark - Private

+ (NSURL *)_URLFromQuery:(NSString *)query {
    if ([query length] && [query hasPrefix:@"/"]) {
        query = [query substringFromIndex:1];
    }
    NSString *separator = @"?";
    if ([query containsSubstring:@"?"]) {
        separator = @"&";
    }
    NSString *nonEscaped = [NSString stringWithFormat:@"%@%@%@api_key=%@", kBaseUrl, query, separator, TMDB_API_KEY];
    NSString *escaped = [nonEscaped stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:escaped];
}

@end
