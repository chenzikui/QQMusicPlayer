//
//  QQMusicNetworeSearchRequest.h
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/30.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainBaseNetworkRequest.h"
#import "QQMusicSearchModel.h"

@interface QQMusicNetworeSearchRequest : MainBaseNetworkRequest

@property(copy,nonatomic)NSString *page;
@property(copy,nonatomic)NSString *keyword;
@property(nonatomic,strong)QQMusicSearchModel *searchModel;

-(void)requestData:(void(^)(BOOL isSucess))block;

@end
