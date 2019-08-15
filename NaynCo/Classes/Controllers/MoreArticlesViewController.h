//
//  MoreArticlesViewController.h
//  NaynCo
//
//  Created by Serra Bassarac on 5.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ArticleDataSource;

@interface MoreArticlesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *gripView;
@property (weak, nonatomic) IBOutlet UIView *gripContainerView;

@property (nonatomic) ArticleDataSource *dataSource;

@end

NS_ASSUME_NONNULL_END
