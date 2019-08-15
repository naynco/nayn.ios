//
//  GradientColors.m
//  NaynCo
//
//  Created by Serra Bassarac on 09/04/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "GradientColors.h"
#import "UIColor+Nayn.h"

@implementation GradientColors

+(NSArray *)hotNewsGradientColors {
    return @[
             (id)[UIColor colorWithHexString:@"#FF7666"].CGColor,
             (id)[UIColor colorWithHexString:@"#FF4136"].CGColor
             ];
}

+(NSArray *)worldNewsGradientColors {
    return @[
             (id)[UIColor colorWithHexString:@"#001FD8"].CGColor,
             (id)[UIColor colorWithHexString:@"#8509B7"].CGColor
             ];
}

+(NSArray *)sportsNewsGradientColors {
    return @[
             (id)[UIColor colorWithHexString:@"#38ECA1"].CGColor,
             (id)[UIColor colorWithHexString:@"#2ECC40"].CGColor
             ];
}
    
+(NSArray *)recentNewsGradientColors {
    return @[
             (id)[UIColor colorWithHexString:@"#FA709A"].CGColor,
             (id)[UIColor colorWithHexString:@"#FEE140"].CGColor
             ];
}
    
+(NSArray *)socialNewsGradientColors {
    return @[
             (id)[UIColor colorWithHexString:@"#5ee7df"].CGColor,
             (id)[UIColor colorWithHexString:@"#b490ca"].CGColor
             ];
}

+(NSArray *)artNewsGradientColors {
    return @[
             (id)[UIColor colorWithHexString:@"#cc208e"].CGColor,
             (id)[UIColor colorWithHexString:@"#6713d2"].CGColor
             ];
}

@end
