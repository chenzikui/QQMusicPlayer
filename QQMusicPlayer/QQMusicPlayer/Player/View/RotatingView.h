//
//  RotatingView.h
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/12.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RotatingView : UIView

@property (nonatomic, strong) UIImageView *imageView;


//图片带边框
- (void)setRotatingViewLayoutWithFrame:(CGRect)frame;

//图片不带边框
- (void)setRotatingViewLayoutWithNoBorderFrame:(CGRect)frame;
// 添加动画
- (void)addAnimation;
// 停止
-(void)pauseLayer;
// 恢复
-(void)resumeLayer;
// 移除动画
- (void)removeAnimation;

@end
