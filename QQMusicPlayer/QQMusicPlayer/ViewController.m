//
//  ViewController.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/20.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "ViewController.h"
#import "HotTopCollectionViewController.h"
#import "UIImageView+WebCache.h"
#import "AudioPlayerController.h"
#import "RotatingView.h"
#import "UIColor+SNFoundation.h"

@interface ViewController ()

@property (nonatomic, strong) RotatingView *showMusic_btn;

@end

@implementation ViewController


-(RotatingView *)showMusic_btn{
    
    if (!_showMusic_btn) {
        _showMusic_btn=[[RotatingView alloc]init];
        _showMusic_btn.alpha=1;
        _showMusic_btn.frame=CGRectMake(KScreenWidth-70, 200, 60, 60);
        [_showMusic_btn setRotatingViewLayoutWithNoBorderFrame:_showMusic_btn.frame];
        _showMusic_btn.imageView.image=[UIImage imageNamed:@"qqmusicicon"];
        _showMusic_btn.layer.masksToBounds=YES;
        _showMusic_btn.layer.cornerRadius=30;
        _showMusic_btn.layer.borderColor=[UIColor grayColor].CGColor;
        _showMusic_btn.layer.borderWidth=0.5;
        _showMusic_btn.backgroundColor=[UIColor clearColor];
        [_showMusic_btn addAnimation];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPlayer:)];
        tap.numberOfTapsRequired=1;
        [_showMusic_btn addGestureRecognizer:tap];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handlePanGestures:)];
        [_showMusic_btn addGestureRecognizer: pan];

        [[UIApplication sharedApplication].keyWindow addSubview:_showMusic_btn];
    }
    return _showMusic_btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.showMusic_btn.hidden=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isShowMusicButton:) name:@"showMucicButtonOnScreen" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMusicButtonImage:) name:@"ChangeMucicButtonImage" object:nil];
}




-(void)isShowMusicButton:(NSNotification *)notif{

    NSDictionary *dic=[notif object];
    bool isShow=[dic[@"isShowMusic"] boolValue];
    if (isShow) {
        self.showMusic_btn.hidden=NO;
        [self.showMusic_btn resumeLayer];
    }else{
        self.showMusic_btn.hidden=YES;
        [self.showMusic_btn pauseLayer];
    }
}

-(void)changeMusicButtonImage:(NSNotification *)notif{

    NSDictionary *dic=[notif object];
    NSString *img_url=dic[@"img_url"];
    [self.showMusic_btn.imageView sd_setImageWithURL:[NSURL URLWithString:img_url] placeholderImage:[UIImage imageNamed:@"qqmusicicon"]];
}


- (void)handlePanGestures:(UIPanGestureRecognizer *)paramSender{
    CGPoint location = [paramSender locationInView:paramSender.view.superview];
    
    CGRect rect = CGRectMake(location.x - paramSender.view.frame.size.width / 2.0f, location.y - paramSender.view.frame.size.height / 2.0f, paramSender.view.frame.size.width, paramSender.view.frame.size.height);
    
    if(CGRectContainsRect(CGRectMake(0.0f, 64.0f, KScreenWidth, KScreenHeight - 64.0f - 49.0f), rect)){
        paramSender.view.center = location;
    }
    if(paramSender.state == UIGestureRecognizerStateEnded){
        if(location.x > KScreenWidth / 2.0f){
            //往右飘
            [UIView animateWithDuration: 0.5f animations:^{
                CGRect frame = paramSender.view.frame;
                frame.origin.x = KScreenWidth - 5.0f - frame.size.width;
                paramSender.view.frame = frame;
            }];
        }
        else{
            [UIView animateWithDuration: 0.5f animations:^{
                CGRect frame = paramSender.view.frame;
                frame.origin.x = 0.5f;
                paramSender.view.frame = frame;
                
            }];
        }
    }
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


-(void)viewDidAppear:(BOOL)animated{


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showPlayer:(id)sender {
    [self presentViewController:[AudioPlayerController audioPlayerController] animated:YES completion:nil];
}

- (IBAction)gotoMusicList:(id)sender {
    HotTopCollectionViewController *vc=[[HotTopCollectionViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
