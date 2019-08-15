//
//  ArticleContainerTitleView.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 4.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticleContainerTitleView.h"
#import "UIFont+Additions.h"
#import "UIColor+Nayn.h"

@implementation ArticleContainerTitleView

-(instancetype)init {
    if (self = [super init]) {
        [self configureViews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configureViews];
    }
    return self;
}

-(void)configureViews {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont categoryTitleFont];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor naynYellowColor];
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_titleLabel];
    }

    _titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2);


    if (_subtitleLabel == nil) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont newsCountFont];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        _subtitleLabel.textColor = [UIColor whiteColor];
        _subtitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_subtitleLabel];
    }

    _subtitleLabel.frame = CGRectMake(0, self.bounds.size.height/2-2, self.bounds.size.width, self.bounds.size.height/2-3);

}

-(void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];

    [self configureViews];
}

@end
