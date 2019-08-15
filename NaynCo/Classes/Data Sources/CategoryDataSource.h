//
//  CategoryDataSource.h
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 4.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryDataSource : NSObject

-(void)downloadAllCategories:(void (^)(NSArray *categories, NSError *error))block;

@end

NS_ASSUME_NONNULL_END
