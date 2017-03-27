//
//  MusicModel.h
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/1.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject

@property (nonatomic, strong) NSNumber *music_id; // 歌曲id
@property (nonatomic, strong) NSString *name; // 歌曲名
@property (nonatomic, strong) NSString *icon; // 图片
@property (nonatomic, strong) NSString *fileName; // 歌曲地址
@property (nonatomic, strong) NSString *lrcName;
@property (nonatomic, strong) NSString *singer; // 歌手
@property (nonatomic, strong) NSString *singerIcon;


/*
下面是添加字段
*/
@property (nonatomic, strong) NSString *songid;
@property (nonatomic, strong) NSString *albumid;
@property (nonatomic, strong) NSString *albumname;
@property (nonatomic, strong) NSString *albumpic_big;
@property (nonatomic, strong) NSString *albumpic_small;
@property (nonatomic, strong) NSString *downUrl;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *singerid;
@property (nonatomic, strong) NSString *singername;
@property (nonatomic, strong) NSString *seconds;
@property (nonatomic, strong) NSString *songname;

-(void)setupModelWithDictionary:(NSDictionary *)dic;


@end
