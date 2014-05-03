//
//  NSArray+JSON.m
//  glPrezi
//
//  Created by Belényesi Viktor on 2013.10.18..
//  Copyright (c) 2013 Prezi. All rights reserved.
//


#import "NSArray+JSON.h"

#import "Logging.h"
#import "TextHelper.h"


@implementation NSArray (JSON)

- (NSData *)JSONData {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        DEBUG(@"ERROR: JSON PARSER error: %@", error);
        return nil;
    }
    return jsonData;
}

- (NSString *)JSONString {
    return [TextHelper fromData:[self JSONData]];
}
@end
