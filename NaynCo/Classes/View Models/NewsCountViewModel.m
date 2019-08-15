//
//  NewsCountViewModel.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 5.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "NewsCountViewModel.h"

@implementation NewsCountViewModel

-(NSString *)currentPageString {
    return [NSString stringWithFormat:@"%lu / %lu", _currentIndex, _totalNumberOfPages];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _totalNumberOfPages = 1;
        _currentIndex = 1;
    }
    return self;
}

@end
