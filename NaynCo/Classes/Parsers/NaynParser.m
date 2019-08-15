//
//  NaynParser.m
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 14.05.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "NaynParser.h"
#import <HTMLKit/HTMLKit.h>
#import "HTMLImage.h"
#import "HTMLGiphyGIF.h"
#import <NSAttributedString_DDHTML/NSAttributedString+DDHTML.h>
#import <TwitterKit/TWTRKit.h>
#import "HTMLTweet.h"

@interface NaynParser ()

@end

@implementation NaynParser

-(void)parseArticleDetailHTML:(NSString *)HTMLString {

    _contentArray = [NSMutableArray array];

    HTMLParser *parser = [[HTMLParser alloc] initWithString: HTMLString];
    HTMLElement *bodyContext = [[HTMLElement alloc] initWithTagName:@"body"];
    NSArray *nodes = [parser parseFragmentWithContextElement:bodyContext];

    for (HTMLNode *node in nodes) {
        NSLog(@"%@", node.outerHTML);

        [self parseNode:node];
    }

    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(parsingDidFinishWithContent:)]) {
        [self.delegate parsingDidFinishWithContent:[_contentArray copy]];
    }
}

-(void)parseNode:(HTMLNode *)node {
    if (node.childNodesCount > 0) {
        for (HTMLNode *innerNode in node.childNodes) {
            [self parseNode:innerNode];
        }
    } else {
        if ([node isKindOfClass:[HTMLText class]]) {
            if ([(HTMLText *)node textContent] == nil || [[(HTMLText *)node textContent] isEqualToString:@"\n"]) {
                return;
            }

            if ([node.parentElement.tagName isEqualToString:@"iframe"]) {
                NSString *source = node.parentElement.attributes[@"src"];
                NSURL *gifURL = [NSURL URLWithString:source];
                if ([[gifURL host] isEqualToString:@"giphy.com"]) {

                    HTMLGiphyGIF *gif = [[HTMLGiphyGIF alloc] initWithID:[gifURL pathComponents].lastObject];
                    [_contentArray addObject:gif];

                    return;
                }
            }

            if ([node.parentElement.parentElement.tagName isEqualToString:@"blockquote"]) {
                NSString *source = node.parentElement.parentElement.attributes[@"class"];

                if ([source isEqualToString:@"twitter-tweet"]) {
                    for (HTMLNode *twitterNodes in node.parentElement.childNodes) {
                        if ([twitterNodes isKindOfClass:[HTMLElement class]]) {
                            HTMLElement *linkElement = (HTMLElement *)twitterNodes;
                            if ([linkElement.tagName isEqualToString:@"a"]) {
                                NSString *tweetLink = linkElement.attributes[@"href"];

                                if ([[NSURL URLWithString:tweetLink].host isEqualToString:@"twitter.com"]) {
                                    NSString *tweetID = [[[tweetLink lastPathComponent] componentsSeparatedByString:@"?"] firstObject];
                                    [_contentArray addObject:[[HTMLTweet alloc] initWithTweetID:tweetID]];
                                }
                            }
                        }
                    }
                }
                return;

            }

            if ([[(HTMLElement *)node.parentNode tagName] isEqualToString:@"p"] || [[(HTMLElement *)node.parentNode tagName] isEqualToString:@"strong"]) {
                NSAttributedString *attrString = [NSAttributedString attributedStringFromHTML:[(HTMLText *)node parentNode].outerHTML normalFont:[UIFont fontWithName:@"GTAmerica-Regular" size:18.0] boldFont:[UIFont fontWithName:@"GTAmerica-Black" size:18.0] italicFont:[UIFont fontWithName:@"GTAmerica-RegularItalic" size:18.0]];

                NSMutableAttributedString *mutableAttrString = [[NSMutableAttributedString alloc] initWithAttributedString:attrString];
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                paragraphStyle.alignment = NSTextAlignmentLeft;
                paragraphStyle.hyphenationFactor = 0.8;
                paragraphStyle.minimumLineHeight = 29;
                paragraphStyle.maximumLineHeight = 29;
                paragraphStyle.paragraphSpacing = 20;

                [mutableAttrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mutableAttrString.length)];

                [_contentArray addObject:[[NSAttributedString alloc] initWithAttributedString:mutableAttrString]];
            }

        } else if ([node isKindOfClass:[HTMLElement class]]) {
            HTMLElement *element = (HTMLElement *)node;

            if ([element.tagName isEqualToString:@"blockquote"]) {

            } else if ([element.tagName isEqualToString:@"img"]) {
                HTMLImage *image = [[HTMLImage alloc] init];
                NSURL *imageURL = [NSURL URLWithString:element.attributes[@"src"]];
                if (imageURL) {
                    image.imageURL = imageURL;
                }
                NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
                nf.numberStyle = NSNumberFormatterDecimalStyle;
                image.imageWidth = [nf numberFromString:element.attributes[@"width"]];
                image.imageHeight = [nf numberFromString:element.attributes[@"height"]];

                [_contentArray addObject:image];
            }


        }
    }
}



@end
