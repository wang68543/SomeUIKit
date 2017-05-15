//
//  AppDelegate.m
//  SomeUIKit
//
//  Created by WangQiang on 2016/10/20.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "WQNavViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *viewController = [[ViewController alloc] init];
    WQNavViewController *nav = [[WQNavViewController alloc] initWithRootViewController:viewController];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return YES;
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return YES;
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return YES;
}
-(void)applicationWillEnterForeground:(UIApplication *)application{
    
}

-(void)applicationDidBecomeActive:(UIApplication *)application{
    
}
@end
