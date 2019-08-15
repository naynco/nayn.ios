//
//  ArticleDescriptionCollectionViewCell.h
//  NaynCo
//
//  Created by Serra Bassarac on 23/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import "ArticleDetailBaseCollectionViewCell.h"

@interface ArticleDetailTextCollectionViewCell : ArticleDetailBaseCollectionViewCell
@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@end
