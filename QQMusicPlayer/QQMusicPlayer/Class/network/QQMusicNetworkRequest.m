//
//  QQMusicNetworkRequest.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/20.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "QQMusicNetworkRequest.h"
#import "MusicModel.h"

@implementation QQMusicNetworkRequest
-(NSMutableArray *)datas{

    if (!_datas) {
        _datas=[NSMutableArray new];
    }
    return _datas;
}

-(void)requestData:(void (^)(BOOL))block{
    [self postDataSuccess:^(MainBaseNetworkRequest *DAO, id data) {
        
        NSDictionary *dic=data;
        NSLog(@"%@",dic);
        
        if ([dic[@"showapi_res_code"] integerValue]==0) {
            //
            NSDictionary *showapi_res_body=dic[@"showapi_res_body"];
            NSDictionary *pagebean=showapi_res_body[@"pagebean"];
            NSArray *songlist=pagebean[@"songlist"];
            NSMutableArray *dataArr=[NSMutableArray new];
            for (NSDictionary *dict in songlist) {
                MusicModel *model=[[MusicModel alloc]init];
                [model setupModelWithDictionary:dict];
                [dataArr addObject:model];
            }

            self.datas=dataArr;
            
            block(YES);
        }else{
            
            block(NO);
        }

    } failure:^(MainBaseNetworkRequest *DAO, NSError *error) {
        
        NSLog(@"%@",error);
        block(NO);
    }];
    
}



-(NSString *)interfaceName{
    
    return @"213-4";
}

-(id)value{
    
    return @{@"topid":self.topId};
}


@end
