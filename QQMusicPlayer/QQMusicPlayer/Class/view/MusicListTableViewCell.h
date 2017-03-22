//
//  MusicListTableViewCell.h
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/22.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowAPI_MusicModel.h"

@interface MusicListTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *songImage;
@property(nonatomic,strong)UILabel *singerName;
@property(nonatomic,strong)UILabel *songName;

-(void)setupDataWithModel:(ShowAPI_MusicModel *)model;

@end
