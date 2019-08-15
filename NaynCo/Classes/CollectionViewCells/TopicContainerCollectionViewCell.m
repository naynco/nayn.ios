//
//  TopicContainerCollectionViewCell.m
//  NaynCo
//
//  Created by Serra Bassarac on 14/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "TopicContainerCollectionViewCell.h"

@implementation TopicContainerCollectionViewCell

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    [self.collectionView setContentOffset:self.collectionView.contentOffset animated:NO];
    
    [self.collectionView setIndexPath:indexPath];
    
    [self.collectionView reloadData];
}

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentViewWidthConstraint.constant = UIScreen.mainScreen.bounds.size.width;
}


@end
