//
//  AppDelegate.m
//  MiGongYi
//
//  Created by megil on 9/3/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "BlackMagic.h"
#import "MGYTabBarController.h"
#import "UIImageView+WebCache.h"
#import "MGYStoryPlayer.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUInteger downloaderOptions = 0;
    
    downloaderOptions |= SDWebImageDownloaderLowPriority;
    NSLog(@"a%d", downloaderOptions);
    downloaderOptions |= SDWebImageDownloaderProgressiveDownload;
    NSLog(@"a%d", downloaderOptions);
    downloaderOptions |= SDWebImageDownloaderUseNSURLCache;
    NSLog(@"a%d", downloaderOptions);
    downloaderOptions |= SDWebImageDownloaderContinueInBackground;
    NSLog(@"a%d", downloaderOptions);
    downloaderOptions |= SDWebImageDownloaderHandleCookies;
    NSLog(@"a%d", downloaderOptions);
    downloaderOptions |= SDWebImageDownloaderAllowInvalidSSLCertificates;
    NSLog(@"a%d", downloaderOptions);
    downloaderOptions |= SDWebImageDownloaderHighPriority;
    NSLog(@"a%d", downloaderOptions);
    downloaderOptions &= ~SDWebImageDownloaderProgressiveDownload;
    NSLog(@"a%d", downloaderOptions);
    downloaderOptions |= SDWebImageDownloaderIgnoreCachedResponse;
    NSLog(@"a%d", downloaderOptions);

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [BlackMagic blackMagicAFJSONResponseSerializer];
    MGYTabBarController *bar = [[MGYTabBarController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = bar;
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [MGYStoryPlayer enterBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [MGYStoryPlayer outBackground];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
