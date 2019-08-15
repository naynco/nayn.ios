//
//  SkewedView.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 5.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "SkewedView.h"

@implementation SkewedView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];

    [self applyMask];
}

-(void)applyMask {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, -sin(-M_PI/18)*self.bounds.size.height, 0) cornerRadius:3.0];
    [maskPath fill];
    [maskPath applyTransform:CGAffineTransformMake(1.0, 0.0, tan(-M_PI/18), 1.0, 0.0, 0.0)];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = maskPath.CGPath;

    self.layer.masksToBounds = true;

    self.layer.mask = shapeLayer;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self applyMask];
}

@end
