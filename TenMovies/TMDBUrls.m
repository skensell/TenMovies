//
//  TMDBUrls.m
//  
//
//  Created by Scott Kensell on 6/10/14.
//
//

#import "TMDBUrls.h"

#import "TMDBAPIKey.h"
#import "NSString+Contains.h"

static NSString *kBaseUrl = @"http://api.themoviedb.org/3/";

static NSString *kConfigurationQuery = @"configuration";
static NSString *kDiscoveryQuery = @"discover/movie";
static NSString *kGenreQuery = @"genre/%d/movies";
static NSString *kGenreListQuery = @"genre/list";
static NSString *kMovieQuery = @"movie/%@";
static NSString *kMovieQuerySuffix = @"&append_to_response=images,credits,videos&include_image_language=en,null";


@implementation TMDBUrls

+ (NSString *)URLForConfiguration {
    return [self _URLStringFromQuery:kConfigurationQuery];
}

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
    return [self _URLStringFromQuery:queryString appendSuffix:kMovieQuerySuffix];
}

+ (NSString *)URLForDiscoveryFromMovieQueryParameters:(TMDBDiscoverMovieQueryParameters *)params {
    NSString *sortBy = [TMDBDiscoverMovieQueryParameters sortByTypeAsString:params.sortByType];
    NSString *genreString = [params genreQueryString];
    NSString *suffix = [NSString stringWithFormat:@"&with_genres=%@&sort_by=%@&release_date.gte=%d-01-01&release_date.lte=%d-12-31",genreString, sortBy, params.fromYear, params.toYear];
    return [self _URLStringFromQuery:kDiscoveryQuery appendSuffix:suffix];
    
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
