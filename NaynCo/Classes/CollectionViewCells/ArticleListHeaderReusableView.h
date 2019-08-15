//
//  ArticleListHeaderReusableView.h
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 23/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleListHeaderReusableView : UICollectionReusableView

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIView *separatorView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;


@end
