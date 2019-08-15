//
//  AppDelegate.m
//  NaynCo
//
//  Created by Serra Bassarac on 01/03/2018.
//  Copyright © 2018 Serra Bassarac. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <GoogleAnalytics/GAI.h>
#import <Firebase.h>
#import <TwitterKit/TWTRKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <UserNotifications/UserNotifications.h>
#import <FirebaseMessaging/FirebaseMessaging.h>
#import <GiphyCoreSDK/GiphyCoreSDK-Swift.h>
#import "Article.h"
#import "ArticleDetailViewController.h"
#import "ArticleDetailContainerViewController.h"
#import "ArticleDataSource.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate, FIRMessagingDelegate>

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    [FIRMessaging messaging].delegate = self;
    
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Fabric with:@[[Crashlytics class]]];
    
    [GiphyCore configureWithApiKey:@""];

    [[TWTRTwitter sharedInstance] startWithConsumerKey:@"" consumerSecret:@""];

    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];

    GAI *gai = [GAI sharedInstance];
    [gai trackerWithTrackingId:@"UA-26162600-3"];
    
    // Optional: automatically report uncaught exceptions.
    gai.trackUncaughtExceptions = YES;
    
    // Optional: set Logger to VERBOSE for debug information.
    // Remove before app release.
    gai.logger.logLevel = kGAILogLevelVerbose;
    
    [FIRApp configure];

    UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
    UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
    [[UNUserNotificationCenter currentNotificationCenter]
     requestAuthorizationWithOptions:authOptions
     completionHandler:^(BOOL granted, NSError * _Nullable error) {
         // ...
     }];

    [application registerForRemoteNotifications];

    if (launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey] != nil) {
        NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        NSLog(@"%@", userInfo);
        NSString *articleID = userInfo[@"news_id"];
        [self showArticleDetailFromNotificationWithID:articleID];
    }


    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    // Add any custom logic here.
    return handled;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [FIRMessaging messaging].APNSToken = deviceToken;

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];

    NSString *articleID = userInfo[@"news_id"];
    [self showArticleDetailFromNotificationWithID:articleID];


    // Print full message.
    NSLog(@"%@", userInfo);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {


    // Print full message.
    NSLog(@"%@", userInfo);

    NSString *articleID = userInfo[@"news_id"];

    [self showArticleDetailFromNotificationWithID:articleID];

    completionHandler(UIBackgroundFetchResultNewData);
}

-(void)showArticleDetailFromNotificationWithID:(NSString *)articleID {

    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterDecimalStyle;

    NSError *error;
    Article *selectedArticle = [[Article alloc] initWithDictionary:@{@"identifier" : [nf numberFromString:articleID]} error:&error];

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ArticleDetailViewController *detailController = [mainStoryboard instantiateViewControllerWithIdentifier:@"articleDetailViewController"];
    detailController.type = ArticleDetailViewControllerTypeFromNotification;
    detailController.article = selectedArticle;

    ArticleDetailContainerViewController *containerController = [[ArticleDetailContainerViewController alloc] initWithDetailController:detailController];
    ArticleDataSource *dataSource = [[ArticleDataSource alloc] init];
    dataSource.articles = @[selectedArticle];
    containerController.articleDataSource = dataSource;

    [(UINavigationController *)self.window.rootViewController pushViewController:containerController animated:YES];
}

//MARK:- FIRMessagingDelegate
-(void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {

}

-(void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    NSLog(@"FCM registration token: %@", fcmToken);
}


@end
