//
//  MoreArticlesTableViewCell.h
//  NaynCo
//
//  Created by Serra Bassarac on 5.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreArticlesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;

@end

NS_ASSUME_NONNULL_END
