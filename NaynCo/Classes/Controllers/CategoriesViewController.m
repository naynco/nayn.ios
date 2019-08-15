//
//  CategoriesViewController.m
//  NaynCo
//
//  Created by Serra Bassarac on 03/04/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "CategoriesViewController.h"
#import "ArticlesViewController.h"
#import "Article.h"
#import "Category.h"
#import "SelectCategoryTableViewCell.h"
#import "GradientView.h"
#import "GradientColors.h"
#import "Category+Network.h"
#import "UIColor+Nayn.h"

@interface CategoriesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *filterResults;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) Category *selectedCategory;



@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [_closeButton addTarget:self
//                     action:@selector(closeMenu:)
//           forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Kapat" style:UIBarButtonItemStylePlain target:self action:@selector(closeMenu:)];
    self.navigationItem.rightBarButtonItem = closeButton;
    
    
    [Category getCategoriesWithBlock:^(NSArray<Category *> *categories, NSError *error) {
        
        _categories = [categories sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSNumber *first = [(Category*)obj1 identifier];
            NSNumber *second = [(Category*)obj2 identifier];
            return [first compare:second];
        }];
        [_tableView reloadData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CGFloat availableHeight = self.view.bounds.size.height;
    
    return availableHeight/(_categories.count+1);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_categories.count == 0) {
        return 0;
    }
    
    return _categories.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectCategoryTableViewCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    
    
    if (indexPath.row == 0) {
        categoryCell.categoryLabel.text = @"TÜMÜ";

        [(CAGradientLayer *)categoryCell.backgroundGradientView.layer setColors:@[
                                                                                  (id)[UIColor blackColor].CGColor,
                                                                                  (id)[UIColor blackColor].CGColor
                                                                                  ]];
    } else {
        Category *category = _categories[indexPath.row-1];
        categoryCell.categoryLabel.text = category.name;

        UIColor *startColor = [UIColor colorWithHexString:category.gradientStartColor];
        UIColor *endColor = [UIColor colorWithHexString:category.gradientEndColor];

        [(CAGradientLayer *)categoryCell.backgroundGradientView.layer setColors:@[
                                                                                  (id)startColor.CGColor,
                                                                                  (id)endColor.CGColor
                                                                                  ]];

    }


    [(CAGradientLayer *)categoryCell.backgroundGradientView.layer setStartPoint:CGPointMake(-0.1, 0.5)];
    [(CAGradientLayer *)categoryCell.backgroundGradientView.layer setEndPoint:CGPointMake(1.1, 0.5)];
    
    return categoryCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        if (_delegate != nil && [_delegate respondsToSelector:@selector(didRemoveCategory)]) {
            [_delegate didRemoveCategory];
        }
    } else {
        Category *selectedCategory = [_categories objectAtIndex:indexPath.row-1];
        
        if (_delegate != nil && [_delegate respondsToSelector:@selector(didSelectCategory:)]) {
            [_delegate didSelectCategory:selectedCategory];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)closeMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
