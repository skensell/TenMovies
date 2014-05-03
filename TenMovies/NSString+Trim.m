//
//  NSString+Trim.m
//  glPrezi
//
//  Created by Belényesi Viktor on 2013.02.20..
//  Copyright (c) 2013 Prezi. All rights reserved.
//

#import "NSString+Trim.h"

#define ILLEGAL_CHARACTER @"\u0060\u00b4\u2018\u2019\u201c\u201d"

@implementation NSString (Trim)

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isNotEmpty {
    return [self trim].length > 0;
}

- (BOOL)isReallyEmpty {
    return [self trim].length == 0;
}

- (NSString *)stringByRemovingAllWhitespaces {
    NSArray* components = [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [components componentsJoinedByString:@""];
}

- (NSString *)stringByRemovingUnsupportedCharacters {
    NSCharacterSet *cs = [NSCharacterSet characterSetWithCharactersInString:ILLEGAL_CHARACTER];
    NSArray *components = [self componentsSeparatedByCharactersInSet:cs];
    return [components componentsJoinedByString:@""];
}

@end
