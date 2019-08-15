//
//  ArticleDetailTweetCollectionViewCell.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 21.06.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticleDetailTweetCollectionViewCell.h"

@implementation ArticleDetailTweetCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {

    UICollectionViewLayoutAttributes *autoLayoutAttributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];

    CGSize tweetSize = [_tweetView sizeThatFits:CGSizeMake(self.frame.size.width-32, 20000)];
    self.tweetViewHeightConstraint.constant = tweetSize.height;

    CGSize targetSize = CGSizeMake(layoutAttributes.frame.size.width, 0);

    CGSize autoLayoutSize = [self.contentView systemLayoutSizeFittingSize:targetSize withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityDefaultLow];

    // Calculate the size (height) using Auto Layout
    CGRect autoLayoutFrame = CGRectMake(autoLayoutAttributes.frame.origin.x, autoLayoutAttributes.frame.origin.y, autoLayoutSize.width, tweetSize.height + 12);

    autoLayoutAttributes.frame = autoLayoutFrame;

    // Assign the new size to the layout attributes
    return autoLayoutAttributes;
}

@end
