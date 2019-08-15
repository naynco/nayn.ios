//
//  NSString+Encoding.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 3.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "NSString+Encoding.h"

@implementation NSString (Encoding)

- (nullable NSString *)stringByAddingPercentEncodingForRFC3986 {
    NSString *unreserved = @"-._~/?";
    NSMutableCharacterSet *allowed = [NSMutableCharacterSet
                                      alphanumericCharacterSet];
    [allowed addCharactersInString:unreserved];
    return [self
            stringByAddingPercentEncodingWithAllowedCharacters:
            allowed];
}

@end
