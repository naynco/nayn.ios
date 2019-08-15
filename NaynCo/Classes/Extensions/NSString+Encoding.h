//
//  NSString+Encoding.h
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 3.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Encoding)

- (nullable NSString *)stringByAddingPercentEncodingForRFC3986;

@end

NS_ASSUME_NONNULL_END
