//
//  QQMusicSearchModel.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/30.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "QQMusicSearchModel.h"


@implementation QQMusicSearchModel

-(void)modelDataWithDictionary:(NSDictionary *)dic{


    self.allPages=dic[@"allPages"];
    self.currentPage=dic[@"currentPage"];
    self.allNum=dic[@"allNum"];
    self.maxResult=dic[@"maxResult"];
    NSArray *contentlist=dic[@"contentlist"];
    
    self.datas=[NSMutableArray new];
    for (NSDictionary *dict in contentlist) {
        MusicModel *model=[[MusicModel alloc]init];
        [model setupModelWithDictionary:dict];
        [self.datas addObject:model];
    }
    
}


@end
