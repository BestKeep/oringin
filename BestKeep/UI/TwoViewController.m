//
//  TwoViewController.m
//  BestKeep
//
//  Created by 魏鹏 on 15/8/18.
//  Copyright (c) 2015年 utouu. All rights reserved.
//

#import "TwoViewController.h"
#import "BKWebView.h"
#import "SBJson.h"
#import <WebKit/WebKit.h>
#import "UTMessageView.h"
#import "AppDelegate.h"
#import "LoginController.h"
#import "BKNavigationController.h"
#import "Userinfo.h"
#import "OneAnotherController.h"
@interface TwoViewController ()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate>

@property BKWebView     *webView;
@property (nonatomic,strong)WKWebView *webView1;
@property (nonatomic,strong)UIProgressView *progress;
@property (nonatomic,strong)UTMessageView * messageView;
@property (nonatomic) BOOL isFirst;
@property (nonatomic,strong) AppDelegate *app;
@property (nonatomic,strong) NSString *isLogin;
@property (nonatomic,strong) NSString *strJS;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"U7";
    self.isFirst = YES;
    if (SysVer < 8.0 ) {
        self.webView = [[BKWebView alloc] initWithFrame:CGRectZero] ;
        [self.view addSubview:self.webView];
        self.webView.delegate = self;
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view. mas_left).offset(0);
            make.top.equalTo(self.view.mas_top).mas_offset(0);
            make.right.equalTo(self.view. mas_right).offset(0);
            make.bottom.equalTo(self.view.mas_bottom).mas_offset(0);
         }];
        NSURL *url =[[NSURL alloc]initWithString:@"http://m.bestkeep.cn/u7?platform=app"];
        NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
        [self.webView loadRequest:request];
    }else{

    _webView1 = [[WKWebView alloc]initWithFrame:CGRectZero];
    _webView1.UIDelegate=self;
    _webView1.navigationDelegate =self;
    [self.view addSubview:_webView1];
    [_webView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.top.equalTo(self.view.mas_top).mas_offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(0);
    }];
    _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2)];
    [self.view addSubview:_progress];
    [_webView1 addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [_webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.test.bestkeep.cn/u7?platform=app"]]];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.messageView.hidden = YES;
    if (SysVer < 8.0) {
        NSURL *url =[[NSURL alloc]initWithString:@"http://m.test.bestkeep.cn/u7?platform=app"];
        NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
        [self.webView loadRequest:request];
        
    }else{
        [_webView1 addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [_webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.test.bestkeep.cn/u7?platform=app"]]];
    }

}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    //html加载完后触发
    self.messageView.hidden=YES;
    [self.messageView removeFromSuperview];
    if (self.oneUrl ==nil || [self.oneUrl isEqualToString:@""]) {
        [self.webView stringByEvaluatingJavaScriptFromString: @"OBJC.executeJs(\"init\",\"{}\")"];
    }else{
        [self.webView stringByEvaluatingJavaScriptFromString: self.oneUrl];
        
    }
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.messageView removeFromSuperview];
    [_progress setProgress:0.0 animated:false];
    if (self.strJS == nil || [self.strJS isEqualToString:@""]) {
        [_webView1 evaluateJavaScript:@"OBJC.executeJs(\"init\",\"{}\")" completionHandler:nil];
    }
    else{
        [_webView1 evaluateJavaScript:self.strJS completionHandler:nil];
    }
    
}
#pragma mark -加载条
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"]&&object==_webView1) {
        [_progress setAlpha:1.0f];
        [_progress setProgress:_webView1.estimatedProgress animated:YES];
        if (_webView1.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [_progress setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [_progress setProgress:0.0f animated:NO];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)dealloc {
    [_webView1 removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView1 setNavigationDelegate:nil];
    [_webView1 setUIDelegate:nil];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.messageView removeFromSuperview];
//    if (error) {
//        self.messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"\U0000e606" emptyText:@"加载失败~" buttonTitle:@"重新加载" animationed:YES];
//        __weak typeof(self)wSelf = self;
//        [self.messageView setRetryBlock:^{
//           NSURL *url =[[NSURL alloc]initWithString:@"http://m.test.bestkeep.cn/u7"];
//            NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
//            [wSelf.webView1 loadRequest:request];
//        }];
//    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.messageView removeFromSuperview];
    if (error) {
//        self.messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"\U0000e606" emptyText:@"加载失败~" buttonTitle:@"重新加载" animationed:YES];
//        __weak typeof(self)wSelf = self;
//        [self.messageView setRetryBlock:^{
//            NSURL *url =[[NSURL alloc]initWithString:@"http://m.test.bestkeep.cn/u7"];
//            NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
//            [wSelf.webView loadRequest:request];
//        }];
     }
}

-(BOOL)IsLogin{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    return app.isLogin;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *requestString =[request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *header =@"http://objc/";
    if ([requestString rangeOfString:header].location != NSNotFound) {
        
        NSArray *components = [requestString componentsSeparatedByString:@"http://objc/"];
        if ([components count] >1 ) {
            NSUInteger range = [requestString rangeOfString:@"{"].location;
            NSString *b = [requestString substringFromIndex:range];
            NSDictionary *param_dic  = [b JSONValue];
            if ([[param_dic objectForKey:@"action"]isEqualToString:@"open"]) {
                NSString *strLogin = [param_dic objectForKey:@"needLogin"];
                if ([strLogin isEqualToString:@"1"]) {
                    if (![self IsLogin]) {
                        LoginController *loginVC = [[LoginController alloc]init];
                        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
                        [self presentViewController:nv animated:YES completion:nil];
                    }else {
                        NSString *target = [param_dic objectForKey:@"target"];
                        NSString *url = [strPassport stringByAppendingString:strst];
                        NSString *strurl = [NSString stringWithFormat:@"%@/%@?%@",url,[Userinfo getUserTGT],@"platform=app"];
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:target,@"service", nil];
                        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                        manager.securityPolicy.allowInvalidCertificates = YES;
                        NSMutableDictionary *headDic = [AppControlManager getSTHeadDictionary:dic strurl:strurl];
                        for (NSString *key in [headDic allKeys]) {
                            NSString *value = [headDic objectForKey:key];
                            [manager.requestSerializer setValue:value forHTTPHeaderField:key];
                        }
                        NSLog(@"\n--------------------->>> headParameters : %@\n", manager.requestSerializer.HTTPRequestHeaders);
                        BOOL isNet = [Common checkNetWorkStatus];
                        if (!isNet) {
                            [ShowMessage showMessage:@"亲,您的手机网络不太顺畅"];
                        }
                       // __weak typeof(self) wSelf = self;
                        [manager POST:strurl parameters:dic
                              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                                  NSString *st = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                  NSString *strUrl = [NSString stringWithFormat:@"%@?%@%@",target,@"ticket=",st];
                                  [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]]];
                                  
                              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                                  
                                  NSLog(@"Error: %@", error);
                              }];
                        
                    }
                }
                else{
                    NSString *target = [param_dic objectForKey:@"target"];
                    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",target,@"platform=app"]]]];
                }
            }
            
            else if ([[param_dic objectForKey:@"action"] isEqualToString:@"close"]){
                [self.webView goBack];
                
            }
            
        }
    }

    return YES;
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *requestString =[navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *header =@"http://objc/";
    if ([requestString rangeOfString:header].location != NSNotFound) {
        
        NSArray *components = [requestString componentsSeparatedByString:@"http://objc/"];
        if ([components count] >1 ) {
            NSUInteger range = [requestString rangeOfString:@"{"].location;
            NSString *b = [requestString substringFromIndex:range];
            NSDictionary *param_dic  = [b JSONValue];
            if ([[param_dic objectForKey:@"action"]isEqualToString:@"open"]) {
                if ([[param_dic allKeys] containsObject:@"needLogin"]) {
                    NSString *strLogin = [param_dic objectForKey:@"needLogin"];
                    if ([strLogin isEqualToString:@"1"]) {
                        if (![self IsLogin]) {
                            LoginController *loginVC = [[LoginController alloc]init];
                            BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
                            [self presentViewController:nv animated:YES completion:nil];
                        }else {
                            NSString *target = [param_dic objectForKey:@"target"];
                            NSString *url = [strPassport stringByAppendingString:strst];
                            NSString *strurl = [NSString stringWithFormat:@"%@/%@?%@",url,[Userinfo getUserTGT],@"platform=app"];
                            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:target,@"service", nil];
                            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                            manager.securityPolicy.allowInvalidCertificates = YES;
                            NSMutableDictionary *headDic = [AppControlManager getSTHeadDictionary:dic strurl:strurl];
                            for (NSString *key in [headDic allKeys]) {
                                NSString *value = [headDic objectForKey:key];
                                [manager.requestSerializer setValue:value forHTTPHeaderField:key];
                            }
                            NSLog(@"\n--------------------->>> headParameters : %@\n", manager.requestSerializer.HTTPRequestHeaders);
                            BOOL isNet = [Common checkNetWorkStatus];
                            if (!isNet) {
                                [ShowMessage showMessage:@"亲,您的手机网络不太顺畅"];
                            }
                            //__weak typeof(self) wSelf = self;
                            [manager POST:strurl parameters:dic
                                  success:^(AFHTTPRequestOperation *operation,id responseObject) {
                                      NSString *st = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                      NSString *strUrl = [NSString stringWithFormat:@"%@?%@%@",target,@"ticket=",st];
                                      [_webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]]];
                                      
                                  }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                                      
                                      NSLog(@"Error: %@", error);
                                  }];
                            
                        }
                    }
 
                }
                else{
                    NSString *target = [param_dic objectForKey:@"target"];
                    [_webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",target,@"platform=app"]]]];
                }
            }
            else if ([[param_dic objectForKey:@"action"] isEqualToString:@"close"]){
                [self.webView1 goBack];
        }

  }
}
    decisionHandler(WKNavigationActionPolicyAllow);
    return;
}
@end
