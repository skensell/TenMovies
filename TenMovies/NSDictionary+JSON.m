//
//  NSDictionary+JSON.m
//  glPrezi
//
//  Created by Barsi Matyi on 2013.09.27..
//  Copyright (c) 2013 Prezi. All rights reserved.
//

#import "NSDictionary+JSON.h"

#import "NSData+JSON.h"
#import "TextHelper.h"
#import "Logging.h"

NSString *const kJSONParseException = @"JSONParseException";

@implementation NSDictionary (JSON)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)data {
    NSDictionary *dictionary = [data objectFromJSONData];
    
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
        NSException *exception = [NSException exceptionWithName:kJSONParseException
                                                         reason:@"empty json data"
                                                       userInfo:nil];
        [exception raise];
    }
    
    return dictionary;
}

- (NSArray *)arrayForKey:(NSString *)key {
    return [self valueForKey:key ofTypes:@[[NSArray class]] allowNil:NO];
}

- (NSDictionary *)dictionaryForKey:(NSString *)key {
    return [self valueForKey:key ofTypes:@[[NSDictionary class]] allowNil:NO];
}

- (int)intForKey:(NSString *)key {
    id value = [self valueForKey:key ofTypes:@[[NSNumber class], [NSString class]] allowNil:NO];
    return [value intValue];
}

- (NSString *)stringForKey:(NSString *)key {
    return [self stringForKey:key allowNil:NO];
}

- (NSString *)stringForKey:(NSString *)key allowNil:(BOOL)allowNil {
    return [self valueForKey:key ofTypes:@[[NSString class]] allowNil:allowNil];
}

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

#pragma mark - Private

- (id)valueForKey:(NSString *)key ofTypes:(NSArray *)types allowNil:(BOOL)allowNil {
    NSParameterAssert(key != nil);
    
    id value = [self objectForKey:key];
    
    if (!allowNil && value == nil) {
        NSString *message = [NSString stringWithFormat:@"missing value for key '%@'", key];
        NSException *exception = [NSException exceptionWithName:kJSONParseException
                                                         reason:message
                                                       userInfo:nil];
        [exception raise];
    }
    
    if (allowNil && (value == nil || [value isKindOfClass:[NSNull class]])) {
        return nil;
    }
    
    BOOL isValidType = NO;
    
    for (Class class in types) {
        if ([value isKindOfClass:class]) {
            isValidType = YES;
            break;
        }
    }
    
    if (!isValidType) {
        NSString *message = [NSString stringWithFormat:@"invalid value for key '%@' of type %@ (expected %@)",
                             key, [value class], [types componentsJoinedByString:@" or "]];
        NSException *exception = [NSException exceptionWithName:kJSONParseException
                                                         reason:message
                                                       userInfo:nil];
        [exception raise];
    }
    
    return value;
}

@end
