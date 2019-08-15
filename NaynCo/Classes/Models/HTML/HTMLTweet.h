//
//  HTMLTweet.h
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 21.06.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMLTweet : NSObject

@property (nonatomic) NSString *tweetID;

-(instancetype)initWithTweetID:(NSString *)tweetID;

@end
