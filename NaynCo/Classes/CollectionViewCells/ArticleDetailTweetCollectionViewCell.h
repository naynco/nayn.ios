//
//  ArticleDetailTweetCollectionViewCell.h
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 21.06.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticleDetailBaseCollectionViewCell.h"
#import <TwitterKit/TWTRKit.h>

@interface ArticleDetailTweetCollectionViewCell : ArticleDetailBaseCollectionViewCell
@property (nonatomic, weak) IBOutlet TWTRTweetView *tweetView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *tweetViewHeightConstraint;

@end
