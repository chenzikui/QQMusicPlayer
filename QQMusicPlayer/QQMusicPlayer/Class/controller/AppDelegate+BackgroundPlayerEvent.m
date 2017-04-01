//
//  AppDelegate+BackgroundPlayerEvent.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/28.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "AppDelegate+BackgroundPlayerEvent.h"

@implementation AppDelegate (BackgroundPlayerEvent)

#pragma mark - 接收方法的设置
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackgroundPlayerEvent" object:event];
}



@end
