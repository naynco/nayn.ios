//
//  Article+Network.h
//  NaynCo
//
//  Created by Serra Bassarac on 02/05/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "Article.h"

@interface Article (Network)

+(void)getArticlesWithBlock:(void (^)(NSArray *articles, NSError *error))block forPage:(NSUInteger)page;
+(void)getArticlesForCategory:(Category *)category forPage:(NSUInteger)page withBlock:(void (^)(NSArray *articles, NSError *error))block;
+(void)getArticleDetail:(Article *)article withBlock:(void (^)(Article *article, NSError *error))block;
@end
