//
//  QQMusicNetworeSearchRequest.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/30.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "QQMusicNetworeSearchRequest.h"
#import "QQMusicSearchModel.h"

@implementation QQMusicNetworeSearchRequest
-(QQMusicSearchModel *)searchModel{

    if (!_searchModel) {
        _searchModel=[[QQMusicSearchModel alloc]init];
    }
    return _searchModel;
}

-(void)requestData:(void (^)(BOOL))block{

    __weak typeof(self) weakSelf=self;
    [self postDataSuccess:^(MainBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic=data;
        
        if ([dic[@"showapi_res_code"] intValue]==0) {
            NSDictionary *res_body=dic[@"showapi_res_body"];
            NSDictionary *pagebean=res_body[@"pagebean"];
            
            if ([pagebean[@"allNum"] intValue]==0) {
                 block(NO);
            }else{
           
                [weakSelf.searchModel modelDataWithDictionary:pagebean];
                block(YES);
            }
        }else{
            block(NO);
        }
    } failure:^(MainBaseNetworkRequest *DAO, NSError *error) {
        block(NO);
    }];
}

-(NSString *)interfaceName{
    
    return @"213-1";
}

-(id)value{
    if (self.page==nil||[self.page isEqualToString:@""]) {
        self.page=@"1";
    }
    return @{@"keyword":self.keyword,@"page":self.page};
}

@end
