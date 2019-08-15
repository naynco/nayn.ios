//
//  SelectCategoryTableViewCell.h
//  NaynCo
//
//  Created by Serra Bassarac on 07/05/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradientView.h"

@interface SelectCategoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet GradientView *backgroundGradientView;

@end
