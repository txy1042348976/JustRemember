//
//  AppDelegate.m
//  JustRemember
//
//  Created by rising on 16/5/24.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"
#import "addBillController.h"
#import "SystemDefine.h"

#pragma mark - 手势
#import "TouchIdUnlock.h"           //指纹解锁
#import "GestureLockScreen.h"       //手势锁屏
#import "GestureTool_Public.h"      //手势工具

@interface AppDelegate ()
@property (nonatomic, strong) NSUserDefaults *myDefaults;
@end

@implementation AppDelegate

/**
 初始化 主界面
// */
//- (void)init_MainUI
//{
//    HomeController * vc = [[HomeController alloc] init];
//    
//    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController: vc];
//    
//    self.window.rootViewController = nav;
//    [self.window makeKeyAndVisible];
//
//}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor whiteColor];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    
    HomeController *HomeVc = [[HomeController alloc] init];
    UINavigationController *Nav = [[UINavigationController alloc] initWithRootViewController:HomeVc];
    self.window.rootViewController = Nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}





- (void)application:(UIApplication *)application
performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem
  completionHandler:(void(^)(BOOL succeeded))completionHandler{

        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        addBillController *detailVC = [[addBillController alloc] init];
        if ([shortcutItem.type isEqualToString:@"UITouchText.jiyibi"]) {
            [nav pushViewController:detailVC animated:YES];
    }

    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    /**
     验证手势密码 －－－ OYXJ on 2015-08-04
     */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * num = [defaults objectForKey:KEY_UserDefaults_isGestureLockEnabledOrNotByUser];
    BOOL isGestureLockEnabledOrNotByUser = [num boolValue];
    BOOL isHasGestureSavedInNSUserDefaults = [GestureTool_Public isHasGesturePwdStringWhichSavedInNSUserDefaults];
    if (isGestureLockEnabledOrNotByUser &&
        isHasGestureSavedInNSUserDefaults)
    {
        [[GestureLockScreen sharedInstance] showGestureWindowByType: GestureLockScreenTypeGesturePwdVerify];
    }
    
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    /**
     验证手势密码 －－－ OYXJ on 2015-08-04
     */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * num = [defaults objectForKey:KEY_UserDefaults_isGestureLockEnabledOrNotByUser];
    BOOL isGestureLockEnabledOrNotByUser = [num boolValue];
    BOOL isHasGestureSavedInNSUserDefaults = [GestureTool_Public isHasGesturePwdStringWhichSavedInNSUserDefaults];
    if (isGestureLockEnabledOrNotByUser &&
        isHasGestureSavedInNSUserDefaults)
    {
        [[GestureLockScreen sharedInstance] showGestureWindowByType: GestureLockScreenTypeGesturePwdVerify];
        
        BOOL canVerifyTouchID = [[TouchIdUnlock sharedInstance] canVerifyTouchID];
        if (canVerifyTouchID) {
            [[TouchIdUnlock sharedInstance] startVerifyTouchID:^{
                [[GestureLockScreen sharedInstance] hide];
            }];
        }
    }
    
}

@end
