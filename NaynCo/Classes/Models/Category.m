//
//  Category.m
//  NaynCo
//
//  Created by Serra Bassarac on 03/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "Category.h"

@implementation Category

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"identifier" : @"id",
             @"name" : @"name",
             @"gradientStartColor" : @"color_code_start",
             @"gradientEndColor" : @"color_code_end"
             };
}

@end
