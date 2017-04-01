//
//  MusicListTableViewController.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/22.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "MusicListTableViewController.h"
#import "QQMusicNetworkRequest.h"
#import "MusicListTableViewCell.h"
#import "SDAutoLayout.h"
#import "AudioPlayerController.h"

@interface MusicListTableViewController ()

@property(nonatomic,strong)QQMusicNetworkRequest *service;
@property(nonatomic,strong)NSMutableArray *datas;

@end

@implementation MusicListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[UIView new];
    
    
    
    self.service=[[QQMusicNetworkRequest alloc]init];
    self.service.topId=self.topId;
    __weak __typeof(&*self)weakSelf = self;
    [self.service requestData:^(BOOL isSucess) {
        if (isSucess) {
            weakSelf.datas=weakSelf.service.datas;
            [weakSelf.tableView reloadData];
        }else{
            NSLog(@"歌曲列表获取失败");
        }
    }];

}
-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *resuId=@"mycell";
    MusicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuId];
    if (cell==nil) {
        cell=[[MusicListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuId];
    }
    
    MusicModel *model=self.datas[indexPath.row];
    [cell setupDataWithModel:model];
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [self cellHeightForIndexPath: indexPath cellContentViewWidth: [self cellContentViewWith] tableView: self.tableView];
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MusicModel *model=self.datas[indexPath.row];
    AudioPlayerController *audio = [AudioPlayerController audioPlayerController];
    if (audio.currentModel&&[audio.currentModel.songid longLongValue] == [model.songid longLongValue]) {
    
    }else{
        [audio initWithArray:self.datas index:indexPath.row];
    }
    [self presentViewController:audio animated:YES completion:nil];


}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
