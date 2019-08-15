//
//  Category+Network.m
//  NaynCo
//
//  Created by Serra Bassarac on 09/05/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "Category+Network.h"
#import "NaynCoAPIManager.h"

@implementation Category (Network)

+(void)getCategoriesWithBlock:(void (^)(NSArray *categories, NSError *error))block {
    
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    
    NSURLRequest *request = [serializer requestWithMethod:@"GET" URLString:@"http://api.nayn.co/v1/categories" parameters:nil error:nil];
    
    NSURLSessionDataTask *dataTask = [[NaynCoAPIManager sharedManager] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            block(nil, error);
        } else {
            NSError *jsonError = nil;
            NSArray *categories = [MTLJSONAdapter modelsOfClass:Category.class fromJSONArray:responseObject[@"data"] error:&jsonError];
            
            block(categories, nil);
        }
        
    }];
    [dataTask resume];
}

@end
