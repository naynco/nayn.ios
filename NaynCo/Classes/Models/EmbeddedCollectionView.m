//
//  EmbeddedCollectionView.m
//  NaynCo
//
//  Created by Serra Bassarac on 16/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "EmbeddedCollectionView.h"

@implementation EmbeddedCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == self) {
        return self.superview;
    } else {
        return view.superview.superview;
    }
}
@end
