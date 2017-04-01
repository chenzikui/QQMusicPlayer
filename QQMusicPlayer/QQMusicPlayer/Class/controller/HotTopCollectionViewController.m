//
//  HotTopCollectionViewController.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/28.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "HotTopCollectionViewController.h"
#import "MusicHeader.h"
#import "UIColor+SNFoundation.h"
#import "MusicListTableViewController.h"
#import "MusicSearchTableViewController.h"

@interface HotTopCollectionViewController ()

@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,assign)CGFloat itemW;
@property(nonatomic,strong)UIButton *search_btn;

@end

@implementation HotTopCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const headerIdentifier = @"HeaderCell";

-(NSMutableArray *)datas{

    if (!_datas) {
        _datas=[NSMutableArray array];
    }
    return _datas;
}

-(UIButton *)search_btn{
    if (!_search_btn) {
        _search_btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, KScreenWidth-10, 30)];
        _search_btn.layer.cornerRadius = 3.0f;
        _search_btn.clipsToBounds = YES;
        [_search_btn setImage:[UIImage imageNamed:@"search_white"] forState:UIControlStateNormal];
        [_search_btn setTitle:@"搜索歌手/歌曲" forState:UIControlStateNormal];
        [_search_btn setBackgroundColor:HEX_RGB(0x269D5A)];
        _search_btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_search_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_search_btn addTarget:self action:@selector(searchView_DidSearchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _search_btn;
}

-(instancetype)init{
    
    if (KScreenWidth>320) {
        self.itemW=100;
    }else{
        self.itemW=90;
    }
    
    CGFloat splace=(KScreenWidth-3*self.itemW)/4;
    
    /** 创建布局参数 */
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.itemW, self.itemW);
    flowLayout.minimumInteritemSpacing = splace;//cell的最小列间距
    flowLayout.minimumLineSpacing = 10;//cell的最小行间距
    flowLayout.sectionInset = UIEdgeInsetsMake(10, splace, 10, splace);
    /**
     1.创建collectionView
     2.设置布局参数
     */
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, KScreenWidth
                                                                             , KScreenHeight-49-50) collectionViewLayout:flowLayout];
    
    /** 注册cell可重用ID */
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    /** 注册headerView可重用ID */
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    
    self.collectionView.showsVerticalScrollIndicator=NO;
    /**
     1.设置背景色
     2.由于糊上了一层collectionView所以在Appdelegate中设置window的背景色被collectionView覆盖.此时collectionView的颜色要重新设置
     */
    self.collectionView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"music_bg.jpg"]];
    
    self.datas=@[@{},@{@"民谣.jpg":@"18",@"摇滚.jpg":@"19",@"我是歌手.1":@"33"},@{@"内地.jpg":@"5",@"销量.jpg":@"23",@"热歌.jpg":@"26",@"流行指数.jpg":@"4",@"港台.jpg":@"6",@"日本.jpg":@"17",@"欧美.jpg":@"3",@"新歌.jpg":@"27",@"网络歌曲.jpg":@"28",@"音乐人.jpg":@"32",@"K歌金曲.jpg":@"36"}].mutableCopy;
    [self.collectionView reloadData];
    
    self.title=@"音乐天地";
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
// 点击搜索
-(void)searchView_DidSearchButtonClick:(UIButton *)button{
    //搜索按钮
    NSLog(@"搜索歌曲");
    
    MusicSearchTableViewController *vc=[[MusicSearchTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.datas.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *dataDic=self.datas[section];
    return dataDic.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *dataDic=self.datas[indexPath.section];
    NSArray *dataPic=[dataDic allKeys];
    UILabel *title_lb=[UILabel new];
    title_lb.text=[dataPic[indexPath.row] componentsSeparatedByString:@"."][0];
    title_lb.textAlignment=NSTextAlignmentCenter;
    title_lb.frame=CGRectMake(0, 0, self.itemW, self.itemW);
    title_lb.textColor=[UIColor whiteColor];
    title_lb.backgroundColor=[UIColor blackColor];
    title_lb.alpha=0.5;
    [cell addSubview:title_lb];
    cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:dataPic[indexPath.row]]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    if (section==0) {
        return CGSizeMake(KScreenWidth, 40);
    }
    
    return CGSizeMake(KScreenWidth, 44);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *headView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
    
    UILabel *title_lb=[UILabel new];
    title_lb.font=[UIFont systemFontOfSize:15];
    title_lb.textColor=HEX_RGB(0x228B22);
    title_lb.frame=CGRectMake(0, 0, KScreenWidth, 44);
    title_lb.textAlignment=NSTextAlignmentCenter;
    
    if (indexPath.section==0) {
        UIView *search_view=[[UIView alloc]init];
        UIColor *nav_color=[UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_fenseBG"]];
        search_view.backgroundColor=nav_color;
        search_view.frame=CGRectMake(0, 0, KScreenWidth, 40);
        [search_view addSubview:self.search_btn];
        [self.view addSubview:search_view];
    }else if (indexPath.section==1) {
        title_lb.text=@"小编推荐";
        [headView addSubview:title_lb];
    }else{
        title_lb.text=@"热门榜单";
        [headView addSubview:title_lb];
    }
    
    
    return headView;
}


#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dataDic=self.datas[indexPath.section];
    NSArray *dataPic=[dataDic allKeys];
    NSString *topId=dataDic[dataPic[indexPath.row]];
    NSString *title = [dataPic[indexPath.row] componentsSeparatedByString:@"."][0];
    NSLog(@"%@",topId);
    
    MusicListTableViewController *vc=[[MusicListTableViewController alloc]init];
    vc.topId=topId;
    vc.title=title;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
