//
//  ArticleDetailImageCollectionViewCell.h
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 14.05.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleDetailBaseCollectionViewCell.h"

@interface ArticleDetailImageCollectionViewCell : ArticleDetailBaseCollectionViewCell
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;

@end
