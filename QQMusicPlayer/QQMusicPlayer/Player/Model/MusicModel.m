//
//  MusicModel.m
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/1.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

-(void)setupModelWithDictionary:(NSDictionary *)dic{
    
    self.songid=dic[@"songid"];
    self.albumid=dic[@"albumid"];
    self.albumname=dic[@"albumname"];
    self.albumpic_big=dic[@"albumpic_big"];
    self.albumpic_small=dic[@"albumpic_small"];
    self.downUrl=dic[@"downUrl"];
    self.singerid=dic[@"singerid"];
    self.singername=dic[@"singername"];
    self.seconds=dic[@"seconds"];
    self.songname=dic[@"songname"];
    self.url=dic[@"url"];
    if (!self.url||[self.url isEqualToString:@""]) {
            self.url=dic[@"m4a"];
    }
    
    //
    self.music_id=[NSNumber numberWithInteger:[self.songid integerValue]];
    self.name=self.songname;
    self.icon=self.albumpic_big;
    self.fileName=self.url;
    self.lrcName=@"567";
    self.singer=self.singername;
    self.singerIcon=self.albumpic_small;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqual:@""]) {
        
    }
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
