//
//  TopicTimelineCollectionViewCell.h
//  NaynCo
//
//  Created by Serra Bassarac on 15/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicTimelineCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *topicTimelineImageView;
@property (weak, nonatomic) IBOutlet UILabel *topicTimelineLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicTimelineDateLabel;
@property (weak, nonatomic) IBOutlet UIView *timelineDateBackgroundView;

@end
