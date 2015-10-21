//
//  ShowDetailController.m
//  BESTKEEP
//
//  Created by cunny on 15/9/7.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "RechargeController.h"
//#import "CashDeskService.h"
#import "Userinfo.h"
#import "AppControlManager.h"
#import "SBJson.h"
@interface RechargeController ()
//@property (nonatomic,strong) UIButton *linkBtn;
@property (nonatomic,strong) UILabel * bondMemberLabel;
@property (nonatomic,strong) UILabel * useLabel;
@property (nonatomic,strong) UILabel * memberLabel;
@end

@implementation RechargeController

-(void)setProgress{
    _progressProxy = [[NJKWebViewProgress alloc] init];
    webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 1.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)setFreshButton{
    
    letButton= [UIButton buttonWithType:UIButtonTypeCustom];
    letButton.frame = CGRectMake(0, 0, 25, 25);
    [letButton setImage:[UIImage imageNamed:@"fresh_image.png"] forState:UIControlStateNormal];
    [letButton setImage:[UIImage imageNamed:@"fresh_image_click.png"] forState:UIControlStateHighlighted];
    letButton.contentMode = UIViewContentModeScaleAspectFill;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:letButton];
    
    [letButton addTarget:self action:@selector(methodtocall) forControlEvents:UIControlEventTouchUpInside];
}

-(void)methodtocall{
    
    @try {
        if(letButton.selected) return;
        letButton.selected=YES;
        
        [self performSelector:@selector(timeEnough) withObject:nil afterDelay:2.0];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}
-(void)timeEnough{
    if (isLoad) {
        letButton.selected=NO;
        
        //    [webView  removeFromSuperview];
        [self loadingWebView];
    }
    
}
-(void)loadingWebView{
    if ([Userinfo getUserTGT] == nil || [[Userinfo getUserTGT] isEqualToString:@""]) {
        [Common LoginController];
    }
    else{
        NSString *url = [strPassport stringByAppendingString:strst];
        NSString *strurl = [NSString stringWithFormat:@"%@/%@",url,[Userinfo getUserTGT]];
        NSString *value = [strUTOUUWeb stringByAppendingString:@"profile/recharge"];
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
                  
                  NSString *message = [NSString stringWithFormat:@"%@%@%@",strUTOUUWeb,@"profile/recharge?ticket=",st];
                  NSURL *url = [NSURL URLWithString:message];
                  NSURLRequest *request = [NSURLRequest requestWithURL:url];
                  
                  webView = [UIWebView new];
                  webView.delegate = self;
                  webView.scalesPageToFit = YES;
                  [webView loadRequest:request];
                  [self.view addSubview:webView];
                  [webView setTranslatesAutoresizingMaskIntoConstraints:NO];
                  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
                  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
                  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
                  [self.view addConstraint:[NSLayoutConstraint constraintWithItem:webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
                  
                  [self setProgress];
                  
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  NSLog(@"Error: %@", error);
              }];
    }
}

- (void)viewDidLoad {
    isLoad=YES;
    isSend = NO;
    [super viewDidLoad];
    [Common SetSubViewExternNone:self];
    self.title = @"充值";
    //    [self setFreshButton];
    [self loadingWebView];
}
-(void)goBack:(id)sender
{
    [webView goBack];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (isSend) {
        
        NSString *requestString = [[request URL] absoluteString];
        requestString =  [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSUInteger range = [requestString rangeOfString:@"{"].location;
        NSString *b = [requestString substringFromIndex:range];
        NSDictionary *param_dic  = [b JSONValue];
        NSDictionary *sms = [param_dic objectForKey:@"parameters"];
        NSString *msgNumber = [sms objectForKey:@"msgNumber"];
        NSString * number =  [NSString stringWithFormat:@"sms://%@",msgNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]];
        
        isSend = NO;
        return NO;
    }
    
    else{
        return YES;
    }
}-(void)viewWillDisappear:(BOOL)animated{
    webView = nil;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    isLoad =YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    isLoad=NO;
}
#pragma mark - NJKWebViewProgressDelegate

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    progress = press;
}

@end
