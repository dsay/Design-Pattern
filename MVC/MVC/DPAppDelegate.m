//
//  DPAppDelegate.m
//  MVC
//
//  Created by Dima on 5/16/14.
//  Copyright (c) 2014 Dima Sai. All rights reserved.
//
//CGRect rect = {
//    .origin.x = 3.0,
//    .origin.y = 12.0,
//    .size.width = 15.0,
//    .size.height = 80.0 };
//
//if (!self.model) {
//    self.model = ({
//        DPLoginM *model = [DPLoginM new];
//        model;
//    });
//}

#import "DPAppDelegate.h"

#import "DPLoginC.h"
#import "DPLoginM.h"
#import "DPApiClient.h"

@implementation DPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    DPLoginC *loginVC = [DPLoginC new];
    DPLoginM *model = [DPLoginM new];
    loginVC.model = model;
    
    self.navigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.navigation.navigationBar.tintColor = [UIColor redColor];
    
    self.window.rootViewController = self.navigation;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
