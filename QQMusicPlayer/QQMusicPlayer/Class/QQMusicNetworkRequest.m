//
//  QQMusicNetworkRequest.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/20.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "QQMusicNetworkRequest.h"
#import "ShowAPI_MusicModel.h"

@implementation QQMusicNetworkRequest
-(NSMutableArray *)datas{

    if (!_datas) {
        _datas=[NSMutableArray new];
    }
    return _datas;
}

-(void)requestData:(void (^)(BOOL))block{
    __weak __typeof(&*self)weakSelf = self;
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
                ShowAPI_MusicModel *model=[[ShowAPI_MusicModel alloc]init];
                [model setupModelWithDictionary:dict];
                [dataArr addObject:model];
            }
            //随机数组内容
            self.datas=[self randomizedArrayWithArray:dataArr];
            
            block(YES);
        }else{
            
            block(NO);
        }

    } failure:^(MainBaseNetworkRequest *DAO, NSError *error) {
        
        NSLog(@"%@",error);
        block(NO);
    }];
    
}

//随机数组内容
- (NSMutableArray *) randomizedArrayWithArray:(NSArray *)array {
    
    NSMutableArray *results = [[NSMutableArray alloc]initWithArray:array];
    long i = [results count];
    while(--i > 0) {
        int j = rand() % (i+1);
        [results exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    return results;
}

-(NSString *)interfaceName{
    
    return @"213-4";
}

-(id)value{
    
    return @{@"topid":@"5"};
}


@end
