//
//  ViewController.m
//  UILocalNotification
//
//  Created by 思久科技 on 16/6/13.
//  Copyright © 2016年 Seejoys. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *contentTF;

@property (weak, nonatomic) IBOutlet UITextField *delayTF;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

#pragma mark - 触发安排本地通知
- (IBAction)sendLocalNotification:(id)sender {
    NSString *content = self.contentTF.text;
    NSString *time = self.delayTF.text;
    if (content.length > 0 && [time integerValue] >= 0) {
        [self scheduleLocalNotification:[time integerValue]
                               userInfo:@{@"my_content_key" : content}];
        
        self.delayTF.text = @"";
        self.contentTF.placeholder = @"通知内容";
        self.delayTF.placeholder = @"通知延时时间（秒）";
    }else{
        self.contentTF.placeholder = @"不能为空";
        self.delayTF.placeholder = @"不能为空";
    }
}

#pragma mark - 触发取消本地通知
- (IBAction)cancelLocalNotification:(id)sender {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
}

#pragma mark - 安排本地通知
/**
 *  安排本地通知
 *
 *  @param delayTime 延时时间（秒）
 *  @param userInfo  推送详情（键值对）
 */
- (void)scheduleLocalNotification:(NSInteger)delayTime
                         userInfo:(NSDictionary *)userInfo
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:delayTime];
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔 NSCalendarUnitSecond秒为单位
    notification.repeatInterval = NSCalendarUnitSecond;
    // 通知内容
    notification.alertBody = @"这是一条本地通知";
    // 徽标数
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知详情
    notification.userInfo = userInfo;
    // 执行通知安排
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
