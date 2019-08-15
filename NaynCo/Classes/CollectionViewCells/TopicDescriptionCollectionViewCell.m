//
//  TopicDescriptionCollectionViewCell.m
//  NaynCo
//
//  Created by Serra Bassarac on 15/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "TopicDescriptionCollectionViewCell.h"
#import "UIColor+Nayn.h"

@implementation TopicDescriptionCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentViewWidthConstraint.constant = UIScreen.mainScreen.bounds.size.width;
    
    self.contentView.backgroundColor = [UIColor topicDescriptionBackgroundColor];
}

@end
