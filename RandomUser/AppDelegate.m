//
//  AppDelegate.m
//  RandomUser
//
//  Created by Jun Luo on 2014-07-13.
//  Copyright (c) 2014 Jun Luo. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataHelper.h"
#import "RandomUserModelConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)initialize {
    [CoreDataHelper setupDefaultsWithModelName:kRandomUserModel storeName:kRandomUserStore];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    splitViewController.delegate = (id)navigationController.topViewController;
    return YES;
}

@end
