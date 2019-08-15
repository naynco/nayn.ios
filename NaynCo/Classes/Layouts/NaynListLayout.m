//
//  NaynListLayout.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 18.06.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "NaynListLayout.h"

@implementation NaynListLayout

-(instancetype)init {
    if (self = [super init]) {
        _insertingIndexPaths = [NSMutableArray array];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _insertingIndexPaths = [NSMutableArray array];
    }
    return self;
}

-(void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems {
    [super prepareForCollectionViewUpdates:updateItems];

    [_insertingIndexPaths removeAllObjects];

    for (UICollectionViewUpdateItem *update in updateItems) {
        NSIndexPath *indexPath = [update indexPathAfterUpdate];
        if (indexPath && update.updateAction == UICollectionUpdateActionInsert) {
            [_insertingIndexPaths addObject:indexPath];
        }
    }
}

-(void)finalizeCollectionViewUpdates {
    [super finalizeCollectionViewUpdates];

    [_insertingIndexPaths removeAllObjects];
}

-(UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];

    if ([_insertingIndexPaths containsObject:itemIndexPath]) {
        if (attributes) {
            attributes.alpha = 0;
            attributes.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }
    }
    return attributes;
}

@end
