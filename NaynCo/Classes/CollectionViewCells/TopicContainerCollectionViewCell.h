//
//  TopicContainerCollectionViewCell.h
//  NaynCo
//
//  Created by Serra Bassarac on 14/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmbeddedCollectionView.h"

@interface TopicContainerCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet EmbeddedCollectionView *collectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;


@end
