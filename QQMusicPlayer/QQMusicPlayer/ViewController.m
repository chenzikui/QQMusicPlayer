//
//  ViewController.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/20.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "ViewController.h"
#import "MusicListTableViewController.h"
#import "AudioPlayerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}



-(void)viewDidAppear:(BOOL)animated{


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPlayer:(id)sender {
    [self presentViewController:[AudioPlayerController audioPlayerController] animated:YES completion:nil];
}

- (IBAction)gotoMusicList:(id)sender {
    MusicListTableViewController *vc=[[MusicListTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
