//
//  ShowAPI_MusicModel.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/22.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "ShowAPI_MusicModel.h"


@implementation ShowAPI_MusicModel

//-(MusicModel *)musicModel{
//
//    if (!_musicModel) {
//        _musicModel=[[MusicModel alloc]init];
//    }
//    return _musicModel;
//}



-(void)setupModelWithDictionary:(NSDictionary *)dic{

    self.songid=dic[@"songid"];
    self.albumid=dic[@"albumid"];
    self.albumname=dic[@"albumname"];
    self.albumpic_big=dic[@"albumpic_big"];
    self.albumpic_small=dic[@"albumpic_small"];
    self.downUrl=dic[@"downUrl"];
    self.url=dic[@"url"];
    self.singerid=dic[@"singerid"];
    self.singername=dic[@"singername"];
    self.seconds=dic[@"seconds"];
    self.songname=dic[@"songname"];
    

    //
    self.music_id=[NSNumber numberWithInteger:[self.songid integerValue]];
    self.name=self.songname;
    self.icon=self.albumpic_big;
    self.fileName=self.url;
    self.lrcName=@"567";
    self.singer=self.songname;
    self.singerIcon=self.albumpic_small;
}

@end
