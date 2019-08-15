//
//  NewsCountViewModel.h
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 5.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsCountViewModel : NSObject

@property (nonatomic) NSUInteger currentIndex;
@property (nonatomic) NSUInteger totalNumberOfPages;

-(NSString *)currentPageString;

@end

NS_ASSUME_NONNULL_END
