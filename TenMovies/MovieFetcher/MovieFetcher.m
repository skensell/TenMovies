//
//  MovieFetcher.m
//  TenMovies
//
//  Created by Scott Kensell on 5/3/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "MovieFetcher.h"
#import "MovieFetcherAPIKey.h"

static const NSString *kBaseUrl = @"http://api.themoviedb.org/3/";


@implementation MovieFetcher


+ (NSURL *)URLForDiscovery {
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@", kBaseUrl,
                           @"", @"", @"" ];
    return nil;
}

+ (NSString *)_URLStringFromQuery:(NSString *)query {
    if ([query length] && [query hasPrefix:@"/"]) {
        query = [query substringFromIndex:1];
    }
    
    return [NSString stringWithFormat:@"%@%@%@api_key=%@", kBaseUrl,
            query, @"", TMDB_API_KEY];
}

@end
