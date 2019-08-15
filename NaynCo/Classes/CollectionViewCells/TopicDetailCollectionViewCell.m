//
//  TopicDetailCollectionViewCell.m
//  NaynCo
//
//  Created by Serra Bassarac on 16/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "TopicDetailCollectionViewCell.h"
#import "UIColor+Nayn.h"

@implementation TopicDetailCollectionViewCell
-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentViewWidthConstraint.constant = UIScreen.mainScreen.bounds.size.width;
    
    self.topicLabel.textColor = [UIColor topicBigTitleColor];
}
@end
