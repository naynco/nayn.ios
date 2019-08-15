//
//  UIBarButtonItem+Nayn.h
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 4.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Nayn)

+(instancetype)backBarButtonItemWithTintColor:(UIColor *)tintColor target:(nullable id)target action:(nullable SEL)selector;

@end

NS_ASSUME_NONNULL_END
