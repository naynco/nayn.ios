//
//  ArticleDetailGiphyCollectionViewCell.h
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 21.05.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleDetailBaseCollectionViewCell.h"
#import <FLAnimatedImage/FLAnimatedImageView.h>


@interface ArticleDetailGiphyCollectionViewCell : ArticleDetailBaseCollectionViewCell

@property (nonatomic, weak) IBOutlet FLAnimatedImageView *animatedImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;

@end
