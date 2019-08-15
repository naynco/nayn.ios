//
//  ArticleDetailTitleCollectionViewCell.h
//  NaynCo
//
//  Created by Serra Bassarac on 20/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkewedGradientView.h"
#import "ArticleDetailBaseCollectionViewCell.h"

@interface ArticleDetailTitleCollectionViewCell : ArticleDetailBaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *descriptionTitle;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet SkewedGradientView *categoryBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UIButton *whatsappButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *messengerButton;

@end
