//
//  HTMLGiphyGIF.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 21.05.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "HTMLGiphyGIF.h"

@implementation HTMLGiphyGIF

-(instancetype)initWithID:(NSString *)identifier {
    if (self = [super init]) {
        _gifID = identifier;
    }
    return self;
}

@end
