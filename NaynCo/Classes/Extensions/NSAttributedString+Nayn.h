//
//  NSAttributedString+Nayn.h
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 3.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (Nayn)

+(instancetype)articleTitleAttributedString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
