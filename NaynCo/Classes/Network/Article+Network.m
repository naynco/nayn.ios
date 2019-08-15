//
//  Article+Network.m
//  NaynCo
//
//  Created by Serra Bassarac on 02/05/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "Article+Network.h"
#import "Article.h"
#import "NaynCoAPIManager.h"
#import "Category.h"

@implementation Article (Network)

+(void)getArticlesWithBlock:(void (^)(NSArray *articles, NSError *error))block forPage:(NSUInteger)page {
    
    NSLog(@"Loads for page: %lu", (unsigned long)page);
    
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    
    NSURLRequest *request = [serializer requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"http://api.nayn.co/v1/posts?page=%lu", (unsigned long)page] parameters:nil error:nil];
    
    NSURLSessionDataTask *dataTask = [[NaynCoAPIManager sharedManager] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            block(nil, error);
        } else {
            NSError *jsonError = nil;
            NSArray *articles = [MTLJSONAdapter modelsOfClass:Article.class fromJSONArray:responseObject[@"data"] error:&jsonError];
            
            block(articles, nil);
        }
        
    }];
    [dataTask resume];
}

+(void)getArticleDetail:(Article *)article withBlock:(void (^)(Article *article, NSError *error))block {

    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];

    NSURLRequest *request = [serializer requestWithMethod:@"GET" URLString:[NSString stringWithFormat: @"http://api.nayn.co/v1/post/%@", article.identifier.stringValue] parameters:nil error:nil];

    NSURLSessionDataTask *dataTask = [[NaynCoAPIManager sharedManager] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            block(nil, error);
        } else {
            NSError *jsonError = nil;
            NSArray *articlesArray = responseObject[@"data"];
            Article *article = [MTLJSONAdapter modelOfClass:Article.class fromJSONDictionary:articlesArray.firstObject error:&jsonError];

            block(article, nil);
        }

    }];
    [dataTask resume];
}

+(void)getArticlesForCategory:(Category *)category forPage:(NSUInteger)page withBlock:(void (^)(NSArray *articles, NSError *error))block {
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    
    NSURLRequest *request = [serializer requestWithMethod:@"GET" URLString:[NSString stringWithFormat: @"http://api.nayn.co/v1/posts-by-category/%@?page=%lu", category.identifier.stringValue, (unsigned long)page] parameters:nil error:nil];
    
    NSURLSessionDataTask *dataTask = [[NaynCoAPIManager sharedManager] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            block(nil, error);
        } else {
            NSError *jsonError = nil;
            NSArray *articles = [MTLJSONAdapter modelsOfClass:Article.class fromJSONArray:responseObject[@"data"] error:&jsonError];
            
            block(articles, nil);
        }
        
    }];
    [dataTask resume];
}
@end
