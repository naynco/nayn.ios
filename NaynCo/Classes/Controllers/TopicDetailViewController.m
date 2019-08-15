//
//  TopicDetailViewController.m
//  NaynCo
//
//  Created by Serra Bassarac on 15/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "TopicDetailCollectionViewCell.h"
#import "TopicDescriptionCollectionViewCell.h"
#import "TopicTimelineCollectionViewCell.h"
#import "AFIndexedCollectionView.h"
#import "Topic.h"
#import "Article.h"
#import "ArticleImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+Nayn.h"

@interface TopicDetailViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSArray *articles;


@end

@implementation TopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _articles = [_topic.articles copy];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nayn-navigation-logo"]];
    
    self.navigationItem.titleView = imageView;
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                 target:self
                                                                                 action:nil];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    _collectionView.contentInset = UIEdgeInsetsZero;
    [(UICollectionViewFlowLayout *)_collectionView.collectionViewLayout setSectionInset:UIEdgeInsetsZero];
    
    [(UICollectionViewFlowLayout *)_collectionView.collectionViewLayout setEstimatedItemSize:CGSizeMake(1, 1)];

    UINib *topicCellNib = [UINib nibWithNibName:@"TopicDetailCollectionViewCell" bundle:nil];
    
    [_collectionView registerNib:topicCellNib forCellWithReuseIdentifier:@"TopicCell"];
    
    UINib *descriptionCellNib = [UINib nibWithNibName:@"TopicDescriptionCollectionViewCell" bundle:nil];
    
    [_collectionView registerNib:descriptionCellNib forCellWithReuseIdentifier:@"DescriptionCell"];
    
    UINib *timelineCellNib = [UINib nibWithNibName:@"TopicTimelineCollectionViewCell" bundle:nil];
    
    [_collectionView registerNib:timelineCellNib forCellWithReuseIdentifier:@"TimelineCell"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == _collectionView) {
        return 3;
    }
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 2) {
        return _articles.count;
    } else {
        return 1;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 0) {
            TopicDetailCollectionViewCell *topicCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopicCell" forIndexPath:indexPath];
            
            
            [topicCell.topicImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _topic.imageURL]]];
            
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            
            [paragraph setMinimumLineHeight:48];
            [paragraph setMaximumLineHeight:48];
            
            paragraph.alignment = NSTextAlignmentCenter;
            
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:_topic.title attributes:@{
                                                                                                                  NSFontAttributeName : [UIFont systemFontOfSize:46 weight:UIFontWeightHeavy],
                                                                                                                  NSForegroundColorAttributeName : [UIColor topicBigTitleColor],
                                                                                                                  NSParagraphStyleAttributeName : paragraph
                                                                                                                  }];
            
            topicCell.topicLabel.attributedText = attrString;
            return topicCell;
            
        }else if (indexPath.section == 1) {
            TopicDescriptionCollectionViewCell *descriptionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DescriptionCell" forIndexPath:indexPath];
            
            descriptionCell.descriptionLabel.text = _topic.topicDescription;
            
            return descriptionCell;
        }else {
            TopicTimelineCollectionViewCell *timelineCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TimelineCell" forIndexPath:indexPath];
            
            
            Article *article = _articles[indexPath.row];
            
            [timelineCell.topicTimelineImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", article.images.thumbnail]]];
            
            timelineCell.topicTimelineLabel.text = article.title;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"d MMMM yyyy, EEEE hh:mm"];
            NSString *createdAt = [dateFormatter stringFromDate:article.createdAt];
            
            timelineCell.topicTimelineDateLabel.text = createdAt;
            
            return timelineCell;
        }
    
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
