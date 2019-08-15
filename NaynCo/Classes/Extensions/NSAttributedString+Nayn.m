//
//  NSAttributedString+Nayn.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 3.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "NSAttributedString+Nayn.h"

@implementation NSAttributedString (Nayn)

+(instancetype)articleTitleAttributedString:(NSString *)string font:(UIFont *)font color:(UIColor *)color {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];

    paraStyle.maximumLineHeight = 31;
    paraStyle.minimumLineHeight = 31;
    paraStyle.alignment = NSTextAlignmentLeft;

    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:@{
                                                                                                    NSParagraphStyleAttributeName: paraStyle,
                                                                                                    NSFontAttributeName: font,
                                                                                                    NSForegroundColorAttributeName : color
                                                                                                    }];

    return attrString;
}

@end
