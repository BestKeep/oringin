//
//  UserCenterViewController.m
//  BESTKEEP
//
//  Created by dcj on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UIView+Position.h"
#import "UserCenterTextButtonView.h"
#import "UserCentrerBaseCell.h"
#import "OrderStatuCell.h"
#import "Userinfo.h"
#import "LoginController.h"
#import "ConfirmationIndentViewController.h"
#import "OrderReturnManagerController.h"
#import "ShopingAddressController.h"
#import "BKNavigationController.h"
#import "UserSetViewController.h"
#import "ShopingAddressController.h"
#import "AddAddressController.h"
#import "MySaveViewController.h"
#import "UserCenterDefaultCell.h"
#import "AllOrderController.h"
#import "BKService.h"
#import "UIImageView+WebCache.h"
#import "ShoppingCarCommon.h"
#import "AppDelegate.h"
#import "AddressManagerController.h"
#import "CashDeskService.h"
#import "PassportService.h"
#import "CXAlertView.h"
#import "AccountInfoModel.h"
#import "ShowDetailController.h"
#import "RechargeController.h"
#import "OneViewController.h"
#import "ALiPayResult.h"
#import "UserInfoViewController.h"


#define DefaultUserHeader_Width      62
#define DefaultUserHeader_Height     62
#define DefaultUserHeaderView_height 74
#define DefaultButtonTag             100


@interface UserCenterViewController ()<UITableViewDelegate,UITableViewDataSource,ButtonClickDelegate>{
    
    NSString *requests;
    UIView * tableViewHeaderView;
}

//@property (nonatomic,strong) UIView * tableViewHeaderView;
@property (nonatomic,strong) UIImageView * userHeaderImageView;
@property (nonatomic,strong) UILabel * userNameLabel;
@property (nonatomic,strong) UserCenterTextButtonView * shopCollect;
@property (nonatomic,strong) UserCenterTextButtonView * myMake;
@property (nonatomic,strong) UIView * tableHeaderBottomView;
@property (nonatomic,strong) UserInfoModel * userInfo;

@property (nonatomic,strong) ShoppingCarCommon * shopingCarCommon;

@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,copy) NSMutableAttributedString * accountMoneyInfo;


@property (nonatomic,strong) UITableView * userCenterTableView;
@property (nonatomic,strong) UILabel * bondMemberLabel;
@property (nonatomic,strong) UILabel * useLabel;
@property (nonatomic,strong) UILabel * memberLabel;


@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.userCenterTableView) {
        
    }
    self.accountMoneyInfo = [[NSMutableAttributedString alloc] initWithString:@"账户余额"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent= NO;
    self.tabBarController.tabBar.translucent=NO;
    self.view.backgroundColor = COLOR_03;
    self.tableHeaderBottomView.hidden = YES;
    [self updataUserInfo:self.userInfo];
}

-(BOOL)isLogin{
    AppDelegate * appDeleage = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [appDeleage isLogin];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
    self.navigationController.navigationBarHidden = YES;
    AppDelegate * appDeleage = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.userInfo = appDeleage.userInfo;

    [self updateLoginStatus];
    if ([self isLogin]) {
        [self requestOrderCount];
        [self requestAccountBlance];
    }
    else{
        [ShowMessage showMessage:@"您尚未登录"];
        [self reloadOrderStauCell];
        [self refreshAccountBalance:nil];
    }
    
}

-(void)reloadOrderStauCell{
    [self.userCenterTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //    self.view.frame = [UIScreen mainScreen].bounds;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}
#pragma mark -- 更新状态
-(void)hideBondMemberLable{
//    self.bondMemberLabel.hidden = YES;
//    self.useLabel.hidden = YES;
//    self.memberLabel.hidden = YES;
//    self.linkBtn.hidden = YES;
//    self.bondMemberLabel.text = @"";
//    self.useLabel.text = @"";
//    self.memberLabel.text = @"";
//    [self.linkBtn setTitle:@"" forState:UIControlStateNormal];
}
-(void)showBondMemberLabelWithMemberName:(NSString *)memberName{
//    self.bondMemberLabel.text = memberName;
//    self.useLabel.text = @"您正在借用";
//    self.memberLabel.text = @"的会员卡购物";
//    
//    self.useLabel.hidden = NO;
//    self.memberLabel.hidden = NO;
//    self.bondMemberLabel.hidden = NO;
//    self.linkBtn.hidden = NO;
//    self.linkBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
//    
//    [self.linkBtn setTitle:@"了解详情" forState:UIControlStateNormal];
}

-(void)updateLoginStatus{
    if (self.isLogin) {
        self.userNameLabel.userInteractionEnabled = NO;
        self.userNameLabel.text = self.userInfo.name;
        self.tableHeaderBottomView.hidden = YES;
        //        [self requestMemberBondInfo];
        [self updateUserInfo];
    }else{
        self.userNameLabel.userInteractionEnabled = YES;
        self.userNameLabel.text = @"请登录";
        self.tableHeaderBottomView.hidden = YES;
        self.userHeaderImageView.image = [UIImage imageNamed:@"default_head.png"];
        //        [self hideBondMemberLable];
    }
}
#pragma mark -- 请求数据
-(void)updateUserInfo{
    
    //获取ST之后请求用户基本信息
    [PassportService getUserInfoWithHeadParams:nil bodyParams:nil callBack:^(UserInfoModel *userInfo, NSError *error) {
        if (error) {
            
        }else{
            UserInfoModel * model = userInfo;
            AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [Userinfo setLoginSatuts:@"1"];
            appdelegate.userInfo = userInfo;
            [self updataUserInfo:model];
            
        }
    }];
    
    
}
-(void)requestOrderCount{
    __weak typeof(self)wSelf = self;
    [BKService GetOrderStatusAmount:nil callback:^(id obj,NSError* error) {
        if (error) {
            
        }else{
            ShoppingCarCommon * shopingCarCommon = obj;
            wSelf.shopingCarCommon = shopingCarCommon;
            [wSelf.userCenterTableView reloadData];
        }
    }];
}
-(void)requestAccountBlance{
    __weak typeof(self)wSelf = self;
    [CashDeskService getAvailableMoenyCompeletion:^(id obj, NSError *error) {
        NSArray * accountArr;
        if (error) {
            
        }else{
            accountArr = obj;
            
        }
        [wSelf refreshAccountBalance:accountArr];
    }];
}


-(void)requestMemberBondInfo{
    
    [CashDeskService getMenberBind:^(id obj, NSError *error) {
        if (error) {
            
        }else{
            NSDictionary * bondInfo = obj;
            
            
            if (![[bondInfo objectForKey:@"buy_available"] boolValue]) {
                [self showBondMemberLabelWithMemberName:[bondInfo objectForKey:@"member_name"]];
            }else{
                [self hideBondMemberLable];
            }
        }
    }];
}


-(void)refreshAccountBalance:(NSArray *)accountArr{
    if (accountArr == nil) {
        self.accountMoneyInfo = [[NSMutableAttributedString alloc] initWithString:@"账户余额"];
    }else{
        __block CGFloat allMoney = 0;
        [accountArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            AccountInfoModel * model = obj;
            allMoney = allMoney+[model.banlance floatValue];
        }];
        NSString * account = [NSString stringWithFormat:@"账户余额: %.2f元",allMoney];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:account] ;
        NSRange detail  = [account rangeOfString:[NSString stringWithFormat:@"%.2f",allMoney]];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:detail];
        self.accountMoneyInfo = attributedString;
    }
    [self reloadAccountBlanceCell];
}


-(void)reloadAccountBlanceCell{
    
    if (self.isLogin) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:UserCenterTableViewSectionAccountBlance];
        [self.userCenterTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark -- tableView 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == UserCenterTableViewSectionOrder) {
        return 2;
    }else if (section == UserCenterTableViewSectionSet){
        return 1;
    }else if (section == UserCenterTableViewSectionManagerReutrn){
        return 2;
        
    }else if (section == UserCenterTableViewSectionAccountBlance&& [[Userinfo getLoginSatuts]isEqualToString:@"1"]){
        return 2;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == UserCenterTableViewSectionOrder) {
        if (indexPath.row == 0) {
            
            return 45;
        }else{
            return 65;
        }
    }else if (indexPath.section == UserCenterTableViewSectionSet){
        return 45;
    }else if (indexPath.section == UserCenterTableViewSectionManagerReutrn){
        return 45;
    }else if (indexPath.section == UserCenterTableViewSectionAccountBlance&& [[Userinfo getLoginSatuts]isEqualToString:@"1"]){
        return 45;
    }else{
        return 0.1;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.selected = NO;
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    if (indexPath.section == UserCenterTableViewSectionSet) {
        UserSetViewController * setViewController = [[UserSetViewController alloc] init];
        [self.navigationController pushViewController:setViewController animated:YES];
    }else if (indexPath.section == UserCenterTableViewSectionOrder){
        if (indexPath.row == 0) {
            return;
            //            AllOrderController * allOrder = [[AllOrderController alloc] init];
            //            allOrder.tabBarController.hidesBottomBarWhenPushed = YES;
            //            [self.navigationController pushViewController:allOrder animated:YES];
        }
    }else if (indexPath.section == UserCenterTableViewSectionManagerReutrn){
        if (indexPath.row == 0) {
            if (app.isLogin) {
                MySaveViewController * myCollectoin = [[MySaveViewController alloc] init];
                [self.navigationController pushViewController:myCollectoin animated:YES];
            }
            else{
                LoginController *loginVC = [[LoginController alloc] init];
                BKNavigationController * navc = [[BKNavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:navc animated:YES completion:nil];
            }
        }
        //        else if (indexPath.row == 1){
        //            OrderReturnManagerController *orderReturnVC = [[OrderReturnManagerController alloc] init];
        //            orderReturnVC.tabBarController.hidesBottomBarWhenPushed = YES;
        //            [self.navigationController pushViewController:orderReturnVC animated:YES];
        //        }
        else if (indexPath.row == 1){
            if (app.isLogin) {
                ShopingAddressController * addressVC = [[ShopingAddressController alloc] init];
                [self.navigationController pushViewController:addressVC animated:YES];
            }
            else{
                LoginController *loginVC = [[LoginController alloc] init];
                BKNavigationController * navc = [[BKNavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:navc animated:YES completion:nil];
            }
            
        }
    }else if (indexPath.section == UserCenterTableViewSectionAccountBlance){
        if (indexPath.row == 1) {
            /**
             *  账户余额
             */
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"充值"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField *tf = [alert textFieldAtIndex:0];
            tf.placeholder = @"请输入充值金额";
            [alert show];
            return;

            
//            NSString *url = [strPassport stringByAppendingString:strst];
//            NSString *strurl = [NSString stringWithFormat:@"%@/%@",url,[Userinfo getUserTGT]];
//            NSString *value = [strUTOUUWeb stringByAppendingString:@"recharge"];
//            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:value,@"service", nil];
//            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//            manager.securityPolicy.allowInvalidCertificates = YES;
//            NSMutableDictionary *headDic = [AppControlManager getSTHeadDictionary:dic strurl:strurl];
//            //        NSMutableDictionary * headDic = [AppControlManager getSTHeadDictionary:dic];
//            
//            for (NSString *key in [headDic allKeys]) {
//                NSString *value = [headDic objectForKey:key];
//                [manager.requestSerializer setValue:value forHTTPHeaderField:key];
//            }
//            
//            
//            NSLog(@"\n--------------------->>> headParameters : %@\n", manager.requestSerializer.HTTPRequestHeaders);
//            BOOL isNet = [Common checkNetWorkStatus];
//            if (!isNet) {
//                [ShowMessage showMessage:@"亲,您的手机网络不太顺畅"];
//            }
//            
//            [manager POST:strurl parameters:dic
//                  success:^(AFHTTPRequestOperation *operation,id responseObject) {
//                      NSString *st = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                      OneViewController *oVC = [[OneViewController alloc]init];
//                      oVC.oneRequest = [NSString stringWithFormat:@"%@%@%@",strUTOUUWeb,@"recharge?ticket=",st];
//                      oVC.myTitle = @"充值";
//                      oVC.oneUrl = @"OBJC.executeJs(\"init\",{\n \"platform\":\"app\"\n})";
//                      [self.navigationController pushViewController:oVC animated:YES];
//                      
//                  }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
//                      NSLog(@"Error: %@", error);
//                  }];
        }else if (indexPath.row == 0){
            /**
             *  我的会员卡
             */
            //            ShowDetailController *SDVC = [[ShowDetailController alloc]init];
            //            [self.navigationController pushViewController:SDVC animated:YES];
            
            
            NSString *url = [strPassport stringByAppendingString:strst];
            NSString *strurl = [NSString stringWithFormat:@"%@/%@",url,[Userinfo getUserTGT]];
            NSString *value = [strBKWeb stringByAppendingString:@"profile/vip"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:value,@"service", nil];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.securityPolicy.allowInvalidCertificates = YES;
            NSMutableDictionary *headDic = [AppControlManager getSTHeadDictionary:dic strurl:strurl];
            //        NSMutableDictionary * headDic = [AppControlManager getSTHeadDictionary:dic];
            
            for (NSString *key in [headDic allKeys]) {
                NSString *value = [headDic objectForKey:key];
                [manager.requestSerializer setValue:value forHTTPHeaderField:key];
            }
            
            
            NSLog(@"\n--------------------->>> headParameters : %@\n", manager.requestSerializer.HTTPRequestHeaders);
            BOOL isNet = [Common checkNetWorkStatus];
            if (!isNet) {
                [ShowMessage showMessage:@"亲,您的手机网络不太顺畅"];
            }
            
            [manager POST:strurl parameters:dic
                  success:^(AFHTTPRequestOperation *operation,id responseObject) {
                      NSString *st = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                      
                      requests = [NSString stringWithFormat:@"%@%@%@",strBKWeb,@"profile/vip?ticket=",st];
                      OneViewController *oVC = [[OneViewController alloc]init];
                      oVC.oneRequest = requests;
                      oVC.myTitle = @"我的会员卡";
                      
                      [self.navigationController pushViewController:oVC animated:YES];
                      
                      
                      
                      
                  }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                      NSLog(@"Error: %@", error);
                  }];
            
            
            
            
            
            
        }else if (indexPath.row == 2){
            UserInfoViewController * userInfoVC = [[UserInfoViewController alloc] init];
            userInfoVC.userInfo = self.userInfo;
            [self.navigationController pushViewController:userInfoVC animated:YES];
        
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == UserCenterTableViewSectionSet) {
        return 0.0001;
    }
    if (section == UserCenterTableViewSectionAccountBlance && [[Userinfo getLoginSatuts]isEqualToString:@"0"]){
        return 0.1;
    }
    return 12;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return UserCenterTableViewSectionSet +1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCenterDefaultCell * defaultCell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
    if (indexPath.section == UserCenterTableViewSectionOrder&&indexPath.row == 1) {
        OrderStatuCell * orderStatuCell = [tableView dequeueReusableCellWithIdentifier:@"orderStatusCell"];
        if (orderStatuCell == nil) {
            orderStatuCell = [[OrderStatuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderStatusCell"];
            orderStatuCell.backgroundColor = [UIColor clearColor];
            orderStatuCell.contentView.backgroundColor = [UIColor clearColor];
            orderStatuCell.delegate = self;
            NSArray * imageArr = @[@"\U0000e60f",@"\U0000e60d",@"\U0000e60e",@"\U0000e60c"];
            NSArray * titleArr = @[@"所有订单",@"待付款",@"待发货",@"待收货"];
            //            NSArray * imageArr = @[@"\U0000e60d",@"\U0000e60e",@"\U0000e60c"];
            //            NSArray * titleArr = @[@"待付款",@"待发货",@"待收货"];
            [orderStatuCell updateCellContentViewWithTitleArray:titleArr imageArray:imageArr];
        }
        if (self.isLogin) {
            [orderStatuCell updateCellContentDataWithShoppingCarCommon:self.shopingCarCommon];
            
        }else{
            [orderStatuCell updateCellWithCount:0];
        }
        return orderStatuCell;
    }else{
        if (defaultCell == nil) {
            defaultCell = [[UserCenterDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultlCell"];
            defaultCell.bcLeftTextlabel.font = [UIFont boldSystemFontOfSize:14];
            defaultCell.backgroundColor = [UIColor whiteColor];
            defaultCell.contentView.backgroundColor = [UIColor whiteColor];
            
        }
        if (indexPath.section == UserCenterTableViewSectionOrder) {
            if (indexPath.row == 0) {
                defaultCell.bcLeftTextlabel.text = @"全部订单";
                defaultCell.selectionStyle = UITableViewCellSelectionStyleNone;
                defaultCell.bcRightTextLabel.text = @"";
                defaultCell.hideArrowImage = YES;
                //               defaultCell.showStrokeView = NO
            }
            
        }else if (indexPath.section == UserCenterTableViewSectionSet){
            defaultCell.bcLeftTextlabel.text = @"设置";
            
        }else if (indexPath.section == UserCenterTableViewSectionManagerReutrn){
            if (indexPath.row == 0) {
                defaultCell.bcLeftTextlabel.text = @"我的收藏";
            }else if (indexPath.row == 1){
                //defaultCell.showStrokeView = YES;
                defaultCell.bcLeftTextlabel.text = @"收货地址";
            }
            
        }else if (indexPath.section == UserCenterTableViewSectionAccountBlance){
            if (indexPath.row == 1) {
                defaultCell.bcLeftTextlabel.attributedText = self.accountMoneyInfo;
            }else if (indexPath.row == 0){
                defaultCell.bcLeftTextlabel.text = @"我的会员卡";
            }else if (indexPath.row == 2){
            defaultCell.bcLeftTextlabel.text = @"我的资料";
            }
        }
        
        return defaultCell;
    }
    return nil;
}

-(UITableView *)userCenterTableView{
    if (_userCenterTableView == nil) {
        _userCenterTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _userCenterTableView.delegate = self;
        _userCenterTableView.dataSource = self;
        _userCenterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_userCenterTableView];
        [self layoutTableHeaderView];
        
        [_userCenterTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.top.equalTo(self.view.mas_top).offset(200);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        _userCenterTableView.backgroundColor = [UIColor clearColor];
        
    }
    return _userCenterTableView;
}

-(void)layoutTableHeaderView{
    
    tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.width, 200)];
    //    self.userCenterTableView.tableHeaderView = tableViewHeaderView;
    [self.view addSubview:tableViewHeaderView];
    //    self.userCenterTableView.scrollEnabled =NO;
    UIImageView * tableHeaderBackimage = [[UIImageView alloc] init];
    tableHeaderBackimage.image = [UIImage imageNamed:@"userinfo_bk"];
    [tableViewHeaderView addSubview:tableHeaderBackimage];
    tableHeaderBackimage.backgroundColor = [UIColor greenColor];
    [tableHeaderBackimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tableViewHeaderView.mas_left);
        make.right.equalTo(tableViewHeaderView.mas_right);
        make.top.equalTo(tableViewHeaderView.mas_top);
        make.bottom.equalTo(tableViewHeaderView.mas_bottom);
    }];
    
    UIView * userCenterHeaderImageView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableViewHeaderView addSubview:userCenterHeaderImageView];
    
    userCenterHeaderImageView.backgroundColor = [UIColor clearColor];
    userCenterHeaderImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    userCenterHeaderImageView.layer.borderWidth = 0.3;
    userCenterHeaderImageView.layer.cornerRadius = DefaultUserHeaderView_height/2;
    userCenterHeaderImageView.clipsToBounds = YES;
    
    UITapGestureRecognizer * userHeaderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userNameLabellick:)];
    [userCenterHeaderImageView addGestureRecognizer:userHeaderTap];
    
    [userCenterHeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(tableViewHeaderView.mas_centerX);
        make.centerY.equalTo(tableViewHeaderView.mas_centerY).mas_offset(-20);
        make.width.equalTo(@(DefaultUserHeaderView_height));
        make.height.equalTo(@(DefaultUserHeaderView_height));
        
    }];
    
    UIImageView * userHeaderImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [userCenterHeaderImageView addSubview:userHeaderImage];
    self.userHeaderImageView = userHeaderImage;
    self.userHeaderImageView.image = [UIImage imageNamed:@"default_head.png"];
    userHeaderImage.backgroundColor = COLOR_03;
    userHeaderImage.clipsToBounds = YES;
    userHeaderImage.layer.borderColor =[UIColor whiteColor].CGColor;
    userHeaderImage.layer.borderWidth = 1;
    userHeaderImage.layer.cornerRadius = DefaultUserHeader_Width/2;
    [userHeaderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userCenterHeaderImageView.mas_centerX);
        make.centerY.equalTo(userCenterHeaderImageView.mas_centerY);
        make.width.equalTo(@(DefaultUserHeader_Width));
        make.height.equalTo(@(DefaultUserHeader_Height));
    }];
    
    
    UILabel * tempUserNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [tableViewHeaderView addSubview:tempUserNameLabel];
    self.userNameLabel = tempUserNameLabel;
    [tempUserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userCenterHeaderImageView.mas_bottom).mas_offset(10);
        make.centerX.equalTo(tableViewHeaderView.mas_centerX);
        make.height.equalTo(@(17));
    }];
    tempUserNameLabel.text = @"";
    UITapGestureRecognizer * userNameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userNameLabellick:)];
    [tempUserNameLabel addGestureRecognizer:userNameTap];
    tempUserNameLabel.font = [UIFont boldSystemFontOfSize:15];
    tempUserNameLabel.textColor = [UIColor  whiteColor];
    
    
}


-(void)updataUserInfo:(UserInfoModel *)userInfo{
    self.userNameLabel.text = userInfo.name;
    [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.photo] placeholderImage:[UIImage imageNamed:@"default_head.png"]];
}


-(void)userNameLabellick:(UITapGestureRecognizer *)tap{
    /**
     *  没有登录 则跳入登陆界面 登陆以后暂时不操作
     */
    if (self.isLogin) {
        return;
    }else{
        LoginController * loginVC = [[LoginController alloc] init];
        loginVC.isFromPresent = YES;
        
        __weak typeof(self)wSelf = self;
        
        [loginVC setLoginSucessCallBack:^(UserInfoModel *userModel) {
            wSelf.userInfo = userModel;
            [wSelf updataUserInfo:userModel];
        }];
        
        BKNavigationController * navc = [[BKNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navc animated:YES completion:nil];
    }
    
}

-(void)buttonClick:(UIButton *)clickButton{
    if (clickButton == self.shopCollect.button) {
        /**
         *  进入商品收藏
         */
        
    }else if (clickButton == self.myMake.button){
        /**
         *  进入我的定制
         */
        
    }
}
-(void)onButtonClickWithIndex:(OrderStatuViewType)type{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if (app.isLogin) {
        AllOrderController * allOrderVC = [[AllOrderController alloc] init];
        
        allOrderVC.type = type;
        [self.navigationController pushViewController:allOrderVC animated:YES];
    }
    else{
        LoginController *loginVC = [[LoginController alloc] init];
        BKNavigationController * navc = [[BKNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navc animated:YES completion:nil];
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    tableViewHeaderView = nil;
    self.userHeaderImageView = nil;
    self.userNameLabel = nil;
    self.shopCollect = nil;
    self.myMake = nil;
    self.tableHeaderBottomView = nil;
    self.userInfo = nil;
    self.shopingCarCommon = nil;
    [self.userCenterTableView removeFromSuperview];
    self.  userCenterTableView = nil;
    self.bondMemberLabel = nil;
    self.  useLabel = nil;
    self. memberLabel = nil;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSString * money = textField.text;
        if (![money isEqualToString:@""]) {
            NSLog(@"充值金额%@",money);
            if ([self checkRechargeMoney:[money integerValue]]) {
                [PassportService rechargeMoneyWithMoney:money callback:^(id obj,NSError* error) {
                    ALiPayResult * result = obj;
                    if (result.error) {
                        [ShowMessage showMessage:result.error.domain];
                    }else{
                        [ShowMessage showMessage:@"充值成功" withCenter:self.view.center];
                        [self requestAccountBlance];
                    }
                }];
            }else{
                return;
            }

        }else{
            [ShowMessage showMessage:@"请输入金额" withCenter:self.view.center];
            return;
        }
    }
    
}

-(BOOL)checkRechargeMoney:(NSInteger)money{

    if (money<100) {
        [ShowMessage showMessage:@"充值金额最小为100元" withCenter:self.view.center];
        return NO;
    }else if (money >99999999){
        [ShowMessage showMessage:@"充值金额需小于99999999" withCenter:self.view.center];
        return NO;
    }else if (money%100 !=0){
        [ShowMessage showMessage:@"充值金额必须为100的倍数" withCenter:self.view.center];
        return NO;
    }
    return YES;
}


@end

