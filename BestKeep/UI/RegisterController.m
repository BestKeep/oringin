//
//  RegisterController.m
//  UTOUU
//  1.0 默认小圆圈选中    万黎君
//  Created by cunny on 15/6/8.
//  Copyright (c) 2015年 utouu. All rights reserved.
//

#import "RegisterController.h"
#import "PassportService.h"
#import "Userinfo.h"
#import "UserInfo.h"
#import "InterfaceURLs.h"
#import "HomeViewController.h"
#import "CacheFile.h"
#import "RegisterButton.h"
#import "CXAlertView.h"
#import "WPTextField.h"
#import "MD5.h"
#import "Common.h"
#import "Result.h"
#import "ManagerSetting.h"
#import "AppDelegate.h"
#import "BTLabel.h"
#import "PrefixHeader.pch"

#define  IMAGE_AUTORESIZINGMASK  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
#define IMAGE_CONTENTMODE UIViewContentModeScaleAspectFill
#define DEVICE_IS_IPHONR5 [[UIScreen mainScreen] bounds].size.height
#define RGB(__r, __g, __b)  [UIColor colorWithRed:(1.0*(__r)/255)\
green:(1.0*(__g)/255)\
blue:(1.0*(__b)/255)\
alpha:1.0]
#define TEXTCOLOR RGB(202, 202, 207)
@interface RegisterController ()<UITextFieldDelegate>{
    BOOL click_state;
    UIImageView *leftView;
    UIScrollView *scrollview;
    BTLabel *messageLabel;
    
    
}
@property (nonatomic, strong) WPTextField *account;
@property (nonatomic, strong) WPTextField *password1;
@property (nonatomic, strong) WPTextField *password2;
@property (nonatomic, strong) WPTextField *password3;
@property (nonatomic, strong) WPTextField *verifyCode;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UILabel *inviteLabel;
@property (nonatomic, strong) WPTextField *inviteNumber;
@property (nonatomic, strong) RegisterButton *selectBtn;
@property (nonatomic,strong) UIButton *linkBtn;
@property (nonatomic, strong) UIButton *getCodeBtn;
@property (nonatomic,strong) UILabel *textLabel;
@end

@implementation RegisterController
@synthesize account;
@synthesize password1;
@synthesize password2;
@synthesize registerBtn;
@synthesize inviteLabel;
@synthesize inviteNumber;
@synthesize selectBtn;
@synthesize linkBtn;
@synthesize password3;
@synthesize verifyCode;
@synthesize getCodeBtn;
@synthesize textLabel;
- (void)viewDidLoad {
    
    [Common SetSubViewExternNone:self];
    
    [super viewDidLoad];
    
    self.title = @"注册";
    CGFloat height = 30;
    
    [self.view setBackgroundColor:[UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1]];
    //messageLabel
    messageLabel = [BTLabel new];
    
    //账号
    account = [WPTextField new];
    account.backgroundColor = [UIColor whiteColor];
    //密码
    password1 = [WPTextField new];
    password1.backgroundColor = [UIColor whiteColor];
    //重复密码
    password2 = [WPTextField new];
    password2.backgroundColor = [UIColor whiteColor];
    password3 = [WPTextField new];
    password3.backgroundColor = [UIColor whiteColor];
    //验证码输入框
    verifyCode = [WPTextField new];
    verifyCode.backgroundColor = [UIColor whiteColor];
    textLabel = [UILabel new];
    
    //注册按钮
    registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    inviteLabel = [UILabel new];
    
    //协议
    linkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //验证码
    getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getCodeBtn.backgroundColor = [UIColor whiteColor];
    //小圆圈
    selectBtn = [[RegisterButton alloc] initWithDelegate:self];
    
    [selectBtn setSelected:YES];
    
    click_state = YES;
    
    UILabel *tweetLabel = [UILabel new];
    
    [self.view addSubview:account];
    
    [self.view addSubview:password1];
    
    [self.view addSubview:password2];
    
    [self.view addSubview:registerBtn];
    
    [self.view addSubview:inviteNumber];
    
    [self.view addSubview:inviteLabel];
    
    [self.view addSubview:selectBtn];
    
    [self.view addSubview:linkBtn];
    
    [self.view addSubview:tweetLabel];

    [self.view addSubview:password3];

    [self.view addSubview:verifyCode];
    
    [self.view addSubview:getCodeBtn];
    
    [self.view addSubview:textLabel];
    
    [self.view addSubview:messageLabel];
    
    [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [account setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [password1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [password2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [registerBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [inviteLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [inviteNumber setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [selectBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [linkBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [password3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [verifyCode setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [getCodeBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    

    [account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).mas_offset(15);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@(height+20));
        make.width.equalTo(@(SCREEN_WIDTH));
        
    }];

    
    [password1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(account.mas_bottom).mas_offset(-1);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@(height+20));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];

    [password2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password1.mas_bottom).mas_offset(-1);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@(height+20));
        make.width.equalTo (@(SCREEN_WIDTH));
    }];

    [password3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password2.mas_bottom).mas_offset(-1);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@(height+20));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];

    [verifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password3.mas_bottom).mas_offset(-1);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@(height+20));
        make.width.equalTo(@((SCREEN_WIDTH)/3*2+1));
    }];

    [getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password3.mas_bottom).mas_offset(-1);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(height+20));
        make.width.equalTo(@((SCREEN_WIDTH)/3));
    }];

    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(getCodeBtn.mas_bottom);
        make.right.equalTo(self.view.mas_right).mas_offset(-20);
        
    }];



    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectBtn.mas_bottom).mas_offset(15);
        make.left.equalTo(self.view.mas_left).mas_offset(10);
        make.height.equalTo(@(height+20));
        make.width.equalTo(@(SCREEN_WIDTH-20));
    }];
  
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(registerBtn.mas_bottom).mas_offset(15);
        make.left.equalTo(self.view.mas_left).mas_offset(10);
        make.height.equalTo(@(height+120));
        make.width.equalTo(@(SCREEN_WIDTH-20));
    }];
    
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verifyCode.mas_bottom).mas_offset(12);
        make.left.equalTo(self.view.mas_left).mas_offset(10);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
        
    }];
    
    
    [tweetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verifyCode.mas_bottom).mas_offset(15);
        make.left.equalTo(selectBtn.mas_right);
        
    }];
    
    [linkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verifyCode.mas_bottom).mas_offset(10);
        make.left.equalTo(tweetLabel.mas_right);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    UIFont *iconfont =[UIFont fontWithName:@"iconfont" size:22];
    label1.font=iconfont;
    label1.text =@"\U0000e62c";
    label1.textColor = COLOR_02;
    [self textFieldCommon:self.account title:@"请输入手机号码" leftView:label1];
    label1.frame = CGRectMake(0, 0, height, height);
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.font=[UIFont fontWithName:@"iconfont" size:22];
    label2.text =@"\U0000e625";
    label2.textColor = COLOR_02;
    [self textFieldCommon:self.password1 title:@"请输入6～18位密码" leftView:label2];
    label2.frame = CGRectMake(0, 0, height, height);

    UILabel *label3 = [[UILabel alloc] init];
    label3.font=[UIFont fontWithName:@"iconfont" size:22];
    label3.text =@"\U0000e625";
    label3.textColor = COLOR_02;
    [self textFieldCommon:self.password2 title:@"请再次输入密码" leftView:label3];
    label3.frame = CGRectMake(0, 0, height, height);
    
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.font=[UIFont fontWithName:@"iconfont" size:22];
    label4.text =@"\U0000e62f";
    label4.textColor = COLOR_02;
    [self textFieldCommon:self.password3 title:@"请输入暗号" leftView:label4];
    label4.frame = CGRectMake(0, 0, height, height);
    
    UILabel *label5 = [[UILabel alloc] init];
    label5.font=[UIFont fontWithName:@"iconfont" size:22];
    label5.text =@"\U0000e624";
    label5.textColor = COLOR_02;
    [self textFieldCommon:self.verifyCode title:@"请输入图片中的字符" leftView:label5];
    label5.frame = CGRectMake(0, 0, height, height);


    
    self.account.keyboardType = UIKeyboardTypeNumberPad;
    

    textLabel.font = FONT(12);
    
    [getCodeBtn addTarget:self action:@selector(getCodeTouched) forControlEvents:UIControlEventTouchUpInside];
    
    [self applyforVerifyCode];
    
    getCodeBtn.showsTouchWhenHighlighted = YES;
    
    account.secureTextEntry = NO;
    
    password3.secureTextEntry = NO;
    
    verifyCode.secureTextEntry = NO;
    
    //获取验证码按钮属性
    getCodeBtn.layer.borderColor = RGB(221, 221, 221).CGColor;
    
    getCodeBtn.layer.borderWidth = 1.0;
    
    //messageLabel
    
    messageLabel.text = @"提示:注册bestkeep账户即表示您同时注册了UTOUU账户,两个平台共用一个账户体系";
    
    messageLabel.numberOfLines = 0;
    
    messageLabel.verticalAlignment = BTVerticalAlignmentTop;
    
    messageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    
    messageLabel.textColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:1];

    //注册按钮
    [self.registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    
    self.registerBtn.titleLabel.textColor = [UIColor whiteColor];
    
    self.registerBtn.backgroundColor=[UIColor colorWithRed:25/255.0f green:180/255.0f blue:142/255.0f alpha:1];
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.showsTouchWhenHighlighted = YES;
    
    [self.registerBtn addTarget:self
                         action:@selector(registerBtnTouched)
               forControlEvents:UIControlEventTouchDown];
    

    /*utouu注册协议*/
    tweetLabel.textAlignment = NSTextAlignmentLeft;
    
    tweetLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    
    tweetLabel.text = @"同意";
    
    tweetLabel.textColor = [UIColor colorWithRed:127/255.0f green:127/255.0f blue:127/255.0f alpha:1];
    
    [tweetLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.linkBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    
    [self.linkBtn setTitle:@"《UTOUU用户注册协议》" forState:UIControlStateNormal];
    
    self.linkBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    
    [self.linkBtn setTitleColor:[UIColor fromHexValue:0x4c9bff] forState:UIControlStateNormal];
    
    [self.linkBtn addTarget:self
                     action:@selector(ReadDelegatetext)
           forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)textFieldCommon:(UITextField*)textField title:(NSString*)title leftView:(UILabel*)leftview{
    
    [textField setBorderStyle:UITextBorderStyleNone];
    
    textField.layer.borderColor = RGB(221, 221, 221).CGColor;
    
    textField.layer.borderWidth = 1.0;
    
    textField.secureTextEntry = YES;
    
    textField.placeholder = title;
    
    textField.textColor = COLOR_02;
    
    textField.textAlignment = NSTextAlignmentLeft;
    
    textField.delegate = self;
    
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftview]];
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.leftView = leftview;
    
}

-(void)ReadDelegatetext
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"UTOUU用户注册协议" ofType:@"txt"];
    
    NSString *message = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:@"UTOUU用户注册协议" message:message cancelButtonTitle:nil];
    
    alertView.willShowHandler = ^(CXAlertView *alertView) {
        NSLog(@"%@, willShowHandler", alertView);
    };
    alertView.didShowHandler = ^(CXAlertView *alertView) {
        NSLog(@"%@, didShowHandler", alertView);
    };
    alertView.willDismissHandler = ^(CXAlertView *alertView) {
        NSLog(@"%@, willDismissHandler", alertView);
    };
    alertView.didDismissHandler = ^(CXAlertView *alertView) {
        NSLog(@"%@, didDismissHandler", alertView);
    };
    [alertView addButtonWithTitle:@"确定"
                             type:CXAlertViewButtonTypeDefault
                          handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                              [alertView dismiss];

                          }];
    
    [alertView show];
    
}
- (void)didSelectedCheckBox:(RegisterButton *)checkbox checked:(BOOL)checked groupId:(NSString *)groupId
{
    if (checked)
    {
       
        click_state = YES;
        }
    else
    {
        click_state = NO;
        
        
    }
}
#pragma mark 申请验证码接口
-(void)applyforVerifyCode{
   [PassportService applyforVerifyCode:^(id obj,NSError* error) {
       
       if (obj == nil) {
           [getCodeBtn setImage:[UIImage imageNamed:@"default_img_vify.png"] forState:UIControlStateNormal];
       }
       else{
           [getCodeBtn setImage:[UIImage imageWithData:obj] forState:UIControlStateNormal];
       }
       
   }];
}

#pragma 获取验证码按钮
-(void) getCodeTouched{
    [self applyforVerifyCode];//刷新验证码
}
#pragma 注册按钮
-(void)registerBtnTouched
{
    NSString *usr = self.account.text;
    
    NSString *patternCellphone =  @"^((13[0-9])|(14[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
    
    NSRegularExpression *regexCellphone = [NSRegularExpression regularExpressionWithPattern:patternCellphone options:0 error:nil];
    
    NSTextCheckingResult *isMatchCellphone = [regexCellphone firstMatchInString:usr
                                                                        options:0
                                                                          range:NSMakeRange(0, [usr length])];
    if (click_state) {
        if (self.account.text.length == 0) {
            
             [Common AlertViewTitle:@"提示"
                            message:@"请输入手机号码"
                           delegate:nil
                  cancelButtonTitle:@"确定"
                  otherButtonTitles:nil];
            
        }
        else if (!isMatchCellphone){
            
            [Common AlertViewTitle:@"提示"
                           message:@"请输入正确的手机号码"
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
            
        }
        else if (self.password1.text.length ==0) {
            
            [Common AlertViewTitle:@"提示"
                           message:@"请输入密码"
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
            
            [self.password1 becomeFirstResponder];
            
            return;
        }
        else if (self.password2.text.length ==0) {
            
            [Common AlertViewTitle:@"提示"
                           message:@"请再次输入密码"
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
            
            [self.password2 becomeFirstResponder];
            
            return;
            
        }
        else if (self.password1.text.length <6 ) {
            [Common AlertViewTitle:@"提示"
                           message:@"密码长度不能小于6个字符"
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
            
            [self.password2 becomeFirstResponder];
            
            return;

        }
        else if (self.password1.text.length>18){
            [Common AlertViewTitle:@"提示"
                           message:@"密码长度不能大于18个字符"
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
            
            [self.password2 becomeFirstResponder];
            
            return;

        }
        else if (self.verifyCode.text.length == 0){
            
            [Common AlertViewTitle:@"提示"
                           message:@"请输入验证码"
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
            
        }
        else if (![self.password1.text isEqualToString:self.password2.text]){
            
            [Common AlertViewTitle:@"提示"
                           message:@"两次密码输入不一致"
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
            
            [self.password1 becomeFirstResponder];
            
            return;
            
        }
                else{
                    [self registerAccount];
        }
    }
    else{
        
      [Common AlertViewTitle:@"提示"
                     message:@"请阅读UTOUU用户注册协议"
                    delegate:nil
           cancelButtonTitle:@"确定"
           otherButtonTitles:nil];
        
    }
    
}

-(void)unread{



}


#pragma mark 注册方法
-(void)registerAccount{
    
    NSString *cipher;
    if ([self.password3.text isEqualToString:@""]) {
        
        cipher = @"";
        
    }
    else{
        
        cipher = self.password3.text;
        
    }
    
    NSString *time = [MD5 getSystemTime];
    
    NSString *uuid = [ManagerSetting getVerifyCodeUUID];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.account.text,@"account",
                          self.password1.text,@"password",
                          @"12",@"source",
                          @"",@"visitor",
                          cipher,@"cipher",
                          @"",@"openId",
                          verifyCode.text,@"imgVCode",
                          uuid,@"imgVCodeKey", nil];
    
    NSString *sign = [MD5 md5:dic1 time:time];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.account.text,@"account",
                         self.password1.text,@"password",
                         @"12",@"source",
                         @"",@"visitor",
                         cipher,@"cipher",
                         @"",@"openId",
                         verifyCode.text,@"imgVCode",
                         uuid,@"imgVCodeKey",
                         sign,@"sign",
                         time,@"time", nil];
    
    [PassportService registerUserAccount:self:dic :^(id obj,NSError* error) {
        
        Result *register_Result = [[Result alloc]init];
        
        register_Result = (Result *)obj;
        
        if (register_Result.success) {
            
            NSString *message = register_Result.msg;
            [Userinfo setUserName:self.account.text];
            
            [Common AlertViewTitle:@"提示"
                           message:message
                          delegate:self
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
            
        }else{
        
            NSString *message = register_Result.msg;
            
            [Common AlertViewTitle:@"提示"
                           message:message
                          delegate:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil];
        
        }
        
        
    }];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.password1 resignFirstResponder];
    
    [self.password2 resignFirstResponder];
    
    [self.password3 resignFirstResponder];
    
    [self.account resignFirstResponder];
    
    [self.verifyCode resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == verifyCode) {
        
        CGRect frame = textField.frame;
        
        int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
        
        NSTimeInterval animationDuration = 0.30f;
        
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        
        [UIView setAnimationDuration:animationDuration];
        
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        if(offset > 0)
            
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    
     [UIView commitAnimations];
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
