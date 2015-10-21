//
//  ViewController.m
//  MobileUU
//  版本V1.0修改格式                               万黎君
//  版本V1.1将udid放入缓存                         万黎君
//  版本V1.2套用新登陆方法   更改代码                万黎君
//  版本V1.3获取到用户基本信息后在获取详细信息         万黎君
//  版本V1.4增加注册功能                            万黎君
//  Created by 王義傑 on 14-5-29.
//  Copyright (c) 2014年 Shanghai Pecker Network Technology Co., Ltd. All rights reserved.
//

#import "LoginController.h"
#import "HomeViewController.h"
#import "Userinfo.h"
#import "InterfaceURLs.h"
#import "CacheFile.h"
#import "HCRKeyChain.h"
#import "MD5.h"
#import "AppDelegate.h"
#import "PassportService.h"
#import "Result.h"
#import "RequestFromServer.h"
#import "AppControlManager.h"
#import "Common.h"
#import "Masonry.h"
#import "RegisterController.h"
#import "WPTextField.h"
#import "PrefixHeader.pch"
#import "UserInfoModel.h"
#import "AppDelegate.h"

#import "MBProgressHUD.h"

#define  IMAGE_AUTORESIZINGMASK  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
#define IMAGE_CONTENTMODE UIViewContentModeScaleAspectFill
#define DEVICE_IS_IPHONR5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define RGB(__r, __g, __b)  [UIColor colorWithRed:(1.0*(__r)/255)\
green:(1.0*(__g)/255)\
blue:(1.0*(__b)/255)\
alpha:1.0]
#define TEXTCOLOR RGB(202, 202, 207)
@interface LoginController ()<UIAlertViewDelegate,UITextFieldDelegate>{
    WPTextField *userNumber;             //用户名
    WPTextField *userPassword;           //密码
    UIButton *loginBtn;                  //登陆按钮
    UIButton *registerBtn;               //注册按钮
    //    UIButton *findBtn;                   //找回密码
    UITextField *verifyCode_textField;   //验证码输入框
    UIButton *verifyCodeBtn;            //获取验证码
    NSString *userid;
    BOOL canLogin;
    UILabel *messageLabel;              //提示信息
    UIImageView *leftView;
    UIButton *leftButton;
    
}

@property(nonatomic, strong)Result *loginResult;
@property(nonatomic, strong) CacheFile *cf;

@end

@implementation LoginController
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    
    if (self) {
        [Common SetSubViewExternNone:self];
    }
    return self;
}

#pragma mark 控件位置及尺寸（系统方法）

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setCancelButton];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0f green:180/255.0f blue:142/255.0f alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.title = @"登录bestkeep";
    canLogin = YES;
    self.view.backgroundColor = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1];
    UIImageView *loginView = [UIImageView new];
    loginView.image = [UIImage imageNamed:@"Loginlog_image.png"];
    loginView.contentMode = IMAGE_CONTENTMODE;
    
    
    messageLabel = [[UILabel alloc]init];
    
    userNumber = [WPTextField new];
    
    userNumber.text =[Userinfo getCellPhone];
    
    userPassword = [WPTextField new];
    
    //userPassword.text =[Userinfo getPWD];
    
    verifyCode_textField = [UITextField new];
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.view addSubview:loginView];
    [self.view addSubview:userNumber];
    [self.view addSubview:userPassword];
    [self.view addSubview:loginBtn];
    [self.view addSubview:registerBtn];
    [self.view addSubview:verifyCode_textField];
    
    
    //提示框
    //messageLabel
    messageLabel.text = @"如果您已有UTOUU账户，请直接登录";
    messageLabel.textColor = [UIColor colorWithRed:120/255.0f green:120/255.0f blue:120/255.0f alpha:1];
    messageLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(@(50));
        make.width.mas_equalTo(@(SCREEN_WIDTH-40));
    }];
    
    //账号输入框
    //userNumber
    userNumber.backgroundColor = [UIColor whiteColor];
    [userNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(50);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.height.mas_equalTo(@(50));
        make.width.mas_equalTo(@(SCREEN_WIDTH));
    }];
    
    
    //密码输入框
    //userPassword
    userPassword.backgroundColor = [UIColor whiteColor];
    [userPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userNumber.mas_bottom).offset(-1);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.height.mas_equalTo(@(50));
        make.width.mas_equalTo(@(SCREEN_WIDTH));
    }];
    
    //登录按钮
    //loginBtn
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userPassword.mas_bottom).offset(15);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(@(50));
        make.width.mas_equalTo(@(SCREEN_WIDTH-40));
    }];
    
    
    //注册按钮
    //registerBtn
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(@(SCREEN_HEIGHT/8));
        make.width.mas_equalTo(@(SCREEN_HEIGHT/4));
    }];
    //loginView
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-SCREEN_HEIGHT/9+20);
        make.height.mas_equalTo(@(SCREEN_HEIGHT/3));
        make.width.mas_equalTo(@(SCREEN_HEIGHT/3*400/614));
    }];
    
    
    
    
    //ACCOUNT输入框
    [userNumber setBorderStyle:UITextBorderStyleNone];
    userNumber.layer.borderWidth = 1.0;
    userNumber.layer.borderColor = RGB(221, 221, 221).CGColor;
    userNumber.textColor = TEXTCOLOR;
    userNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel *label1 = [[UILabel alloc] init];
    UIFont *iconfont =[UIFont fontWithName:@"iconfont" size:17];
    label1.font=iconfont;
    label1.textColor = COLOR_02;
    label1.text =@"\U0000e62c";
    [self textFieldCommon:userNumber title:@"请输入手机号码" leftView:label1];
    label1.frame = CGRectMake(0, 0,20,20);
    
    
    NSString *userName = [Userinfo getCellPhone];
    
    if ([userName isEqualToString:@""] || userName == nil ||[userName isEqualToString:@"****"]) {
        
        userNumber.placeholder = @"请输入手机号码";
        
    }
    else{
        
        userNumber.text = userName;
        
        //userPassword.text = [Userinfo getPWD];
        
    }
    
    [userNumber setKeyboardType:UIKeyboardTypeNumberPad];
    
    UIImageView *userimgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userlogin.png"]];
    
    [userimgv setFrame:CGRectMake(5, 7.5, 25, 25)];
    
    userimgv.contentMode = IMAGE_CONTENTMODE;
    
    [userNumber addSubview:userimgv];
    
    
    //PASSWORD 输入框
    userPassword.tag = 1000;
    [userPassword setBorderStyle:UITextBorderStyleNone];
    userPassword.layer.borderWidth = 1.0;
    userPassword.layer.borderColor = RGB(221, 221, 221).CGColor;
    userPassword.textColor = TEXTCOLOR;
    //userPassword.placeholder = @"请填写登陆密码";
    UILabel *pass = [[UILabel alloc]init];
    UIFont *iconfont1 =[UIFont fontWithName:@"iconfont" size:17];
    pass.font = iconfont1;
    pass.text =@"\U0000e625";
    pass.textColor = COLOR_02;
    [self textFieldCommon:userPassword title:@"请填写登录密码" leftView:pass];
    pass.frame =CGRectMake(0, 0, 20, 20);
    
    UIImageView *pwdimgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"key.png"]];
    pwdimgv.contentMode = IMAGE_CONTENTMODE;
    [pwdimgv setFrame:CGRectMake(5, 7.5, 25, 30)];
    [userPassword addSubview:pwdimgv];
    
    userPassword.secureTextEntry = YES;
    //userPassword.delegate = self;
    userPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    //LOGIN按钮
    loginBtn.layer.cornerRadius = 5;
    [loginBtn addTarget:self
                 action:@selector(loginBtnTouched)
       forControlEvents:UIControlEventTouchUpInside];
    
    [loginBtn setTitle:@"登录"
              forState:UIControlStateNormal];
    
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
    loginBtn.backgroundColor= [UIColor colorWithRed:25/255.0f green:180/255.0f blue:142/255.0f alpha:1];
    ;
    
    [loginBtn setTitleColor:[UIColor whiteColor]
                   forState:UIControlStateNormal];
    
    loginBtn.showsTouchWhenHighlighted = YES;
    
    //REGISTERBUTTON  注册按钮
    registerBtn.contentMode = IMAGE_CONTENTMODE;
    [registerBtn addTarget:self action:@selector(registerBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn setTitle:@"注册账户" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor colorWithRed:120/255.0f green:120/255.0f blue:120/255.0f alpha:1] forState:UIControlStateNormal];
    //    [registerBtn setImage:[UIImage imageNamed:@"register.png"]
    //                 forState:UIControlStateNormal];
    //
    //    [registerBtn setImage:[UIImage imageNamed:@"register_pressdown.png"]
    //                 forState:UIControlStateHighlighted];
}


-(void)setCancelButton{
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 40, 45);
    
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(dismissself) forControlEvents:UIControlEventTouchUpInside];
}

-(void)dismissself{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 点击事件-验证输入框的内容
-(void) loginBtnTouched{
    if (canLogin) {
        NSString *usr = userNumber.text;
        
        NSString *pwd = userPassword.text;
        
        if (userNumber.text.length ==0) {
            
            [Common AlertViewTitle:@"提示"
                           message:@"账号不能为空"
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
            
            [userNumber becomeFirstResponder];
            
        }
        else  if (userNumber.text.length !=11) {
            
            [Common AlertViewTitle:@"提示"
                           message:@"账号错误"
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
            
            [userNumber becomeFirstResponder];
            
        }
        else if (userPassword.text.length == 0){
            
            [Common AlertViewTitle:@"提示"
                           message:@"密码不能为空"
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
            
            [userNumber becomeFirstResponder];
            
        }
        else{
            
            [self LoginAccount:usr password:pwd];//验证账号
            
        }
        
    }
}

#pragma mark 登录方法
-(void)LoginAccount:(NSString*)account
           password:(NSString*)password{
    canLogin = NO;
    NSString *udid = [Common createUDID];
    [Userinfo setUserCellPhoneUDID:udid];
    

    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:@"正在加载"];
    
    NSString *token = [Userinfo getUserDevicetoken];
    
    if (token == nil) {
        token = @"";
    }
    
    NSString *app_Version = [Common getAppVersion];
    NSString *time = [MD5 getSystemTime];
    

    
    //原始参数表->用于生成sign
    NSDictionary *dicOrginalParameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                          account,@"username",
                                          password,@"password",
                                          udid,@"device_udid",
                                          @"10",@"device_type",
                                          app_Version,@"version",
                                          token,@"device_token",
                                          @"bestkeep",@"app_name",
                                          nil];
    //生成sign
    NSString *strSign = [MD5 md5:dicOrginalParameters time:time];
    
    //登陆参数
    NSDictionary *dicParameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                   account,@"username",
                                   password,@"password",
                                   udid,@"device_udid",
                                   @"10",@"device_type",//ios,2  ios-p,3
                                   app_Version,@"version",
                                   time,@"time",
                                   strSign,@"sign",
                                   token, @"device_token",
                                   @"bestkeep",@"app_name",
                                   nil];
    
    __weak typeof(self) wSelf = self;
    //请求
    [PassportService login:nil :dicParameters :^(id obj,NSError * error) {
        
        if (error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            canLogin = YES;
            //[ShowMessage showMessage:@"登录失败" withCenter:self.view.center];
        }else{
            self.loginResult =(Result *) obj;
            
            
            NSString *LoginMessage = self.loginResult.msg;
            
            if (wSelf.loginResult.success == 1) {
                
                
                [Userinfo setLoginSatuts:@"1"];
                
                [Userinfo setPWD:password];
                
                [Userinfo setCellPhone:userNumber.text];
                
                [self updateUserInfo];
                
                //            [CacheFile WriteToFile];
                
                NSLog(@"登录成功");
                
            }else{
                canLogin = YES;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [Common AlertViewTitle:@"提示"
                               message:LoginMessage
                              delegate:self
                     cancelButtonTitle:@"确定"
                     otherButtonTitles:nil];
                userPassword.text = @"";
                
                NSLog(@"登录结果为:%@",self.loginResult.msg);
            }

        }
        
    }];
}
-(void)updateUserInfo{
    
    if([[Userinfo getLoginSatuts]isEqualToString:@"1"]){
        //获取请求参数头
        
        //获取ST之后请求用户基本信息
        [PassportService getUserInfoWithHeadParams:nil bodyParams:nil callBack:^(UserInfoModel *userInfo, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            if (error) {
                NSLog(@"调取信息失败");
                canLogin = YES;
                [ShowMessage showMessage:@"登录失败"];
            }else{
                UserInfoModel * model = userInfo;
                AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appdelegate.userInfo = userInfo;
                [Common AlertViewTitle:@"提示"
                               message:@"登录成功"
                              delegate:self
                     cancelButtonTitle:@"确定"
                     otherButtonTitles:nil];
                
                self.LoginSucessCallBack?self.LoginSucessCallBack(model):nil;
                
                NSLog(@"调取基本信息成功");
                canLogin = YES;
            }
        }];
        
    }else{
        canLogin = YES;
    }
    
}

#pragma 点击屏幕任意地方隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [userNumber resignFirstResponder];
    [userPassword resignFirstResponder];
    [verifyCode_textField resignFirstResponder];
    
}
-(void)registerBtnTouched{
    
    RegisterController *registerVC = [[RegisterController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    //[self.navigationController didMoveToParentViewController:registerVC];
}


-(void)textFieldCommon:(UITextField*)textField title:(NSString*)title leftView:(UILabel*)leftview{
    
    [textField setBorderStyle:UITextBorderStyleNone];
    
    textField.layer.borderColor = RGB(221, 221, 221).CGColor;
    
    textField.layer.borderWidth = 1.0;
    
    //    textField.secureTextEntry = YES;
    
    textField.placeholder = title;
    
    textField.textColor = COLOR_02;
    
    textField.textAlignment = NSTextAlignmentLeft;
    
    textField.delegate = self;
    
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    //leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftview]];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.leftView = leftview;
    
}


-(void)alertViewCancel:(UIAlertView *)alertView{
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ([Common isLogin]) {
        if (buttonIndex == 0) {
            //            if (self.isFromPresent) {
            //                [self dismissViewControllerAnimated:YES completion:nil];
            //            }else{
            //                [self.navigationController popViewControllerAnimated:YES];
            //            }
            // if (self.isFromPresent) {
            //[self dismissViewControllerAnimated:YES completion:nil];
            //  }else{
            //  [self.navigationController popViewControllerAnimated:YES];
            // }
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    }else{
    }
}

@end
