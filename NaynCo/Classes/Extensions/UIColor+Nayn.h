//
//  UIColor+Nayn.h
//  NaynCo
//
//  Created by Serra Bassarac on 04/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Nayn)
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+(UIColor *)hotNewsCategoryBackgroundColor;
+(UIColor *)sportsCategoryBackgroundColor;
+ (UIColor * _Nonnull)topicDescriptionBackgroundColor;
+ (UIColor * _Nonnull)dateHeaderBackgroundColor;
+ (UIColor * _Nonnull)topicBigTitleColor;
+ (UIColor * _Nonnull)timestampGrayColorColor;
+ (UIColor * _Nonnull)hotTopicCategoryColorColor;
+ (UIColor * _Nonnull)naynYellowColor;
+ (UIColor * _Nonnull)whiteTitleColor;
+ (UIColor * _Nonnull)darkTitleColor;
@end
