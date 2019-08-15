//
//  ArticleDetailViewController.m
//  NaynCo
//
//  Created by Serra Bassarac on 20/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import "ArticleDetailHeaderCollectionViewCell.h"
#import "ArticleDetailTitleCollectionViewCell.h"
#import "ArticleDetailTextCollectionViewCell.h"
#import "ArticleDetailGiphyCollectionViewCell.h"
#import "ArticleDetailTweetCollectionViewCell.h"
#import "ArticleDetailImageCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Article.h"
#import "ArticleImage.h"
#import "Category.h"
#import "GradientColors.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import <GoogleToolboxForMac/GTMNSString+HTML.h>
#import "NaynParser.h"
#import "HTMLImage.h"
#import "HTMLGiphyGIF.h"
#import "UIColor+Nayn.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>
#import <GiphyCoreSDK/GiphyCoreSDK-Swift.h>
#import "Article+Network.h"
#import "HTMLTweet.h"
#import <TwitterKit/TWTRKit.h>
#import <FLAnimatedImage/FLAnimatedImage.h>
#import <SafariServices/SafariServices.h>
#import "NSAttributedString+Nayn.h"
#import "UIFont+Additions.h"
#import "NSString+Encoding.h"

@interface ArticleDetailViewController () <WKNavigationDelegate, FBSDKSharingDelegate, TWTRTweetViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSNumber *calculatedContentHeight;

@property (nonatomic) NaynParser *parser;
@property (nonatomic) NSArray *contentArray;

@end

@implementation ArticleDetailViewController {
    BOOL _didCalculateHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _didCalculateHeight = NO;
    
    [self registerNIBs];

    _collectionView.contentInset = UIEdgeInsetsZero;
    [(UICollectionViewFlowLayout *)_collectionView.collectionViewLayout setSectionInset:UIEdgeInsetsZero];
    
    [(UICollectionViewFlowLayout *)_collectionView.collectionViewLayout setEstimatedItemSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)];

    _parser = [[NaynParser alloc] init];

    if (_type == ArticleDetailViewControllerTypeRegular) {
        [self prepareInterface];
    } else {
        [self loadData];
    }
}

-(void)registerNIBs {
    UINib *headerCellNib = [UINib nibWithNibName:@"ArticleDetailHeaderCollectionViewCell" bundle:nil];

    [_collectionView registerNib:headerCellNib forCellWithReuseIdentifier:@"HeaderCell"];

    UINib *titleCellNib = [UINib nibWithNibName:@"ArticleDetailTitleCollectionViewCell" bundle:nil];

    [_collectionView registerNib:titleCellNib forCellWithReuseIdentifier:@"TitleCell"];

    UINib *descriptionCellNib = [UINib nibWithNibName:@"ArticleDetailTextCollectionViewCell" bundle:nil];

    [_collectionView registerNib:descriptionCellNib forCellWithReuseIdentifier:@"DescriptionCell"];

    UINib *imageCellNib = [UINib nibWithNibName:@"ArticleDetailImageCollectionViewCell" bundle:nil];

    [_collectionView registerNib:imageCellNib forCellWithReuseIdentifier:@"ImageCell"];

    UINib *giphyCellNib = [UINib nibWithNibName:@"ArticleDetailGiphyCollectionViewCell" bundle:nil];

    [_collectionView registerNib:giphyCellNib forCellWithReuseIdentifier:@"GiphyCell"];

    UINib *twitterCellNib = [UINib nibWithNibName:@"ArticleDetailTweetCollectionViewCell" bundle:nil];

    [_collectionView registerNib:twitterCellNib forCellWithReuseIdentifier:@"TweetCell"];
}

-(void)loadData {
    [Article getArticleDetail:_article withBlock:^(Article *article, NSError *error) {
        if (error == nil) {
            _article = article;
            [self prepareInterface];
        } else {

        }
    }];
}

-(void)prepareInterface {
    [_parser parseArticleDetailHTML:_article.content];

    _contentArray = [NSArray arrayWithArray:_parser.contentArray];

    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];

    [_collectionView reloadData];

    [_collectionView setContentInset:UIEdgeInsetsMake(_collectionView.contentInset.top, _collectionView.contentInset.left, _collectionView.contentInset.bottom + 64, _collectionView.contentInset.right)];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (_contentArray != nil && _contentArray.count > 0) {
        return 2+_contentArray.count;
    }

    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ArticleDetailHeaderCollectionViewCell *headerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderCell" forIndexPath:indexPath];
        
        [headerCell.articleHeaderImage sd_setImageWithURL:[NSURL URLWithString:[_article.images.large stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]]];

        return headerCell;
    } else if(indexPath.section == 1) {
        ArticleDetailTitleCollectionViewCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TitleCell" forIndexPath:indexPath];

        Category *category = _article.categories.firstObject;
        
        titleCell.categoryLabel.text = category.name;

        [titleCell.whatsappButton addTarget:self action:@selector(whatsAppTapped:) forControlEvents:UIControlEventTouchUpInside];
        [titleCell.facebookButton addTarget:self action:@selector(facebookTapped:) forControlEvents:UIControlEventTouchUpInside];
        [titleCell.twitterButton addTarget:self action:@selector(twitterTapped:) forControlEvents:UIControlEventTouchUpInside];
        [titleCell.messengerButton addTarget:self action:@selector(messengerTapped:) forControlEvents:UIControlEventTouchUpInside];


        if (category.gradientStartColor) {
            UIColor *startColor = [UIColor colorWithHexString:category.gradientStartColor];
            UIColor *endColor = [UIColor colorWithHexString:category.gradientEndColor];

            [(CAGradientLayer *)titleCell.categoryBackgroundView.layer setColors:@[
                                                                              (id)startColor.CGColor,
                                                                              (id)endColor.CGColor
                                                                              ]];
        } else {
            [(CAGradientLayer *)titleCell.categoryBackgroundView.layer setColors:@[
                                                                              (id)[UIColor naynYellowColor].CGColor,
                                                                              (id)[UIColor naynYellowColor].CGColor
                                                                              ]];
        }

        
        [(CAGradientLayer *)titleCell.categoryBackgroundView.layer setStartPoint:CGPointMake(-0.1, -0.1)];
        [(CAGradientLayer *)titleCell.categoryBackgroundView.layer setEndPoint:CGPointMake(1.1, 1.1)];
        
        NSString *unescapedTitle = [_article.title gtm_stringByUnescapingFromHTML];

        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.maximumLineHeight = 35;
        paragraphStyle.minimumLineHeight = 35;
        paragraphStyle.alignment = NSTextAlignmentLeft;

        NSAttributedString *attrTitle = [NSAttributedString articleTitleAttributedString:unescapedTitle font:[UIFont articleTitleFont] color:[UIColor darkTitleColor]];
        
        titleCell.descriptionTitle.attributedText = attrTitle;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"d MMMM yyyy, EEEE hh:mm"];
        NSString *createdAt = [dateFormatter stringFromDate:_article.createdAt];
        
        titleCell.timeLabel.text = createdAt;
        
        return titleCell;
    } else {

        id content = _contentArray[indexPath.section-2];

        if ([content isKindOfClass:[HTMLImage class]]) {
            HTMLImage *image = (HTMLImage *)content;
            ArticleDetailImageCollectionViewCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];

            [imageCell.imageView sd_setImageWithURL:image.imageURL];
            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
            imageCell.imageViewHeightConstraint.constant = screenWidth*image.imageHeight.floatValue/image.imageWidth.floatValue;

            return imageCell;
        } else if ([content isKindOfClass:[HTMLGiphyGIF class]]) {
            HTMLGiphyGIF *gif = (HTMLGiphyGIF *)content;

            ArticleDetailGiphyCollectionViewCell *giphyCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GiphyCell" forIndexPath:indexPath];

            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;

            __weak typeof(giphyCell)weakCell = giphyCell;
            [[GiphyCore shared] gifByID:gif.gifID completionHandler:^(GPHMediaResponse * _Nullable response, NSError * _Nullable error) {

                __strong __typeof(weakCell)strongCell = weakCell;

                GPHImage *image = response.data.images.original;

                FLAnimatedImage *gifImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image.gifUrl]]];

                dispatch_async(dispatch_get_main_queue(), ^{

                    [strongCell.animatedImageView setAnimatedImage:gifImage];
                    strongCell.imageViewHeightConstraint.constant = screenWidth*image.height/image.width;
                });


            }];

            return giphyCell;
        } else if ([content isKindOfClass:[HTMLTweet class]]) {
            HTMLTweet *tweet = (HTMLTweet *)content;

            TWTRAPIClient *client = [[TWTRAPIClient alloc] init];

            ArticleDetailTweetCollectionViewCell *tweetCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TweetCell" forIndexPath:indexPath];
            
            [tweetCell.tweetView setDelegate:self];
            [client loadTweetWithID:tweet.tweetID completion:^(TWTRTweet * _Nullable tweet, NSError * _Nullable error) {
                if (tweet) {
                    [tweetCell.tweetView configureWithTweet:tweet];
                    CGSize tweetSize = [tweetCell.tweetView sizeThatFits:CGSizeMake(collectionView.frame.size.width-32, 20000)];
                    tweetCell.tweetViewHeightConstraint.constant = tweetSize.height;
                }
            }];

            return tweetCell;

        } else if ([content isKindOfClass:[NSAttributedString class]]) {
            ArticleDetailTextCollectionViewCell *descriptionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DescriptionCell" forIndexPath:indexPath];

            descriptionCell.textLabel.attributedText = (NSAttributedString *)content;

            return descriptionCell;
        }
        
        ArticleDetailTextCollectionViewCell *descriptionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DescriptionCell" forIndexPath:indexPath];
        return descriptionCell;
    }
    
}

//MARK: - IBActions
-(void)whatsAppTapped:(UIButton *)sender {
    NSURL *whatsappURL = [NSURL URLWithString:[[NSString stringWithFormat:@"whatsapp://send?text=%@ %@", _article.title, _article.shareURL.absoluteString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if ([[UIApplication sharedApplication] canOpenURL:whatsappURL]) {
        [[UIApplication sharedApplication] openURL:whatsappURL options:@{} completionHandler:nil];
    }
}

-(void)facebookTapped:(UIButton *)sender {
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = _article.shareURL;
    [FBSDKShareDialog showFromViewController:self withContent:content delegate:self];
}

-(void)twitterTapped:(UIButton *)sender {
    NSURL *twitterURL = [NSURL URLWithString:[[NSString stringWithFormat:@"twitter://post?message=%@ %@", _article.title, _article.shareURL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if ([[UIApplication sharedApplication] canOpenURL: twitterURL]) {
        [[UIApplication sharedApplication] openURL: twitterURL options:@{} completionHandler:nil];
    }
}

-(void)messengerTapped:(UIButton *)sender {
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = _article.shareURL;
    [FBSDKMessageDialog showWithContent:content delegate:self];
}

//MARK: FBSDKSharingDelegate

/**
 Sent to the delegate when the share completes without error or cancellation.
 - Parameter sharer: The FBSDKSharing that completed.
 - Parameter results: The results from the sharer.  This may be nil or empty.
 */
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {

}

/**
 Sent to the delegate when the sharer encounters an error.
 - Parameter sharer: The FBSDKSharing that completed.
 - Parameter error: The error.
 */
- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {

}

/**
 Sent to the delegate when the sharer is cancelled.
 - Parameter sharer: The FBSDKSharing that completed.
 */
- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    
}

//MARK: - TWTRTweetViewDelegate
-(void)tweetView:(TWTRTweetView *)tweetView didTapTweet:(TWTRTweet *)tweet {
    
}

-(void)tweetView:(TWTRTweetView *)tweetView didTapURL:(NSURL *)url {
    SFSafariViewController *safariController = [[SFSafariViewController alloc] initWithURL:url];

    safariController.preferredBarTintColor = [UIColor blackColor];
    safariController.preferredControlTintColor = [UIColor naynYellowColor];

    [self presentViewController:safariController animated:YES completion:nil];
}

@end
