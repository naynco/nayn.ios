//
//  TopicTimelineCollectionViewCell.m
//  NaynCo
//
//  Created by Serra Bassarac on 15/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "TopicTimelineCollectionViewCell.h"
#import "UIColor+Nayn.h"

@implementation TopicTimelineCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentViewWidthConstraint.constant = UIScreen.mainScreen.bounds.size.width;
    _timelineDateBackgroundView.backgroundColor = [UIColor timestampGrayColorColor];
}

@end
