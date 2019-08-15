//
//  ViewController.m
//  NaynCo
//
//  Created by Serra Bassarac on 01/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "ArticlesViewController.h"
#import <Mantle/Mantle.h>
#import "Article.h"

@interface ArticlesViewController ()

@end

@implementation ArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"articles" ofType:@"json"];
    NSData *articlesData = [NSData dataWithContentsOfFile:path];
    NSDictionary *articlesDict = [NSJSONSerialization JSONObjectWithData:articlesData options:kNilOptions error:nil];
    NSError *error;
    NSArray *articles = [MTLJSONAdapter modelsOfClass:Article.class fromJSONArray:articlesDict[@"articles"] error:&error];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
