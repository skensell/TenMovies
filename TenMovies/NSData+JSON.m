//
//  NSData+JSON.m
//  glPrezi
//
//  Created by Belényesi Viktor on 2013.10.18..
//  Copyright (c) 2013 Prezi. All rights reserved.
//


#import "NSData+JSON.h"

#import "Logging.h"


@implementation NSData (JSON)

- (id)objectFromJSONData {
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error) {
        DEBUG(@"ERROR: JSON PARSER error: %@", error);
        return nil;
    }
    return json;
}

@end
