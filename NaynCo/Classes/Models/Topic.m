//
//  Topic.m
//  NaynCo
//
//  Created by Serra Bassarac on 15/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "Topic.h"
#import "Article.h"

@implementation Topic

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"title": @"title",
             @"imageURL": @"imageURL",
             @"topicDescription": @"description",
             @"articles": @"articles"
             };
}

+(NSValueTransformer *)imageJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+(NSValueTransformer *)articlesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:Article.class];
}

@end
