//
//  NYNNavigationController.m
//  NaynCo
//
//  Created by Serra Bassarac on 20/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "NYNNavigationController.h"

@interface NYNNavigationController ()

@end

@implementation NYNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    if (self.topViewController.preferredStatusBarUpdateAnimation != UIStatusBarAnimationNone) {
        return self.topViewController.preferredStatusBarUpdateAnimation;
    } else {
        return UIStatusBarAnimationFade;
    }
}

@end
