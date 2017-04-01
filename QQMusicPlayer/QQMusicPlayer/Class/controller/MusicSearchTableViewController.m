//
//  MusicSearchTableViewController.m
//  QQMusicPlayer
//
//  Created by 陈自奎 on 17/3/28.
//  Copyright © 2017年 Chen, ZiKui. All rights reserved.
//

#import "MusicSearchTableViewController.h"
#import "MusicHeader.h"
#import "UIColor+SNFoundation.h"
#import "MusicHeader.h"
#import "QQMusicNetworeSearchRequest.h"
#import "MusicListTableViewCell.h"
#import "SDAutoLayout.h"
#import "AudioPlayerController.h"

@interface MusicSearchTableViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UITableView *resultTableView;
@property(nonatomic,strong)UITableView *historyTableView;

@property(nonatomic,strong)NSMutableArray *historyDatas;
@property(nonatomic,strong)NSMutableArray *resultDatas;

@property(nonatomic,strong)QQMusicNetworeSearchRequest *searchRequest;

@end

@implementation MusicSearchTableViewController

-(UITextField *)textField{

    if (!_textField) {
        _textField=[[UITextField alloc]init];
        _textField.frame=CGRectMake(10, 7, KScreenWidth-70, 30);
        _textField.layer.masksToBounds=YES;
        _textField.layer.cornerRadius=5;
        _textField.font=[UIFont systemFontOfSize:15];
        _textField.backgroundColor=HEX_RGB(0x269D5A);
        _textField.returnKeyType=UIReturnKeySearch;

        UIView *left_vi=[UIView new];
        left_vi.frame=CGRectMake(0, 0, 30, 30);
        UIImageView *left_img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_white"]];
        left_img.frame=CGRectMake(10, 9, 12, 12);
        [left_vi addSubview:left_img];
        _textField.leftView=left_vi;
        _textField.leftViewMode=UITextFieldViewModeAlways;
        
        _textField.clearButtonMode=UITextFieldViewModeAlways;
        
        _textField.textColor=[UIColor whiteColor];
        _textField.delegate=self;
        
        _textField.placeholder=@"搜索歌手/歌曲";
    }
    return _textField;
}

-(NSMutableArray *)historyDatas{

    if (!_historyDatas) {
        _historyDatas=[NSMutableArray new];
    }
    return _historyDatas;
}
-(NSMutableArray *)resultDatas{

    if (!_resultDatas) {
        _resultDatas=[NSMutableArray new];
    }
    return _resultDatas;
}

-(QQMusicNetworeSearchRequest *)searchRequest{

    if (!_searchRequest) {
        _searchRequest=[[QQMusicNetworeSearchRequest alloc]init];
    }
    return _searchRequest;
}

-(UITableView *)resultTableView
{

    if (!_resultTableView) {
        _resultTableView=[[UITableView alloc]init];
//        _resultTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _resultTableView.tableFooterView=[UIView new];
        _resultTableView.delegate=self;
        _resultTableView.dataSource=self;
        
    }
    return _resultTableView;
}

-(UITableView *)historyTableView
{
    
    if (!_historyTableView) {
        _historyTableView=[[UITableView alloc]init];
        //        _resultTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _historyTableView.tableFooterView=[UIView new];
        _historyTableView.delegate=self;
        _historyTableView.dataSource=self;
        
    }
    return _historyTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllTableView];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)setupNavigationView{

    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.hidesBackButton=YES;
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.rightBarButtonItem=rightItem;
    [self.navigationController.navigationBar addSubview:self.textField];

}

-(void)setupAllTableView{
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.historyDatas=@[@[@"李宗盛",@"周杰伦",@"S.H.E",@"我是歌手",@"好声音"]].mutableCopy;
    NSUserDefaults *defualt=[NSUserDefaults standardUserDefaults];
    NSArray *search_arr=[defualt objectForKey:@"search_history_arr"];
    if (!search_arr) {
        [self.historyDatas addObject:@[]];
    }else{
        [self.historyDatas addObject:search_arr];
    }
    
    self.historyTableView.frame=CGRectMake(0, 0, KScreenWidth, self.view.frame.size.height);
    [self.view addSubview:self.historyTableView];
    [self.historyTableView reloadData];
    
    self.resultTableView.frame=CGRectMake(KScreenWidth, 0, KScreenWidth, self.view.frame.size.height);
    [self.view addSubview:self.resultTableView];
    
    [self.historyTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"historyCell"];
    [self.resultTableView registerClass:[MusicListTableViewCell class] forCellReuseIdentifier:@"resultCell"];

}

-(void)viewWillAppear:(BOOL)animated{

    [self setupNavigationView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.view endEditing:YES];
    [self.textField removeFromSuperview];
}

-(void)backClick{

    [self.navigationController popViewControllerAnimated:YES];
    self.historyTableView.tableFooterView=[UIView new];
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    self.historyTableView.height=self.view.height-height;
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    self.historyTableView.height=self.view.height;
}
#pragma mark - UItextfieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    WS(weakSelf);
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.resultTableView.frame=CGRectMake(KScreenWidth, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
        weakSelf.historyTableView.frame=CGRectMake(0, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
        self.historyTableView.alpha=1;
        self.resultTableView.alpha=0;
    }];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    WS(weakSelf);
    [UIView animateWithDuration:1 animations:^{
        weakSelf.historyTableView.frame=CGRectMake(-KScreenWidth, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
        weakSelf.resultTableView.frame=CGRectMake(0, 0, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
        self.historyTableView.alpha=0;
        self.resultTableView.alpha=1;
    }];
    
    
    self.searchRequest.keyword=textField.text;
    self.searchRequest.page=@"1";
    [self.searchRequest requestData:^(BOOL isSucess) {
        [weakSelf.resultDatas removeAllObjects];
        [weakSelf.resultDatas addObjectsFromArray:weakSelf.searchRequest.searchModel.datas];
        [weakSelf.resultTableView reloadData];
    }];
    
    
    NSArray *oneArr=self.historyDatas[0];
    NSArray *twoArr=self.historyDatas[1];
    if (![oneArr containsObject:textField.text]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *search_arr=[NSMutableArray arrayWithArray:twoArr];
        if ([twoArr containsObject:textField.text]) {
            [search_arr removeObject:textField.text];
        }
        [search_arr insertObject:textField.text atIndex:0];
        twoArr=[NSArray arrayWithArray:search_arr];
        [defaults setObject:twoArr forKey:@"search_history_arr"];
        [defaults synchronize];
        [self.historyDatas replaceObjectAtIndex:1 withObject:twoArr];
    }
    [self.historyTableView reloadData];

    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView==self.historyTableView) {
        return self.historyDatas.count;
    }else if(tableView==self.resultTableView){
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.historyTableView) {
        NSArray *data_arr=self.historyDatas[section];
        return data_arr.count;
    }else if(tableView==self.resultTableView){
        return self.resultDatas.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView==self.resultTableView){
        MusicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell" forIndexPath:indexPath];
        if (cell==nil) {
            cell=[[MusicListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"resultCell"];
        }
        
        MusicModel *model=self.resultDatas[indexPath.row];
        [cell setupDataWithModel:model];
        return cell;
    }else if (tableView==self.historyTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell" forIndexPath:indexPath];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"historyCell"];
        }
        NSArray *data_arr=self.historyDatas[indexPath.section];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.text=data_arr[indexPath.row];
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==self.resultTableView) {
        return CGFLOAT_MIN;
    }

    return 40.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView==self.resultTableView) {
        return nil;
    }
    
    UIView *view=[UIView new];
    [view setBackgroundColor:[UIColor whiteColor]];
    UILabel *label_title=[UILabel new];
    label_title.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_fenseBG"]];
    label_title.font=[UIFont systemFontOfSize:15];
    label_title.frame=CGRectMake(15, 0, 200, 40);
    [view addSubview:label_title];
    if (section==0) {
        label_title.text=@"推荐";
    }else{
        label_title.text=@"历史纪录";
    }
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.historyTableView) {
        return 50;
    }else if(tableView==self.resultTableView){
        return 60;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView==self.historyTableView) {
        NSArray *data_arr=self.historyDatas[indexPath.section];
        NSString *select_str=data_arr[indexPath.row];
        self.textField.text=select_str;
        [self.textField resignFirstResponder];
        [self textFieldDidEndEditing:self.textField];
    }else if(tableView==self.resultTableView){
    
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        MusicModel *model=self.resultDatas[indexPath.row];
        AudioPlayerController *audio = [AudioPlayerController audioPlayerController];
        if (audio.currentModel&&[audio.currentModel.songid longLongValue] == [model.songid longLongValue]) {
        }else{
            [audio initWithArray:self.resultDatas index:indexPath.row];
        }
        [self presentViewController:audio animated:YES completion:nil];
    }
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
