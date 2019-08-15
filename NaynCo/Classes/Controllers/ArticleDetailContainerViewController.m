//
//  ArticleDetailContainerViewController.m
//  NaynCo
//
//  Created by Serra Bassarac on 17/04/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticleDetailContainerViewController.h"
#import "ArticleDetailViewController.h"
#import <SMPageControl/SMPageControl.h>
#import "Article.h"
#import "UIBarButtonItem+Nayn.h"
#import "ArticleContainerTitleView.h"
#import "NewsCountViewModel.h"
#import "MoreArticlesViewController.h"
#import <Masonry/Masonry.h>
#import "ArticleDataSource.h"

@interface ArticleDetailContainerViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) NSUInteger currentIndex;
@property (nonatomic) NSUInteger nextIndex;

@property (nonatomic) ArticleContainerTitleView *titleView;
@property (nonatomic) NewsCountViewModel *viewModel;

@property (nonatomic) MoreArticlesViewController *moreArticlesController;
@property (nonatomic) MASConstraint *moreNewsHeightConstraint;

@end

@implementation ArticleDetailContainerViewController {
    BOOL _isMoreNewsDrawerOpen;
}

-(instancetype)initWithDetailController:(ArticleDetailViewController *)controller {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self) {
        [self setViewControllers:@[controller] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        self.dataSource = self;
        self.delegate = self;
        _viewModel = [[NewsCountViewModel alloc] init];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _moreArticlesController = [mainStoryboard instantiateViewControllerWithIdentifier:@"moreArticlesViewController"];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewController:_moreArticlesController];

    [self.view addSubview: _moreArticlesController.view];

    [_moreArticlesController didMoveToParentViewController:self];

    _isMoreNewsDrawerOpen = NO;

    [_moreArticlesController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(_moreArticlesController.view.superview);
        make.bottom.equalTo(_moreArticlesController.view.superview);
        _moreNewsHeightConstraint = make.height.equalTo(@(_moreArticlesController.gripContainerView.bounds.size.height));
    }];


    [_moreArticlesController.gripContainerView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moreArticlesPanned:)]];

    [_moreArticlesController.gripContainerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreArticlesTapped:)]];

    _moreArticlesController.dataSource = _articleDataSource;

    self.edgesForExtendedLayout = UIRectEdgeTop;

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemWithTintColor:[UIColor whiteColor] target:self action:@selector(backButtonTapped:)];

    _titleView = [[ArticleContainerTitleView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    self.navigationItem.titleView = _titleView;
    [_titleView sizeToFit];
    
    ArticleDetailViewController *firstController = (ArticleDetailViewController *)[self viewControllers].firstObject;

    NSUInteger index = [_articleDataSource indexOfArticle:firstController.article];
    _currentIndex = index;

    _viewModel.totalNumberOfPages = [_articleDataSource numberOfItemsInSection:0];
    _viewModel.currentIndex = index+1;

    _titleView.titleLabel.text = self.title;
    _titleView.subtitleLabel.text = [_viewModel currentPageString];

    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                 target:self
                                                                                 action:@selector(shareTapped:)];
    self.navigationItem.rightBarButtonItem = shareButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moreArticlesPanned:(UIPanGestureRecognizer *)recognizer {

    CGPoint movePoint = [recognizer locationInView:self.view];
    CGFloat height = self.view.bounds.size.height - movePoint.y;
    CGFloat containerTopHeight = _moreArticlesController.gripContainerView.bounds.size.height;
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (height <= containerTopHeight) {
            [_moreArticlesController.view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(containerTopHeight));
            }];
        } else if (height > self.view.bounds.size.height - self.topLayoutGuide.length) {
            [_moreArticlesController.view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(self.view.bounds.size.height - self.topLayoutGuide.length));
            }];
        } else {
            [_moreArticlesController.view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(height));
            }];
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        NSLog(@"%@", NSStringFromCGPoint(velocity));
            if (height <= self.view.bounds.size.height/2 || velocity.y >= 1000) {
                [_moreArticlesController.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(containerTopHeight));
                }];
                _isMoreNewsDrawerOpen = NO;
            } else if (height > 200) {
                [_moreArticlesController.view mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(self.view.bounds.size.height - self.topLayoutGuide.length));
                }];
                _isMoreNewsDrawerOpen = YES;
            }

        [UIView animateWithDuration:0.15 animations:^{
            [self.view layoutIfNeeded];
        }];

    }
}

-(void)moreArticlesTapped:(UITapGestureRecognizer *) recognizer {
    CGFloat containerTopHeight = _moreArticlesController.gripContainerView.bounds.size.height;

    if (_isMoreNewsDrawerOpen) {
        [_moreArticlesController.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(containerTopHeight));
        }];

        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
            [self.view layoutIfNeeded];

        } completion:nil];
    } else {
        [_moreArticlesController.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(self.view.bounds.size.height - self.topLayoutGuide.length));
        }];

        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            [self.view layoutIfNeeded];

        } completion:nil];
    }


    _isMoreNewsDrawerOpen = !_isMoreNewsDrawerOpen;
}

-(void)shareTapped:(UIBarButtonItem *)sender {
    Article *selectedArticle = [_articleDataSource articleAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0]];

    NSURL *url = selectedArticle.shareURL;

    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[selectedArticle.title, url] applicationActivities:nil];


    [self presentViewController:activityController animated:YES completion:nil];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(ArticleDetailViewController *)viewController {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ArticleDetailViewController *detailController = [mainStoryboard instantiateViewControllerWithIdentifier:@"articleDetailViewController"];
    detailController.type = ArticleDetailViewControllerTypeRegular;

    NSUInteger index = [_articleDataSource indexOfArticle:viewController.article];

    if (index == 0) {
        return nil;
    }

    detailController.article = [_articleDataSource articleAtIndexPath:[NSIndexPath indexPathForItem:index-1 inSection:0]];

    return detailController;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(ArticleDetailViewController *)viewController {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ArticleDetailViewController *detailController = [mainStoryboard instantiateViewControllerWithIdentifier:@"articleDetailViewController"];
    detailController.type = ArticleDetailViewControllerTypeRegular;
    NSUInteger index = [_articleDataSource indexOfArticle:viewController.article];

    if (index == [_articleDataSource numberOfItemsInSection:0]-1) {
        return nil;
    }

    detailController.article = [_articleDataSource articleAtIndexPath:[NSIndexPath indexPathForItem:index+1 inSection:0]];

    return detailController;
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    ArticleDetailViewController *previousController = (ArticleDetailViewController *)pendingViewControllers.firstObject;


    NSUInteger index = [_articleDataSource indexOfArticle:previousController.article];
    _nextIndex = index;
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed && finished) {
        ArticleDetailViewController *previousController = (ArticleDetailViewController *)previousViewControllers.firstObject;

        NSUInteger index = [_articleDataSource indexOfArticle:previousController.article];

        if (_nextIndex > index) {
            _viewModel.currentIndex = index + 2;
        } else {
            _viewModel.currentIndex = index;
        }

        _titleView.subtitleLabel.text = [_viewModel currentPageString];


        _currentIndex = index;
    }
}

-(void)backButtonTapped:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
