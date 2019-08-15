//
//  GradientView.m
//  NaynCo
//
//  Created by Serra Bassarac on 19/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
        gradientLayer.startPoint = CGPointMake(0.5, 0);
        gradientLayer.endPoint = CGPointMake(0.5, 1.0);
        
        gradientLayer.colors = @[
            (id)UIColor.clearColor.CGColor,
              (id)[[UIColor.blackColor colorWithAlphaComponent:0.7] CGColor]
            ];
    }
    return self;
}

+(Class)layerClass {
    return CAGradientLayer.class;
}

@end
