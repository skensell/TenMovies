//
//  TextHelper.h
//  glPrezi
//
//  Created by Belényesi Viktor on 3/30/12.
//  Copyright (c) 2012 Prezi. All rights reserved.
//

#define _APPEND_FORMAT(x,y, ...) x = [NSString stringWithFormat:@"%@%@", x, [NSString stringWithFormat:y, __VA_ARGS__]];

@interface TextHelper : NSObject
+ (NSObject *)escape:(NSObject *)input;
+ (NSString *)fromData:(NSData *)data;
+ (NSData *)fromString:(NSString *)string;
+ (NSData *)base64DataFromString:(NSString *)string;
+ (NSString *)decodeURLSafeBase64:(NSString*)safeString;
+ (NSDictionary *)paramsFromString:(NSString *)params;
+ (NSString *)findWordIn:(NSString*)line range:(NSRange)range breaks:(NSCharacterSet*)wordBreakSet;
+ (NSString *)wordWithoutTrailingWhitespace:(NSString*)word;
+ (NSString *)quoteString:(NSString*)toQuote;
@end
