//
//  QQMusicLrcNetworkRequest.h
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/24.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainBaseNetworkRequest.h"
#import "MusicModel.h"

@interface QQMusicLrcNetworkRequest : MainBaseNetworkRequest

@property(nonatomic,strong)MusicModel *model;
@property(nonatomic,copy)NSString *lrc;


-(void)requestData:(void(^)(BOOL isSucess))block;

@end
