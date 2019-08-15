//
//  UIColor+Nayn.m
//  NaynCo
//
//  Created by Serra Bassarac on 04/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "UIColor+Nayn.h"

@implementation UIColor (Nayn)

+ (CGFloat)colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+(UIColor *)hotNewsCategoryBackgroundColor {
    return [UIColor colorWithHexString:@"#FF4136"];
}

+(UIColor *)sportsCategoryBackgroundColor {
    return [UIColor colorWithHexString:@"#2ECC40"];
}

+ (UIColor * _Nonnull)topicDescriptionBackgroundColor {
    return [UIColor colorWithWhite:243.0f / 255.0f alpha:1.0f];
}

+ (UIColor * _Nonnull)dateHeaderBackgroundColor {
    return [UIColor colorWithWhite:216.0f / 255.0f alpha:1.0f];
}

+ (UIColor * _Nonnull)topicBigTitleColor {
    return [UIColor colorWithRed:236.0f / 255.0f green:226.0f / 255.0f blue:226.0f / 255.0f alpha:1.0f];
}

+ (UIColor * _Nonnull)timestampGrayColorColor {
    return [UIColor colorWithWhite:106.0f / 255.0f alpha:1.0f];
}

+ (UIColor * _Nonnull)hotTopicCategoryColorColor {
    return [UIColor colorWithRed:1.0f green:65.0f / 255.0f blue:54.0f / 255.0f alpha:1.0f];
}

+ (UIColor * _Nonnull)naynYellowColor {
    return [UIColor colorWithHue:0.133 saturation:0.886 brightness:1 alpha:1];
}

+ (UIColor * _Nonnull)whiteTitleColor {
    return [UIColor colorWithHue:0 saturation:0 brightness:0.98 alpha:1];
}

+ (UIColor * _Nonnull)darkTitleColor {
    return [UIColor colorWithHue:0 saturation:0 brightness:0.2 alpha:1];
}



@end
