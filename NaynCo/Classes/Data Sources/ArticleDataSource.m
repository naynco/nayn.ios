//
//  ArticleDataSource.m
//  NaynCo
//
//  Created by Serra Bassarac on 03/04/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticleDataSource.h"
#import <Mantle/Mantle.h>
#import "Article.h"
#import "Article+Network.h"
#import "Category.h"

@interface ArticleDataSource ()
@property (nonatomic) NSMutableArray<Article *> *initialArray;

@property (readwrite) NSUInteger page;

@end

@implementation ArticleDataSource {
    BOOL _isSendingRequest;
    BOOL _didGetLastPage;
}

-(instancetype)init {
    if (self = [super init]) {
        _isSendingRequest = NO;
        _didGetLastPage = NO;
        
        _page = 0;
        
        _initialArray = [NSMutableArray array];
    }
    return self;
}

-(void)clearAllArticles {
    _page = 0;
    [_initialArray removeAllObjects];
    _articles = [NSArray array];
}

-(void)loadArticlesForNextPageWithBlock:(void (^)(NSError * _Nullable error, NSArray<NSIndexPath *> *indexPaths))block {
    
    if (_isSendingRequest || _didGetLastPage) {
        return;
    }
    
    _isSendingRequest = YES;
    
    _page += 1;
    [Article getArticlesWithBlock:^(NSArray<Article *> *articles, NSError *error) {
        _isSendingRequest = NO;
        if (error == nil) {
            
            if (articles.count == 0) {
                _didGetLastPage = YES;
            }

            NSMutableArray *indexPathsArray = [NSMutableArray array];
            for (NSUInteger index = _initialArray.count; index < _initialArray.count+articles.count; index++) {
                [indexPathsArray addObject:[NSIndexPath indexPathForItem:index inSection:0]];
            }
            
            [_initialArray addObjectsFromArray:articles];
            _articles = [_initialArray copy];
            block(nil, indexPathsArray);
        } else {
            _isSendingRequest = NO;
            block(error, nil);
        }
        
    } forPage:_page];
}

-(void)setSelectedCategory:(Category *)selectedCategory {
    [self clearAllArticles];
    _selectedCategory = selectedCategory;
}

-(void)loadArticlesForCategoryWithBlock:(void (^)(NSError * _Nullable error, NSArray<NSIndexPath *> *indexPaths))block {
    if (_isSendingRequest || _didGetLastPage) {
        return;
    }
    
    _isSendingRequest = YES;
    
    _page += 1;

    [Article getArticlesForCategory:_selectedCategory forPage:_page withBlock:^(NSArray *articles, NSError *error) {
        _isSendingRequest = NO;
        if (error == nil) {
            if (articles.count == 0) {
                _didGetLastPage = YES;
            }
            
            NSMutableArray *indexPathsArray = [NSMutableArray array];
            for (NSUInteger index = _initialArray.count; index < _initialArray.count+articles.count; index++) {
                [indexPathsArray addObject:[NSIndexPath indexPathForItem:index inSection:0]];
            }
            
            [_initialArray addObjectsFromArray:articles];
            _articles = [_initialArray copy];
            block(nil, indexPathsArray);
        } else {
            block(error, nil);
        }
    }];
}

-(NSInteger)numberOfSections {
    return 1;
}

-(NSInteger)numberOfItemsInSection:(NSInteger)section {
    
    return _articles.count;
    
}

-(Article *)articleAtIndexPath:(NSIndexPath *)indexPath {
    return [_articles objectAtIndex:indexPath.row];
}

-(NSUInteger)indexOfArticle:(Article *)article {
    return [_articles indexOfObject:article];
}




@end
