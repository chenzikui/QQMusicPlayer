//
//  ShowAPI_MusicModel.h
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/22.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicModel.h"

@interface ShowAPI_MusicModel : MusicModel

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
//播放器自建model
//@property (nonatomic, strong) MusicModel *musicModel;

-(void)setupModelWithDictionary:(NSDictionary *)dic;

@end
