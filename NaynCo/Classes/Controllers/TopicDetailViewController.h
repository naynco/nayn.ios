//
//  TopicDetailViewController.h
//  NaynCo
//
//  Created by Serra Bassarac on 15/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Topic;

@interface TopicDetailViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout>

@property (nonatomic) Topic *topic;

@end
