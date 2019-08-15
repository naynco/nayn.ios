//
//  ArticleDetailContainerViewController.h
//  NaynCo
//
//  Created by Serra Bassarac on 17/04/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleDataSource, ArticleDetailViewController;

@interface ArticleDetailContainerViewController : UIPageViewController

@property (nonatomic) ArticleDataSource *articleDataSource;

-(instancetype)initWithDetailController:(ArticleDetailViewController *)controller;

@end
