//
//  Category.h
//  NaynCo
//
//  Created by Serra Bassarac on 03/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <Foundation/Foundation.h>

@interface Category : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *identifier;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *gradientStartColor;
@property (nonatomic, copy, readonly) NSString *gradientEndColor;

@end
