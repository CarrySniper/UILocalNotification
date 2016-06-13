//
//  AppDelegate.m
//  UILocalNotification
//
//  Created by 思久科技 on 16/6/13.
//  Copyright © 2016年 Seejoys. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //注册通知
    [self registerForNotification];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - 注册通知
- (void)registerForNotification
{
    //注册通知 iOS8以后，iOS10都快出来了，iOS8之前就不适配了。
    UIUserNotificationType types = UIUserNotificationTypeAlert |
    UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    //注册远程通知，一般也会用到。
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

#pragma mark - 接收本地通知回调方法，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"本地:%@",notification);
    
    if (application.applicationState == UIApplicationStateActive) {
        // 获取通知所带的数据
        NSString *content = [notification.userInfo objectForKey:@"my_content_key"];
        
        // 提示警告框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"本地通知" message:content preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:alertAction];
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
    
    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *notification in localNotifications) {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
}

@end
