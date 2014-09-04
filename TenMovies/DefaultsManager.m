//
//  DefaultsManager.m
//  TenMovies
//
//  Created by Scott Kensell on 6/11/14.
//  Copyright (c) 2014 Scott Kensell. All rights reserved.
//

#import "DefaultsManager.h"

#import "TMDBDiscoverMovieQueryParameters.h"

static NSString *kDiscoverMovieQueryParamsKey = @"DiscoverMovieQueryParamsKey";
static NSString *kAllowsWWANKey = @"AllowsWWANKey";

@implementation DefaultsManager

+ (TMDBDiscoverMovieQueryParameters *)discoverMovieQueryParameters {
    NSDictionary *paramsAsDict = [[NSUserDefaults standardUserDefaults] objectForKey:kDiscoverMovieQueryParamsKey];
    
    return [[TMDBDiscoverMovieQueryParameters alloc] initWithDictionary:paramsAsDict];
}

+ (void)setDiscoverMovieQueryParameters:(TMDBDiscoverMovieQueryParameters *)params {
    [[NSUserDefaults standardUserDefaults] setObject:[params asDictionary] forKey:kDiscoverMovieQueryParamsKey];
}

+ (BOOL)allowsWWAN {
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:kAllowsWWANKey];
    
    return [number boolValue];
}

+ (void)setAllowsWWAN:(BOOL)allowsWWAN {
    [[NSUserDefaults standardUserDefaults] setObject:@(allowsWWAN)
                                              forKey:kAllowsWWANKey];
}

@end
