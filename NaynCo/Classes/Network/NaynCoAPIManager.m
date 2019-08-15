//
//  NaynCoAPIManager.m
//  NaynCo
//
//  Created by Serra Bassarac on 01/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "NaynCoAPIManager.h"

@implementation NaynCoAPIManager

+ (instancetype)sharedManager {
    static NaynCoAPIManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[NaynCoAPIManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    
    return _sharedManager;
}

@end
