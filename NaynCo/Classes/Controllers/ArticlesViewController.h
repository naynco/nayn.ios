//
//  ViewController.h
//  NaynCo
//
//  Created by Serra Bassarac on 01/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XLPagerTabStrip/XLPagerTabStrip-umbrella.h>
#import "ArticleDataSource.h"

@interface ArticlesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, XLPagerTabStripChildItem>

@property (nonatomic) ArticleDataSource *articleDataSource;

@end

