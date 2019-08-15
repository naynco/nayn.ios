//
//  ArticlesPagerViewController.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 4.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticlesPagerViewController.h"
#import "ArticlesViewController.h"
#import "UIColor+Nayn.h"
#import "UIFont+Additions.h"
#import "CategoryDataSource.h"
#import "Category.h"
#import "ArticleDataSource.h"

@interface ArticlesPagerViewController () <XLPagerTabStripViewControllerDataSource>
@property (nonatomic) CategoryDataSource *categoryDataSource;
@property (nonatomic) NSArray<Category *> *categories;

@end

@implementation ArticlesPagerViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _categoryDataSource = [[CategoryDataSource alloc] init];

    self.view.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0.1 alpha:1];
    self.buttonBarView.selectedBar.backgroundColor = [UIColor naynYellowColor];
    self.isProgressiveIndicator = true;
    self.buttonBarView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0.133 alpha:1];
    self.buttonBarView.selectedBarHeight = 2.0;
    self.buttonBarView.selectedBarAlignment = XLSelectedBarAlignmentProgressive;
    self.buttonBarView.labelFont = [UIFont categoryTitleFont];


    self.changeCurrentIndexProgressiveBlock = ^(XLButtonBarViewCell* oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL indexWasChanged, BOOL fromCellRowAtIndex) {
        if (progressPercentage > 0.5 && indexWasChanged) {
            oldCell.label.textColor = [UIColor whiteColor];
            newCell.label.textColor = [UIColor naynYellowColor];
        }
    };

    [_categoryDataSource downloadAllCategories:^(NSArray * _Nonnull categories, NSError * _Nonnull error) {
        if (error == nil) {
            _categories = categories;
            [self reloadPagerTabStripView];
            [self.buttonBarView reloadData];
        }
    }];


}

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController {
    NSMutableArray<UIViewController *> *controllers = [NSMutableArray array];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ArticlesViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"articlesViewController"];
    [controllers addObject:controller];
    for (Category *category in _categories) {
        ArticlesViewController *articlesCategoryController = [storyboard instantiateViewControllerWithIdentifier:@"articlesViewController"];
        ArticleDataSource *source = [[ArticleDataSource alloc] init];
        source.selectedCategory = category;
        articlesCategoryController.articleDataSource = source;
        [controllers addObject:articlesCategoryController];
    }

    return controllers;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
