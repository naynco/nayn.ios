//
//  Category+Network.h
//  NaynCo
//
//  Created by Serra Bassarac on 09/05/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "Category.h"

@interface Category (Network)

+(void)getCategoriesWithBlock:(void (^)(NSArray *categories, NSError *error))block;


@end
