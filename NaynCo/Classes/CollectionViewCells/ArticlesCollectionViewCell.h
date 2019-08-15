//
//  ArticlesCollectionViewCell.h
//  NaynCo
//
//  Created by Serra Bassarac on 01/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticlesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIView *categoryBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleDateLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;



@end
