//
//  HTMLTweet.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 21.06.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "HTMLTweet.h"

@implementation HTMLTweet

-(instancetype)initWithTweetID:(NSString *)tweetID {
    if (self = [super init]) {
        _tweetID = tweetID;
    }

    return self;
}

@end
