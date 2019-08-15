//
//  Article.h
//  NaynCo
//
//  Created by Serra Bassarac on 01/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <Mantle/Mantle.h>

@class ArticleImage, Category;

@interface Article : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *identifier;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readonly) NSDate *updatedAt;
@property (nonatomic, copy, readonly) NSURL *shareURL;
@property (nonatomic, copy, readonly) ArticleImage *images;
@property (nonatomic, copy, readonly) NSArray<Category *> *categories;


@end
