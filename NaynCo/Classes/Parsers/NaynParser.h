//
//  NaynParser.h
//  NaynCo
//
//  Created by Seyfeddin Bassarac on 14.05.2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol NaynParserDelegate <NSObject>
@required
-(void)parsingDidFinishWithContent:(NSArray *)contentArray;

@end

@interface NaynParser : NSObject

@property (nonatomic) NSMutableArray *contentArray;

@property (nonatomic, weak) id<NaynParserDelegate> delegate;

-(void)parseArticleDetailHTML:(NSString *)HTMLString;

@end
