//
//  MusicListTableViewCell.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/22.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "MusicListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SDAutoLayout.h"

@implementation MusicListTableViewCell
-(UIImageView *)songImage{
    if (!_songImage) {
        _songImage=[[UIImageView alloc]init];
    }
    return _songImage;
}
-(UILabel *)songName{
    if (!_songName) {
        _songName=[UILabel new];
        _songName.font=[UIFont systemFontOfSize:15];
    }
    return _songName;
}
-(UILabel *)singerName{
    if (!_singerName) {
        _singerName=[UILabel new];
        _singerName.textColor=[UIColor grayColor];
        _singerName.font=[UIFont systemFontOfSize:14];
    }
    return _singerName;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addMySubviews];
    }
    return self;
}

-(void)addMySubviews{

    [self.contentView addSubview:self.songImage];
    [self.contentView addSubview:self.songName];
    [self.contentView addSubview:self.singerName];
    
    CGFloat image_h=40.0f;
    CGFloat label_h=20.0f;
    CGFloat marg_left=10.0f;

    self.songImage.sd_layout.leftSpaceToView(self.contentView,marg_left).topSpaceToView(self.contentView,10).heightIs(image_h).widthIs(image_h);
    self.songName.sd_layout.leftSpaceToView(self.songImage,5).topEqualToView(self.songImage).rightSpaceToView(self.contentView,marg_left).heightIs(label_h);
    self.singerName.sd_layout.leftSpaceToView(self.songImage,5).bottomEqualToView(self.songImage).rightSpaceToView(self.contentView,marg_left).heightIs(label_h);
    self.songImage.layer.masksToBounds=YES;
    self.songImage.layer.cornerRadius=image_h/2;
    
    [self setupAutoHeightWithBottomView:self.songImage bottomMargin:10];
}

-(void)addMyConstraint{

    CGFloat image_h=40.0f;
    CGFloat label_h=20.0f;
    

    
    CGFloat orgin_y=(self.contentView.frame.size.height - image_h)/2;
    CGFloat orgin_x=10.0f;
    [self.songImage setFrame:CGRectMake(orgin_x, orgin_y, image_h, image_h)];
    [self.songName setFrame:CGRectMake(orgin_x+image_h+5, orgin_y, 250, label_h)];
    [self.singerName setFrame:CGRectMake(orgin_x+image_h+5, orgin_y+label_h, 250, label_h)];
}

-(void)setupDataWithModel:(ShowAPI_MusicModel *)model{
    
    [self.songImage sd_setImageWithURL:[NSURL URLWithString:model.albumpic_small] placeholderImage:nil];
    self.songName.text=model.songname;
    self.singerName.text=model.singername;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
