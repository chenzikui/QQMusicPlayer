//
//  QQMusicSearchModel.h
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/30.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicModel.h"

@interface QQMusicSearchModel : NSObject

@property(nonatomic,strong)NSString *allPages;
@property(nonatomic,strong)NSString *currentPage;
@property(nonatomic,strong)NSString *allNum;
@property(nonatomic,strong)NSString *maxResult;
@property(nonatomic,strong)NSMutableArray *datas;

-(void)modelDataWithDictionary:(NSDictionary *)dic;

@end
