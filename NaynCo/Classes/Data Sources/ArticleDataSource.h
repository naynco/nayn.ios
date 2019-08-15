//
//  ArticleDataSource.h
//  NaynCo
//
//  Created by Serra Bassarac on 03/04/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article, Category;

typedef enum : NSUInteger {
    CategoryTypeSports = 1,
    CategoryTypeHot = 2,
    CategoryTypeWorld = 3,
    CategoryTypeRecent = 4,
    CategoryTypeSocial = 5,
    CategoryTypeArt = 6
} CategoryType;

@interface ArticleDataSource : NSObject

@property (nonatomic) Category  * _Nullable selectedCategory;

@property (nonatomic) NSArray<Article *> * _Nonnull articles;

-(void)clearAllArticles;
-(NSInteger)numberOfSections;
-(NSInteger)numberOfItemsInSection:(NSInteger)section;
-(Article *)articleAtIndexPath:(NSIndexPath *)indexPath;
-(NSUInteger)indexOfArticle:(Article *)article;
-(void)loadArticlesForNextPageWithBlock:(void (^)(NSError * _Nullable error, NSArray<NSIndexPath *> *indexPaths))block;
-(void)loadArticlesForCategoryWithBlock:(void (^)(NSError * _Nullable error, NSArray<NSIndexPath *> *indexPaths))block;
@end
