//
//  Images.h
//  NaynCo
//
//  Created by Serra Bassarac on 01/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ArticleImage : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString * _Nullable large;
@property (nonatomic, copy, readonly) NSString * _Nullable medium;
@property (nonatomic, copy, readonly) NSString * _Nullable thumbnail;


@end
