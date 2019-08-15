//
//  MoreArticlesViewController.m
//  NaynCo
//
//  Created by Serra Bassarac on 5.10.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "MoreArticlesViewController.h"
#import "MoreArticlesTableViewCell.h"
#import "ArticleDataSource.h"
#import "Article.h"
#import "ArticleImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MoreArticlesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MoreArticlesViewController

-(void)setDataSource:(ArticleDataSource *)dataSource {
    _dataSource = dataSource;

    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 88.0;

}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MoreArticlesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Article *article = [_dataSource articleAtIndexPath:indexPath];
    cell.articleTitle.text = article.title;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d MMMM yyyy, EEEE hh:mm"];
    NSString *createdAt = [dateFormatter stringFromDate:article.createdAt];
    cell.dateLabel.text = createdAt;

    [cell.articleImage sd_setImageWithURL:[NSURL URLWithString:[article.images.medium stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource numberOfItemsInSection:section];
}




@end
