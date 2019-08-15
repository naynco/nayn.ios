//
//  CategoryDataSource.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 4.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "CategoryDataSource.h"
#import "Category+Network.h"

@implementation CategoryDataSource

-(void)downloadAllCategories:(void (^)(NSArray *categories, NSError *error))block {
    [Category getCategoriesWithBlock:^(NSArray<Category *> *categories, NSError *error) {
        NSArray *sortedCategories = [categories sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSNumber *first = [(Category*)obj1 identifier];
            NSNumber *second = [(Category*)obj2 identifier];
            return [first compare:second];
        }];

        if (block != nil) {
            block(sortedCategories, error);
        }
    }];
}

@end
