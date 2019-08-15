//
//  Article.m
//  NaynCo
//
//  Created by Serra Bassarac on 01/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "Article.h"
#import "ArticleImage.h"
#import "Category.h"

@implementation Article

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"identifier": @"id",
             @"title": @"title",
             @"summary": @"summary",
             @"content": @"content",
             @"createdAt": @"createdAt",
             @"updatedAt": @"updatedAt",
             @"images": @"images",
             @"categories": @"categories",
             @"shareURL" : @"url"
             };
}

+(NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return dateFormatter;
}

+(NSValueTransformer *)shareURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+(NSValueTransformer *)categoriesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:Category.class];
}

+(NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] dateFromString:value];
    }];
}

+(NSValueTransformer *)updatedAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] dateFromString:value];
    }];
}
            
+(NSValueTransformer *)imagesJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:ArticleImage.class];
}


@end
