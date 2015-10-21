//
//  UserSetViewController.m
//  BESTKEEP
//
//  Created by dcj on 15/8/24.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "UserSetViewController.h"
#import "UserCenterDefaultCell.h"
#import "UIColor+CJCategory.h"
#import "PassportService.h"
#import "Userinfo.h"
#import "Result.h"
#import "ManagerSetting.h"
#import "BKViewController.h"
#import "AppDelegate.h"

@interface UserSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * settingTableView;
@property (nonatomic,strong) UIButton * outBtn;
@property (nonatomic,strong) NSString *Version_number;
@end

@implementation UserSetViewController

-(BOOL)isLogin{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    return app.isLogin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = COLOR_03;
    [self.view addSubview:self.settingTableView];
    [_settingTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    self.outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.outBtn];
    [self.outBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(@(50));
        make.width.mas_equalTo(@(SCREEN_WIDTH-40));
    }];
    
    self.outBtn.layer.cornerRadius = 5;
    [self.outBtn addTarget:self
                 action:@selector(outBtnTouched)
       forControlEvents:UIControlEventTouchUpInside];
//    if ([self isLogin]) {
//        [self.outBtn setTitle:@"退出登录" forState:UIControlStateNormal];
//    }
//    else{
//        [self.outBtn setTitle:@"登录" forState:UIControlStateNormal];
//    }
    
    self.outBtn.backgroundColor= [UIColor colorWithRed:25/255.0f green:180/255.0f blue:142/255.0f alpha:1];
    ;
    self.outBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    [self.outBtn setTitleColor:[UIColor whiteColor]
                   forState:UIControlStateNormal];
    
    self.outBtn.showsTouchWhenHighlighted = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self isLogin]) {
        [self.outBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    }
    else{
        [self.outBtn setTitle:@"登录" forState:UIControlStateNormal];
        self.outBtn.hidden = YES;
    }

}
//退出注销
-(void)outBtnTouched{
    [PassportService logout];
    [self.navigationController popViewControllerAnimated:YES];
//    if ([[Userinfo getUserTGT] isEqualToString:@""] ) {
//        LoginController *lvc =[[LoginController alloc]init];
//        BKNavigationController *bknav =[[BKNavigationController alloc]initWithRootViewController:lvc];
//        [self.navigationController presentViewController:bknav animated:YES completion:^{
//            
//        }];
//        
//    }
}
-(UITableView *)settingTableView{
    if (_settingTableView == nil) {
        _settingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _settingTableView.delegate = self;
        _settingTableView.dataSource = self;
        _settingTableView.backgroundColor = [UIColor clearColor];
        _settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _settingTableView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCenterDefaultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    if (cell == nil) {
        cell = [[UserCenterDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingCell"];
        cell.hideArrowImage = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    if (indexPath.row == UserSetCellTypeAboutUs) {
        cell.bcLeftTextlabel.text = @"版本检测";
        cell.bcRightTextLabel.text = self.Version_number;
        cell.hideArrowImage = NO;
    }else if (indexPath.row == UserSetCellTypeservicePhone){
        cell.bcLeftTextlabel.text = @"客服热线";
        cell.bcRightTextLabel.text = @"400-720-9815";
    }else if (indexPath.row == UserSetCellTypeGiveStar){
        cell.bcLeftTextlabel.text = @"关于我们";
        cell.hideArrowImage = NO;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCenterDefaultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
    if (cell == nil) {
        cell = [[UserCenterDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingCell"];
    }
    NSLog(@"selectedArow");
    if (indexPath.row == UserSetCellTypeAboutUs) {
        
//        if ([self isLogin]) {
            [self checkOutVersion];
//        }
//        else{
//            LoginController *lvc =[[LoginController alloc]init];
//            BKNavigationController *bknav =[[BKNavigationController alloc]initWithRootViewController:lvc];
//            [self.navigationController presentViewController:bknav animated:YES completion:^{
//                
//            }];
//        }
    }
    else if (indexPath.row == UserSetCellTypeservicePhone) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @"400-720-9815"]];
        [[UIApplication sharedApplication] openURL:url];
    }
    else{
        BKViewController *bkVC = [[BKViewController alloc] init];
        [self.navigationController pushViewController:bkVC animated:YES];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 45;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return UserSetCellTypeGiveStar +1;
}

-(void)checkOutVersion{
  
//    if ([[Userinfo getLoginSatuts]isEqualToString:@"1"]) {
    
        NSString *app_Version = [Common getAppVersion];
        NSDictionary *param_dic = [NSDictionary dictionaryWithObjectsAndKeys:app_Version,@"version", nil];
        
        [PassportService checkOutVersionnext:param_dic :^(id obj,NSError* error) {
            
            Result * version_result  = [[Result alloc]init];
            
            version_result = (Result *)obj;
            
            if (version_result.success) {
                
                NSMutableDictionary *result_dic = (NSMutableDictionary *)version_result.data;
                
                //  NSDictionary *data_dic = [result_dic objectForKey:@"data"];
                NSString *isupdate = [[result_dic objectForKey:@"upgrade"] stringValue];
                [ManagerSetting setversionUrl:[result_dic objectForKey:@"url"]];
                if ([isupdate isEqualToString:@"1"]) {
                    BOOL isforce = [[result_dic objectForKey:@"force"] boolValue];
                    NSString *message = [result_dic objectForKey:@"upgrade_msg"];
                    if (isforce) {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"版本更新" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        
                        alertView.delegate = self;
                        alertView.tag = 100;
                        [alertView show];
                    }
                    else{
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"版本更新" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             alertView.tag = 200;
                        alertView.delegate = self;
                        [alertView show];
                    }
                }else{
                    
                    [Common AlertViewTitle:@"提示" message:@"您当前已经是最新版本了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                }
                
            }
            
        }];
//    }
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ManagerSetting getversionUrl]]];
        
        exit(0);
    }else if(alertView.tag == 200){
        
        switch (buttonIndex) {
            case 0:
                //   [[NSNotificationCenter defaultCenter]removeObserver:self];
                return;
                break;
            case 1:{
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[ManagerSetting getversionUrl]]]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ManagerSetting getversionUrl]]];
                    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
                    exit(0);
                }
                break;
            default:
                break;
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
