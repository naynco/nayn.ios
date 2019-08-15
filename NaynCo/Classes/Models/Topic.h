//
//  Topic.h
//  NaynCo
//
//  Created by Serra Bassarac on 15/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <Mantle/Mantle.h>

@class Article;

@interface Topic : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSURL *imageURL;
@property (nonatomic, copy, readonly) NSString *topicDescription;
@property (nonatomic, copy, readonly) NSArray <Article *> *articles;



@end
