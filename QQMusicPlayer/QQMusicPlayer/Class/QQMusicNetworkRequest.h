//
//  QQMusicNetworkRequest.h
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/20.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainBaseNetworkRequest.h"

@interface QQMusicNetworkRequest : MainBaseNetworkRequest

@property(nonatomic,strong)NSMutableArray *datas;

-(void)requestData:(void(^)(BOOL isSucess))block;

@end
