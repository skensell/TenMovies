//
//  NSDictionary+JSON.h
//  glPrezi
//
//  Created by Barsi Matyi on 2013.09.27..
//  Copyright (c) 2013 Prezi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kJSONParseException;

@interface NSDictionary (JSON)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)data;

- (NSArray *)arrayForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key;
- (int)intForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key allowNil:(BOOL)allowNil;
- (NSData *)JSONData;
- (NSString *)JSONString;

@end
