//
//  UIBarButtonItem+Nayn.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 4.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "UIBarButtonItem+Nayn.h"

@implementation UIBarButtonItem (Nayn)
+(instancetype)backBarButtonItemWithTintColor:(UIColor *)tintColor target:(nullable id)target action:(nullable SEL)selector {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-button"] style:UIBarButtonItemStylePlain target:target action:selector];

    item.tintColor = tintColor;

    return item;
}
@end
