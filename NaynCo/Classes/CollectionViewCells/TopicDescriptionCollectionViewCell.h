//
//  TopicDescriptionCollectionViewCell.h
//  NaynCo
//
//  Created by Serra Bassarac on 15/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicDescriptionCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;

@end
