//
//  CategoriesViewController.h
//  NaynCo
//
//  Created by Serra Bassarac on 03/04/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Category;

@protocol CategoryViewControllerDelegate <NSObject>

-(void)didSelectCategory:(Category *)category;
-(void)didRemoveCategory;

@end

@interface CategoriesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *articles;

@property (weak, nonatomic) id<CategoryViewControllerDelegate> delegate;


@end
