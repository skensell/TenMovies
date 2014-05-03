//
//  NSString+Contains.m
//  glPrezi
//
//  Created by Scott Kensell on 2/24/14.
//  Copyright (c) 2014 Prezi. All rights reserved.
//

#import "NSString+Contains.h"

@implementation NSString (Contains)

- (BOOL)containsSubstring:(NSString *)string {
    return ([self rangeOfString:string].location != NSNotFound);
}

@end
