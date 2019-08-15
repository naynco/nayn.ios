//
//  ArticleListHeaderReusableView.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 23/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticleListHeaderReusableView.h"

@implementation ArticleListHeaderReusableView

-(void)awakeFromNib {
    [super awakeFromNib];

    _separatorView.layer.cornerRadius = 2.0;
    _titleLabel.text = nil;

    self.translatesAutoresizingMaskIntoConstraints = NO;
    _contentViewWidthConstraint.constant = UIScreen.mainScreen.bounds.size.width;
}

@end
