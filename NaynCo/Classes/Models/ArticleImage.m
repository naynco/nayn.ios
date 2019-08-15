//
//  Images.m
//  NaynCo
//
//  Created by Serra Bassarac on 01/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticleImage.h"

@implementation ArticleImage

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"large": @"large",
             @"medium": @"medium",
             @"thumbnail": @"thumbnail"
             };
}

//+(NSValueTransformer *)largeJSONTransformer {
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//}
//
//+(NSValueTransformer *)mediumJSONTransformer {
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//}
//
//+(NSValueTransformer *)thumbnailJSONTransformer {
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//}

@end
