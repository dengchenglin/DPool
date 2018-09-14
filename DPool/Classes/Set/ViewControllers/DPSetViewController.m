//
//  DPSetViewController.m
//  DPool
//
//  Created by dengchenglin on 2018/9/10.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//
#import "DPSetViewController.h"

#import "DPAboutViewController.h"

#import "DPSetCell.h"

#import "SDImageCache.h"

#import "DPNetworkEngine+Login.h"

#import "DPDoneButton.h"

#import "FileUtil.h"

#import "DPTabelView.h"

@interface DPSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)DPTabelView *tableView;

@property (nonatomic,copy)NSArray *dataSoures;

@end

@implementation DPSetViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
   
        self.dataSoures = @[@[@{@"title":@"评分",@"img":@"more_03"},@{@"title":@"清除缓存",@"img":@"more_02"},@{@"title":@"关于",@"img":@"more_05"},@{@"title":@"推送",@"img":@"more_01"}]];
    }
    return self;
}



- (void)setUpUI{

    _tableView = [[DPTabelView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:_tableView];


    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    DPDoneButton * logoutBtn = [DPDoneButton buttonWithType:UIButtonTypeCustom];
    [logoutBtn setFrame:CGRectMake(20, 10, SCREEN_WIDTH - 40, 50)];
    [logoutBtn setTitle:[DPAppManager logined]?@"退出":@"登录" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:[DPAppManager logined]?@selector(logout):@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:logoutBtn];
    [_tableView setTableFooterView:footView];
    
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:DP_NOTIFITION_LOGOUT object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [logoutBtn setTitle:[DPAppManager logined]?@"退出":@"登录" forState:UIControlStateNormal];
    }];
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:DP_NOTIFITION_LOGIN object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [logoutBtn setTitle:[DPAppManager logined]?@"退出":@"登录" forState:UIControlStateNormal];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSoures.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array =  self.dataSoures[section];
    return array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"DPSetCell";
    DPSetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[DPSetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.contentMode = UIViewContentModeScaleToFill;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *array =  self.dataSoures[indexPath.section];
    NSDictionary *data = array[indexPath.row];
    cell.titleLabel.text = data[@"title"];
    [cell.imageView setBounds:CGRectMake(0, 0, 60, 60)];
    cell.imgView.image = [UIImage imageNamed:data[@"img"]];
    cell.isPush = (indexPath.section == 0 && indexPath.row == 3);
//    if(indexPath.section == 0 && indexPath.row == 1){
//        cell.rightLabel.text = [NSString stringWithFormat:@"%.2fM",[[SDImageCache sharedImageCache]getSize]/(1024.0 * 1024.0)];
//    }
//    else{
//        cell.rightLabel.text = nil;
//    }
    if(indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 3)){
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:DP_APP_STORE_URL]];
        }
        if(indexPath.row == 1){
            [FileUtil clearWebCaches];

            [MBProgressHUD showMBProgressHudWithTitle:@"清理完成" hideAfterDelay:1.0];

        }
        if(indexPath.row == 2){
            DPAboutViewController *about = [[DPAboutViewController alloc]init];
            [self.navigationController pushViewController:about animated:YES];
        }
    }
}


- (void)login{
    [DPModuleManager showLoginFromViewController:self callback:^(BOOL result) {

    }];
}

#pragma mark - Logout
- (void)logout{
    
    [DPAppManager logout];

    [DPModuleManager showLoginFromViewController:self callback:^(BOOL result) {

    }];

    [[NSNotificationCenter defaultCenter]postNotificationName:DP_NOTIFITION_LOGOUT object:nil];
}

@end

