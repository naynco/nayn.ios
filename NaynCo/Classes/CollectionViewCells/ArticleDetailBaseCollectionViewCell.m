//
//  ArticleDetailBaseCollectionViewCell.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 21.05.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticleDetailBaseCollectionViewCell.h"

@implementation ArticleDetailBaseCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];

    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentViewWidthConstraint.constant = UIScreen.mainScreen.bounds.size.width;
}

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {

    UICollectionViewLayoutAttributes *autoLayoutAttributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];


    CGSize targetSize = CGSizeMake(layoutAttributes.frame.size.width, 0);

    CGSize autoLayoutSize = [self.contentView systemLayoutSizeFittingSize:targetSize withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityDefaultLow];

    // Calculate the size (height) using Auto Layout
    CGRect autoLayoutFrame = CGRectMake(autoLayoutAttributes.frame.origin.x, autoLayoutAttributes.frame.origin.y, autoLayoutSize.width, autoLayoutSize.height);

    autoLayoutAttributes.frame = autoLayoutFrame;

    // Assign the new size to the layout attributes
    return autoLayoutAttributes;
}

@end
