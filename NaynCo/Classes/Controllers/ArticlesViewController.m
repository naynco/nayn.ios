//
//  ViewController.m
//  NaynCo
//
//  Created by Serra Bassarac on 01/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticlesViewController.h"
#import <Mantle/Mantle.h>
#import "Article.h"
#import "Category.h"
#import "ArticleImage.h"
#import "Topic.h"
#import "ArticlesCollectionViewCell.h"
#import "TopicContainerCollectionViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "UIColor+Nayn.h"
#import "Article+Network.h"
#import "AFIndexedCollectionView.h"
#import "TopicCollectionViewCell.h"
#import "TopicDetailViewController.h"
#import "ArticleDetailViewController.h"
#import "CategoriesViewController.h"
#import "ArticleListHeaderReusableView.h"
#import "GradientColors.h"
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAIFields.h>
#import "ArticleDetailContainerViewController.h"
#import <GoogleToolboxForMac/GTMNSString+HTML.h>
#import <SafariServices/SafariServices.h>
#import "NaynListLayout.h"
#import "NSAttributedString+Nayn.h"
#import "UIFont+Additions.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ArticlesViewController () <CategoryViewControllerDelegate, UIPopoverPresentationControllerDelegate>

@property (nonatomic) NSArray *categories;
@property (nonatomic) NSArray *topics;

@property (nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property(nonatomic) UIRefreshControl *refreshControl;

@end

@implementation ArticlesViewController {
    BOOL _shouldReloadNewItems;
    BOOL _didTriggerRefresh;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    id<GAITracker> tracker = [GAI sharedInstance].defaultTracker;
    [tracker set:kGAIScreenName value:@"Articles"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.collectionView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshCollectionView:) forControlEvents:UIControlEventValueChanged];
    self.collectionView.alwaysBounceVertical = YES;

    _shouldReloadNewItems = YES;
    _didTriggerRefresh = NO;
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nayn-navigation-logo"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = logoItem;
    
    UIBarButtonItem *podItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pod-button"] style:UIBarButtonItemStylePlain target:self action:@selector(podButtonTapped:)];

    UIButton *categoriesButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [categoriesButton setTitle:@"KATEGORİLER" forState:UIControlStateNormal];
    [categoriesButton.titleLabel setFont:[UIFont categoryTitleFont]];
    [categoriesButton setTitleColor:[UIColor naynYellowColor] forState:UIControlStateNormal];
    [categoriesButton setImage:[UIImage imageNamed:@"category-down-arrow"] forState:UIControlStateNormal];
    [categoriesButton setTintColor:[UIColor whiteColor]];
    [categoriesButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -4)];
    [categoriesButton setContentEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 8)];
    [categoriesButton addTarget:self action:@selector(categoriesTapped:) forControlEvents:UIControlEventTouchUpInside];

    [categoriesButton sizeToFit];
    
    self.navigationItem.rightBarButtonItem = podItem;

    self.navigationItem.titleView = categoriesButton;
    
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    
    UINib *articleCellNib = [UINib nibWithNibName:@"ArticlesCollectionViewCell" bundle:nil];

    
    [_collectionView registerNib:articleCellNib forCellWithReuseIdentifier:@"Cell"];
    
    _collectionView.contentInset = UIEdgeInsetsZero;
    [(NaynListLayout *)_collectionView.collectionViewLayout setSectionInset:UIEdgeInsetsZero];

    if (_articleDataSource == nil) {
        _articleDataSource = [[ArticleDataSource alloc] init];
        [self loadData];
    } else {
        [self loadCategoryData];
    }


}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.collectionView.collectionViewLayout invalidateLayout];
//    });
}

-(void)loadData {
    _shouldReloadNewItems = NO;
    [_articleDataSource loadArticlesForNextPageWithBlock:^(NSError * _Nullable error, NSArray<NSIndexPath *> *indexPaths) {
        if (error == nil) {
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            [_collectionView performBatchUpdates:^{
                [_collectionView insertItemsAtIndexPaths:indexPaths];
                [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
            } completion:^(BOOL finished) {
                if (finished) {
                    _shouldReloadNewItems = YES;
                    if (_didTriggerRefresh) {
                        [self.refreshControl endRefreshing];
                    }
                    _didTriggerRefresh = NO;
                }
            }];
            [CATransaction commit];
        } else {
            _shouldReloadNewItems = YES;

            _didTriggerRefresh = NO;
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

-(void)loadCategoryData {
    _shouldReloadNewItems = NO;
    [_articleDataSource loadArticlesForCategoryWithBlock:^(NSError * _Nullable error, NSArray<NSIndexPath *> *indexPaths) {
        if (error == nil) {
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            [_collectionView performBatchUpdates:^{
                [_collectionView insertItemsAtIndexPaths:indexPaths];
                [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
            } completion:^(BOOL finished) {
                if (finished) {
                    _shouldReloadNewItems = YES;
                    if (_didTriggerRefresh) {
                        [self.refreshControl endRefreshing];
                    }
                    _didTriggerRefresh = NO;
                }
            }];
            [CATransaction commit];
        } else {
            _shouldReloadNewItems = YES;
            _didTriggerRefresh = NO;
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

-(void)categoriesTapped:(UIButton *)sender {

    CategoriesViewController *categoryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"categoriesViewController"];

    categoryViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    categoryViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;

    categoryViewController.delegate = self;

    categoryViewController.preferredContentSize = CGSizeMake(300, self.view.bounds.size.height - self.topLayoutGuide.length - 160);

    categoryViewController.modalPresentationStyle = UIModalPresentationPopover;

    categoryViewController.popoverPresentationController.delegate = self;

    [self presentViewController:categoryViewController animated:YES completion:nil];

}

-(void)podButtonTapped:(UIBarButtonItem *)sender {
    SFSafariViewController *podController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://nayn.co/pod/"]];
    podController.preferredBarTintColor = [UIColor blackColor];
    podController.preferredControlTintColor = [UIColor naynYellowColor];

    [self presentViewController:podController animated:YES completion:nil];
}

-(void)refreshCollectionView:(UIRefreshControl *)sender {
    _didTriggerRefresh = YES;
        [_articleDataSource clearAllArticles];
    
    [_collectionView reloadData];

    if (_articleDataSource.selectedCategory != nil) {
        [self loadCategoryData];
    } else {
        [self loadData];
    }
}


-(void)reloadCollectionViewProperly:(BOOL)isAfterCategoryChange {
    
    [UIView animateWithDuration:0.2 animations:^{
        _collectionView.alpha = 0;
    }];
    
    if (isAfterCategoryChange) {
        [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    } else {
        [_collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
    }
    
    [_collectionView setContentInset:UIEdgeInsetsMake(28, 0, 0, 0)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_collectionView scrollRectToVisible:CGRectMake(0, [UIScreen mainScreen].bounds.size.height*2, 1, 1) animated:YES];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
            [UIView animateWithDuration:0.3 delay:0.5 options:kNilOptions animations:^{
                _collectionView.alpha = 1.0;
            } completion:nil];
        });


    });
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [_articleDataSource numberOfItemsInSection:section];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return [_articleDataSource numberOfSections];
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ArticlesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    Article *article = [_articleDataSource articleAtIndexPath:indexPath];

    NSAttributedString *attrString = [NSAttributedString articleTitleAttributedString:article.title font:[UIFont articleTitleFont] color:[UIColor whiteTitleColor]];

    cell.titleLabel.attributedText = attrString;

    Category *category = article.categories.firstObject;

    cell.categoryLabel.text = category.name;

    if (category.gradientStartColor) {
        UIColor *startColor = [UIColor colorWithHexString:category.gradientStartColor];
        UIColor *endColor = [UIColor colorWithHexString:category.gradientEndColor];

        [(CAGradientLayer *)cell.categoryBackgroundView.layer setColors:@[
                                                                          (id)startColor.CGColor,
                                                                          (id)endColor.CGColor
                                                                          ]];
    } else {
        [(CAGradientLayer *)cell.categoryBackgroundView.layer setColors:@[
                                                                          (id)[UIColor naynYellowColor].CGColor,
                                                                          (id)[UIColor naynYellowColor].CGColor
                                                                          ]];
    }



    [(CAGradientLayer *)cell.categoryBackgroundView.layer setStartPoint:CGPointMake(-0.1, -0.1)];
    [(CAGradientLayer *)cell.categoryBackgroundView.layer setEndPoint:CGPointMake(1.1, 1.1)];


    [cell.articleImageView sd_setImageWithURL:[NSURL URLWithString:[article.images.large stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]]];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d MMMM yyyy, EEEE hh:mm"];
    NSString *createdAt = [dateFormatter stringFromDate:article.createdAt];

    cell.articleDateLabel.text = createdAt;

    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Article *selectedArticle = [_articleDataSource articleAtIndexPath:indexPath];

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ArticleDetailViewController *detailController = [mainStoryboard instantiateViewControllerWithIdentifier:@"articleDetailViewController"];
    detailController.type = ArticleDetailViewControllerTypeRegular;

    detailController.article = selectedArticle;

    ArticleDetailContainerViewController *containerController = [[ArticleDetailContainerViewController alloc] initWithDetailController:detailController];

    containerController.title = _articleDataSource.selectedCategory ? [_articleDataSource.selectedCategory.name capitalizedStringWithLocale:[NSLocale localeWithLocaleIdentifier:@"tr"]] : @"Tüm Haberler";

    containerController.articleDataSource = _articleDataSource;

    [self.navigationController pushViewController:containerController animated:YES];

    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    Article *article = [_articleDataSource articleAtIndexPath:indexPath];

    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

    CGFloat calculatedHeight = 0;

    calculatedHeight += screenWidth * 175 / 375;

    calculatedHeight += 52;

    NSAttributedString *attrString = [NSAttributedString articleTitleAttributedString:article.title font:[UIFont articleTitleFont] color:[UIColor whiteTitleColor]];
    CGRect calculatedTitleRect = [attrString boundingRectWithSize:CGSizeMake(screenWidth - 31, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) context:nil];

    calculatedHeight += calculatedTitleRect.size.height;
    calculatedHeight += 85;

    return CGSizeMake(screenWidth, calculatedHeight);

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _collectionView) {
        if (_shouldReloadNewItems == NO) {
            return;
        }

        if (scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.bounds.size.height < 120 && _articleDataSource.articles.count > 0) {
            NSLog(@"CALLS NEW PAGE");
            if (_articleDataSource.selectedCategory != nil) {
                [self loadCategoryData];
            } else {
                
                [self loadData];
            }
        }
    }
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [_collectionView.collectionViewLayout invalidateLayout];
}

-(void)didSelectCategory:(Category *)category {
    
    if ([_articleDataSource.selectedCategory.identifier isEqualToNumber:category.identifier]) {
        return;
    }
    
    [_collectionView scrollRectToVisible:CGRectZero animated:YES];
    
    [_articleDataSource setSelectedCategory:category];
    
    [self loadCategoryData];
    
}

-(void)didRemoveCategory {
    
    if (_articleDataSource.selectedCategory == nil) {
        return;
    }
    
    [_collectionView scrollRectToVisible:CGRectZero animated:YES];
    
    _articleDataSource = nil;
    
    _articleDataSource = [[ArticleDataSource alloc] init];
    
    [_articleDataSource setSelectedCategory:nil];

    [_articleDataSource clearAllArticles];
    
    [self loadData];
}

//MARK: - UIPopoverPresentationControllerDelegate

-(void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController {
    popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popoverPresentationController.popoverLayoutMargins = UIEdgeInsetsMake(popoverPresentationController.popoverLayoutMargins.top, (self.view.frame.size.width-300)/2, popoverPresentationController.popoverLayoutMargins.bottom, (self.view.frame.size.width-300)/2);
    popoverPresentationController.sourceView = self.navigationItem.titleView;
    popoverPresentationController.sourceRect = CGRectMake(9, CGRectGetMaxY(self.navigationItem.titleView.frame), 1, 1);

    popoverPresentationController.backgroundColor = [UIColor whiteColor];

    self.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;

}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    self.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
}

-(void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView *__autoreleasing  _Nonnull *)view {

}

//MARK:- XLPagerTabStripViewControllerDelegate
-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController {
    if (_articleDataSource.selectedCategory == nil) {
        return @"Tüm Haberler";
    } else {
        return [_articleDataSource.selectedCategory.name capitalizedStringWithLocale:[NSLocale localeWithLocaleIdentifier:@"tr"]];
    }
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController {
    return [UIColor naynYellowColor];
}
@end
