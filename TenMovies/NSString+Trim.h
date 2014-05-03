//
//  NSString+Trim.h
//  glPrezi
//
//  Created by Belényesi Viktor on 2013.02.20..
//  Copyright (c) 2013 Prezi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Trim)

- (NSString *)trim;
- (BOOL)isNotEmpty;
- (BOOL)isReallyEmpty;
- (NSString *)stringByRemovingAllWhitespaces;
- (NSString *)stringByRemovingUnsupportedCharacters;

@end
