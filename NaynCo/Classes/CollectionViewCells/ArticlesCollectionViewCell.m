//
//  ArticlesCollectionViewCell.m
//  NaynCo
//
//  Created by Serra Bassarac on 01/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticlesCollectionViewCell.h"

@implementation ArticlesCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentViewWidthConstraint.constant = UIScreen.mainScreen.bounds.size.width;
}

@end
