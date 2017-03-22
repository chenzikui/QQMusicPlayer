//
//  MusicHeader.h
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/22.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#ifndef MusicHeader_h
#define MusicHeader_h


#import <UIImageView+WebCache.h>
#import <MBProgressHUD.h>

/* 屏幕宽高 */
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


/* 数值变量 */
#define TableViewRowHeight 60.0f // tableView RowHight

/* 坐标变量 */
#define Frame_x_0  0.0f // 坐标 -> x
#define Frame_y_0  0.0f //

#endif /* MusicHeader_h */
