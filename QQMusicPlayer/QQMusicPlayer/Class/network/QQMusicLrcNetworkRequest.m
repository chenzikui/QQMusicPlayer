//
//  QQMusicLrcNetworkRequest.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/24.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "QQMusicLrcNetworkRequest.h"

@implementation QQMusicLrcNetworkRequest

-(void)requestData:(void (^)(BOOL))block{

    __weak typeof(self) weakSelf=self;
    [self postDataSuccess:^(MainBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic=data;
        
        if ([dic[@"showapi_res_code"] intValue]==0) {
            NSDictionary *res_body=dic[@"showapi_res_body"];
            
            NSString *lrc=[NSString stringWithString:res_body[@"lyric"]];
            weakSelf.lrc=[self deleteAllUnkonwStr:lrc];
            
            block(YES);
        }else{
            block(NO);
        }

    } failure:^(MainBaseNetworkRequest *DAO, NSError *error) {
        
            block(NO);
    }];
    
}
-(NSString *)deleteAllUnkonwStr:(NSString *)lrcStr{

    for (int i=10; i<100; i++) {
        NSString *deleteStr=[NSString stringWithFormat:@"&#%d",i];
        lrcStr = [lrcStr stringByReplacingOccurrencesOfString:deleteStr withString:@""];
    }
    
    int msecend=0;
    int second=0;
    int min=0;
    while (min<8) {
        msecend++;
        if (msecend/100>0) {
            second++;
            msecend=0;
        }
        if (second>59) {
            min++;
            second=0;
        }
        NSString *replaceStr1=[NSString stringWithFormat:@"[%02d;%02d;%02d]",min,second,msecend];
        NSString *replaceStr2=[NSString stringWithFormat:@"\n[%02d:%02d.%02d]",min,second,msecend];
        lrcStr = [lrcStr stringByReplacingOccurrencesOfString:replaceStr1 withString:replaceStr2];
    }

    lrcStr = [lrcStr stringByReplacingOccurrencesOfString:@";" withString:@" "];
    
    return lrcStr;
}



-(NSString *)interfaceName{
    
    return @"213-2";
}

-(id)value{
    
    return @{@"musicid":self.model.music_id};
}



@end
