//
//  ArticleDetailViewController.h
//  NaynCo
//
//  Created by Serra Bassarac on 20/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;

typedef enum : NSUInteger {
    ArticleDetailViewControllerTypeRegular = 0,
    ArticleDetailViewControllerTypeFromNotification = 1
} ArticleDetailViewControllerType;

@interface ArticleDetailViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout>

@property (nonatomic) Article *article;
@property (readwrite) ArticleDetailViewControllerType type;

@end
