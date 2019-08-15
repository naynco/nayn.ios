//
//  NaynCoAPIManager.h
//  NaynCo
//
//  Created by Serra Bassarac on 01/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NaynCoAPIManager : AFURLSessionManager
+ (instancetype)sharedManager;

@end
