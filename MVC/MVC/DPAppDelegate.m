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

#import "DPLoginViewController.h"
#import "DPLoginModel.h"
#import "DPApiClient.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "DPManagerProvider.h"

@implementation DPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [self loginStub];
    [self friendsStub];
    
    DPLoginViewController *loginVC = [DPLoginViewController new];
    DPManagerProvider *provider = [DPManagerProvider new];
    DPLoginModel *model = [[DPLoginModel alloc]initWithManagerProvider:provider];
    loginVC.model = model;
    
    self.navigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.navigation.navigationBar.tintColor = [UIColor redColor];
    
    self.window.rootViewController = self.navigation;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)loginStub
{
    id<OHHTTPStubsDescriptor> loginStub = nil;
    loginStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:@"http://www.mvc.com/demos/login?email=www%40www.www&password=wwwwww"];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        return [[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"login.txt",nil)
                                                  statusCode:200
                                                     headers:@{@"Content-Type":@"text/plain"}]
                
                
                requestTime:1.f
                responseTime:OHHTTPStubsDownloadSpeedWifi];
    }];
    loginStub.name = @"Login stub";
}

- (void)friendsStub
{
    id<OHHTTPStubsDescriptor> friendsStub = nil;
    friendsStub = [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:@"http://www.mvc.com/demos/friends?userID=1"];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        return [[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"friends.txt",nil)
                                                 statusCode:200
                                                    headers:@{@"Content-Type":@"text/plain"}]
                
                
                requestTime:2.f
                responseTime:OHHTTPStubsDownloadSpeedWifi];
    }];
    friendsStub.name = @"Friends Stub";
}

@end
