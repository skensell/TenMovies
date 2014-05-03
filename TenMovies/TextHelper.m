//
//  TextHelper.m
//  glPrezi
//
//  Created by Belényesi Viktor on 3/30/12.
//  Copyright (c) 2012 Prezi. All rights reserved.
//

#import "TextHelper.h"
#import "Logging.h"

@implementation TextHelper

static const short _base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
    -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};

+ (NSObject *)escape:(NSObject *)input {
    if (![input isKindOfClass:[NSString class]]) {
        return input; 
    }
    
    NSMutableString *escaped = [NSMutableString stringWithString:(NSString *)input];
    
    NSDictionary *replaceDic = @{
    @"ß": @"%C3%9F",
    @"$" : @"%24",
    @"&" : @"%26",
    @"+" : @"%2B",
    @"," : @"%2C",
    @"/" : @"%2F",
    @":" : @"%3A",
    @";" : @"%3B",
    @"=" : @"%3D",
    @"?" : @"%3F",
    @"@" : @"%40",
    @" " : @"%20",
    @"\t" : @"%09",
    @"#" : @"%23",
    @"<" : @"%3C",
    @">" : @"%3E",
    @"\"" : @"%22",
    @"\n" : @"%0A",
    @"!" : @"%21",
    @"§" : @"%C2%A7",
    @"@" : @"%40",
    @"Ł" : @"%C5%81",
    @"¤" : @"%C2%A4",
    @"^" : @"%5E",
    @"*" : @"%2A",
    @"=" : @"%3D",
    @"\\" : @"%5C",
    @"|" : @"%7C",
    @"€" : @"%E2%82%AC",
    @"£" : @"%C2%A3",
    @"¥" : @"%C2%A5",
    @"[": @"%5B",
    @"]": @"%5D",
    @"{": @"%7B",
    @"}": @"%7D"
    };
    
    [escaped stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [escaped replaceOccurrencesOfString:@"\%" withString:@"%25" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [escaped length])];
    
    for (NSString *key in [replaceDic allKeys]) {
        NSString *value = replaceDic[key];
        [escaped replaceOccurrencesOfString:key withString:value options:NSLiteralSearch range:NSMakeRange(0, [escaped length])];
    }
    
    return escaped;
}

+ (NSString *)fromData:(NSData *)data {
    if (data == nil) {
        return nil;
    }
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

+ (NSData *)fromString:(NSString *)string {
    if (string == nil) {
        return nil;
    }
	return [string dataUsingEncoding:NSUTF8StringEncoding];
}


+ (NSString*)decodeURLSafeBase64:(NSString*)safeString {
    if (safeString == nil) {
        return nil;
    }
    NSMutableString* result = [NSMutableString stringWithString:(NSString *)safeString];
            
    [result replaceOccurrencesOfString:@"-" withString:@"+" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"_" withString:@"/" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    
    return result;
}

+ (NSData *)base64DataFromString:(NSString *)string {
    if (string == nil) {
        return nil;
    }
    const char * objPointer = [string cStringUsingEncoding:NSASCIIStringEncoding];
    int intLength = strlen(objPointer);
    int intCurrent;
    int i = 0, j = 0, k;
    
    char * objResult;
    objResult = calloc(intLength, sizeof(char));
    
    // Run through the whole string, converting as we go
    while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
        if (intCurrent == '=') {
            if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
                // the padding character is invalid at this point -- so this entire string is invalid
                free(objResult);
                return nil;
            }
            continue;
        }
        
        intCurrent = _base64DecodingTable[intCurrent];
        if (intCurrent == -1) {
            // we're at a whitespace -- simply skip over
            continue;
        } else if (intCurrent == -2) {
            // we're at an invalid character
            free(objResult);
            return nil;
        }
        
        switch (i % 4) {
            case 0:
                objResult[j] = intCurrent << 2;
                break;
                
            case 1:
                objResult[j++] |= intCurrent >> 4;
                objResult[j] = (intCurrent & 0x0f) << 4;
                break;
                
            case 2:
                objResult[j++] |= intCurrent >>2;
                objResult[j] = (intCurrent & 0x03) << 6;
                break;
                
            case 3:
                objResult[j++] |= intCurrent;
                break;
        }
        i++;
    }
    
    // mop things up if we ended on a boundary
    k = j;
    if (intCurrent == '=') {
        switch (i % 4) {
            case 1:
                // Invalid state
                free(objResult);
                return nil;
                
            case 2:
                k++;
                // flow through
            case 3:
                objResult[k] = 0;
        }
    }
    
    // Cleanup and setup the return NSData
    NSData * objData = [[NSData alloc] initWithBytes:objResult length:j];
    free(objResult);
    return objData;
}

+ (NSDictionary *)paramsFromString:(NSString *)params {
    if (params == nil || [params length] == 0) {
        return nil;
    }
    NSMutableDictionary *paramsDic = [NSMutableDictionary new];
    NSArray *pairs = [params componentsSeparatedByString:@"&"];
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        if (elements.count > 1) {
            NSString *key = [elements[0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *val = [elements[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            if ([val length]) {
                [paramsDic setObject:val forKey:key];
            }            
        }
    }
    NSDictionary *result = [NSDictionary dictionaryWithDictionary:paramsDic];
    return result;
}

+ (NSString *)findWordIn:(NSString*)line range:(NSRange)range breaks:(NSCharacterSet*)wordBreakSet {
    if (line == nil || line.length == 0) {
        return nil;
    }
    if (range.location > line.length - 1) {
        DEBUG(@"ERROR: Bad range");
        return nil;
    }
    if (wordBreakSet == nil) {
        DEBUG(@"ERROR: Missing wordBreakSet");
        return nil;
    }
    
    range.length = MIN(range.length, line.length - range.location);
    
    NSRange rangeOfWord,
            rangeOfWordBreak = [line rangeOfCharacterFromSet:wordBreakSet options:NSLiteralSearch range:range];

    if (rangeOfWordBreak.location == NSNotFound)
        rangeOfWord = range;
    else {
        rangeOfWord = NSMakeRange(range.location, rangeOfWordBreak.location - range.location + 1);
    }

    return [line substringWithRange:rangeOfWord];
}

+ (NSString *)wordWithoutTrailingWhitespace:(NSString*)word {
    if (word == nil || word.length == 0) {
        return nil;
    }
    NSRange lastWhiteSpaceRange = [word rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];

    BOOL lastCharIsWhitespace = lastWhiteSpaceRange.location == [word length] - 1;

    if (lastCharIsWhitespace) {
        return [word substringWithRange:NSMakeRange(0, [word length] - 1)];
    } else {
        return word;
    }
}

+ (NSString *)quoteString:(NSString*)toQuote {
    if (toQuote == nil || toQuote.length == 0) {
        return nil;
    }
    NSMutableString *escaped = [[NSMutableString alloc] initWithString:toQuote];
    NSArray *controlChars = [NSArray arrayWithObjects:@"\t", @"\n", @"\r", @"\"", nil]; //not expecting @"\0", @"\a", @"\b", @"\f", @"\e"
    NSArray *escapedChars = [NSArray arrayWithObjects:@"\\t", @"\\n", @"\\r", @"\\\"", nil];
    for (int i = 0; i < [controlChars count]; i++) {
        [escaped replaceOccurrencesOfString:[controlChars objectAtIndex:i]
								 withString:[escapedChars objectAtIndex:i]
									options:0
									  range:NSMakeRange(0, [escaped length])];
    }
    NSString *result = [NSString stringWithFormat:@"\"%@\"", escaped];
    return result;
}

@end
