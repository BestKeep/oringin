//
//  OneViewController.m
//  BestKeep
//
//  Created by 魏鹏 on 15/8/18.
//  Copyright (c) 2015年 utouu. All rights reserved.
//

#import "OneAnotherController.h"
#import "BKWebView.h"
#import "AppDelegate.h"
#import "CacheFile.h"
#import "SBJson.h"
#import "UMSocial.h"
#import "BKService.h"
#import "Result.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "ConfirmationIndentViewController.h"
#import "HomeViewController.h"
#import "Userinfo.h"
#import <WebKit/WebKit.h>
#import "UTMessageView.h"
#import "CashDeskService.h"
#import "ALiPayResult.h"
#import "PassportService.h"
#import "FirstPageListDetailViewController.h"
//#import "UIScrollView+MJRefresh.h"
@interface OneAnotherController ()<UMSocialUIDelegate,WKNavigationDelegate,WKUIDelegate,UIAlertViewDelegate>{
    NSString *ispop;
    UTMessageView * messageView;
    AppDelegate *app;
}
@property  (nonatomic, strong)UIWebView *webView;
@property (nonatomic,strong)NSString *isUrl;
@property(nonatomic,strong) NSString *invit;
@property (nonatomic) BOOL isLogin;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong)WKWebView *webView2;
@property (nonatomic,strong)UIProgressView *progressView;
@end

@implementation OneAnotherController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
    app = [[UIApplication sharedApplication] delegate];
    UserInfoModel *Model = app.userInfo;
    self.invit = Model.visitor_code;
    self.isLogin = app.isLogin;
    
    
    if (self.myTitle == nil || [self.myTitle isEqualToString:@""]) {
        self.myTitle =@"首页";
    }
    self.title = self.myTitle;
    //[CacheFile loadLocalUserFile];
    if (SysVer<8.0) {
        self.webView = [[UIWebView alloc] initWithFrame:CGRectZero] ;
        [self.view addSubview:self.webView];
       // [self.webView.scrollView addHeaderWithTarget:self action:@selector(refreshWebView)];
        self.webView.delegate = self;
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view. mas_left).offset(0);
            make.top.equalTo(self.view.mas_top).mas_offset(0);
            make.right.equalTo(self.view. mas_right).offset(0);
            make.bottom.equalTo(self.view.mas_bottom).mas_offset(0);
            
        }];
    }else{
  
    _webView2 = [[WKWebView alloc]initWithFrame:CGRectZero];
    _webView2.UIDelegate =self;
    _webView2.navigationDelegate=self;
    _webView2.hidden = YES;
        [self.view addSubview:_webView2];
        
   // [_webView2.scrollView addHeaderWithTarget:self action:@selector(reloadWebView)];
        
    [_webView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.top.equalTo(self.view.mas_top).mas_offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).mas_offset(0);
    }];
    _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2)];
    [self.view addSubview:_progressView];
        
    }
    if (self.oneAnotherRequest == nil ||[self.oneAnotherRequest isEqualToString:@""]) {
        self.oneAnotherRequest = strIndexhtml;
    }
    if ([self.myTitle isEqualToString:@"收银台"]) {
        ispop = @"1";
    }else if ([self.myTitle isEqualToString:@"收银台 "]){
        ispop = @"2";
    }else if ([self.myTitle isEqualToString:@" 收银台"]){
        ispop = @"3";
    }
    if ([self.hasShop isEqualToString:@"has"]) {
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 0, 25, 25);
        [leftButton setImage:[UIImage imageNamed:@"iconfont-cartfill"] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        [leftButton addTarget:self action:@selector(gotoShop) forControlEvents:UIControlEventTouchUpInside];
    }
    NSURL *url =[[NSURL alloc]initWithString:self.oneAnotherRequest];
    NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
     [_webView2 addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
      [_webView2 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.oneAnotherRequest]]];
}

-(void)reloadWebView{

    [_webView2 addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    [_webView2 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.oneAnotherRequest]]];

}

-(void)refreshWebView{
    NSURL *url =[[NSURL alloc]initWithString:self.oneAnotherRequest];
    NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
     [[AFHTTPRequestOperationManager manager].operationQueue cancelAllOperations];
    app = [[UIApplication sharedApplication] delegate];
    self.invit = [Userinfo getVisitor_code];
    self.isLogin = app.isLogin;
    
    messageView.hidden = YES;
//    self.isLogin = app.isLogin;

    
    if (self.myTitle == nil || [self.myTitle isEqualToString:@""]) {
        self.myTitle =@"首页";
        
       
        
            }
    self.title = self.myTitle;

    if (self.oneAnotherRequest == nil ||[self.oneAnotherRequest isEqualToString:@""]) {
        self.oneAnotherRequest = strIndexhtml;
    }else
    if ([self.hasShop isEqualToString:@"has"]) {
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame = CGRectMake(0, 0, 25, 25);
        [self.leftButton setImage:[UIImage imageNamed:@"iconfont-cartfill"] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
        [self.leftButton addTarget:self action:@selector(gotoShop) forControlEvents:UIControlEventTouchUpInside];
    }

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    messageView.hidden = YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    if (error) {
        [messageView removeFromSuperview];
        if (![self.share isEqualToString:@"share"] && ![self.buy isEqualToString:@"buy"] && ![self.collect isEqualToString:@"collect"] &&![self.addShopCar isEqualToString:@"add"] && ![self.recharge isEqualToString:@"recharge"]) {
            messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"\U0000e606" emptyText:@"加载失败~" buttonTitle:@"重新加载" animationed:YES];
            __weak typeof(self)wSelf = self;
            
            [messageView setRetryBlock:^{
                if (self.oneAnotherRequest!= nil) {
                    NSURL *url =[[NSURL alloc]initWithString:wSelf.oneAnotherRequest];
                    NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
                    [wSelf.webView loadRequest:request];
                    
                }
            }];
            
        }
    }
    //[webView.scrollView headerEndRefreshing];
}

-(void)gotoShop{
     
    if (self.isLogin) {
        BuyCarViewController *bvc =[[BuyCarViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bvc animated:YES];

    }else{
        LoginController *loginVC = [[LoginController alloc]init];
        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
        [self presentViewController:nv animated:YES completion:nil];    
    }
    
}
//wkwebview == webview didFinishLoad
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [_progressView setProgress:0.0 animated:false];
    _webView2.hidden = NO;
    //[webView.scrollView headerEndRefreshing];
    [messageView removeFromSuperview];
    if (self.oneAnotherUrl ==nil || [self.oneAnotherUrl isEqualToString:@""]) {
        
        [_webView2 evaluateJavaScript:@"OBJC.executeJs(\"init\",\"{}\")" completionHandler:nil];
        
    }else{
        [_webView2 evaluateJavaScript:self.oneAnotherUrl completionHandler:nil];
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    //html加载完后触发
    [messageView removeFromSuperview];
    if (self.oneAnotherUrl ==nil || [self.oneAnotherUrl isEqualToString:@""]) {
        [self.webView stringByEvaluatingJavaScriptFromString: @"OBJC.executeJs(\"init\",\"{}\")"];
    }else{
        [self.webView stringByEvaluatingJavaScriptFromString: self.oneAnotherUrl];
        
    }
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.leftButton =nil;
    //[webView.scrollView headerEndRefreshing];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL]absoluteString];//获取请求的绝对路径.
    requestString =  [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *header =@"http://objc/";
    if ([requestString rangeOfString:header].location != NSNotFound)
    {
        NSArray *components = [requestString componentsSeparatedByString:@"http://objc/"];
        if ([components count] >1 ) {
            BOOL shops = NO;
            NSUInteger range = [requestString rangeOfString:@"{"].location;
            NSString *b = [requestString substringFromIndex:range];
            NSDictionary *param_dic  = [b JSONValue];
            NSArray *widget = [param_dic objectForKey:@"widget"];
            if ([widget containsObject:@"shopcarbtn"] ) {
                shops = YES;
                
            }
            if ([[param_dic objectForKey:@"action"] isEqualToString:@"open"]) {
                NSString * number =  [param_dic objectForKey:@"target"];
                //分享
                if ([number isEqualToString:@"share"]) {
                    self.share = @"share";
                    //设置友盟社会化组件appkey
                    NSDictionary *dic = [param_dic objectForKey:@"parameters"];
                   // NSString *goodsName = [dic objectForKey:@"goodsName"];
                    // NSString *goodsNo = [dic objectForKey:@"goodsNo"];
                    NSString *imageUrl = [dic objectForKey:@"imageUrl"];
                    
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                    [UIImage imageWithData:imageData];
                    NSString *shareTitle = [dic objectForKey:@"shareTitle"];
                    //NSString *marketPrice = [dic objectForKey:@"marketPrice"];
                    //NSString *memberPrice = [dic objectForKey:@"memberPrice"];
                    NSString *shareContent = [dic objectForKey:@"shareContent"];
                    //NSString *shareWBContent = [dic objectForKey:@"shareWBContent"];
                    NSString *shareUrl = [dic objectForKey:@"shareUrl"];
                    if (self.invit == nil || !self.isLogin) {
                        LoginController *loginVC = [[LoginController alloc]init];
                        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
                        [self presentViewController:nv animated:YES completion:nil];
                    }else{
                        NSString *shares = [shareUrl stringByReplacingOccurrencesOfString:@"{code}" withString:self.invit];
                        UIImage *images = [UIImage imageWithData:imageData];
                        //微信和朋友圈
                        //                  1WRI360206
                        NSString *com = shares;
                        [UMSocialData setAppKey:@"55d42806e0f55a92f0003530"];
                        //    //设置支持没有客户端情况下使用SSO授权
                        [UMSocialQQHandler setSupportWebView:YES];
                        [UMSocialWechatHandler setWXAppId:@"wx12ade979ef648797" appSecret:@"f9b523512927f15249dad73161d21934" url:com];
                        //qq空间和qq好友
                        [UMSocialQQHandler setQQWithAppId:@"1104759459" appKey:@"ymbLBKw0coxYre0r" url:com];
                        [self shareVideo:images title:shareTitle content:shareContent];
                        
                    }

                    
                }else if([number isEqualToString:@"buy"]){
                    self.buy = @"buy";
                    NSDictionary *dic = [param_dic objectForKey:@"parameters"];
                    NSString *goods_id = [dic objectForKey:@"goods_id"];
                    NSString *amount = [dic objectForKey:@"amount"];
                    NSString *goods_pro_rel1 = [dic objectForKey:@"goods_pro_rel1"];
                    NSString *goods_pro_rel2 = [dic objectForKey:@"goods_pro_rel2"];
                    NSString *goods_pro_rel3 = [dic objectForKey:@"goods_pro_rel3"];
                    NSString *goods_pro_rel4 = [dic objectForKey:@"goods_pro_rel4"];
                    NSString *goods_pro_rel5 = [dic objectForKey:@"goods_pro_rel5"];
                    NSString *goods_reserve_id = [dic objectForKey:@"goods_reserve_id"];
                    NSMutableDictionary *buy_dic = [[NSMutableDictionary alloc]init];
                    NSMutableArray *array = [NSMutableArray new];
                    [buy_dic setObject:goods_id forKey:@"goods_id"];
                    [buy_dic setObject:amount forKey:@"amount"];
                    [buy_dic setObject:goods_pro_rel1 forKey:@"goods_pro_rel1"];
                    [buy_dic setObject:goods_pro_rel2 forKey:@"goods_pro_rel2"];
                    [buy_dic setObject:goods_pro_rel3 forKey:@"goods_pro_rel3"];
                    [buy_dic setObject:goods_pro_rel4 forKey:@"goods_pro_rel4"];
                    [buy_dic setObject:goods_pro_rel5 forKey:@"goods_pro_rel5"];
                    [buy_dic setObject:goods_reserve_id forKey:@"goods_reserve_id"];
                    [array addObject:buy_dic];
                    
                    if (self.isLogin) {
                        ConfirmationIndentViewController *cVC =[[ConfirmationIndentViewController alloc]init];
                        cVC.sc_array = array;
                        cVC.formDetail = @"1";
                        [self.webView stopLoading];
                        [self.navigationController pushViewController:cVC animated:YES];
                    }else{
                        LoginController *loginVC = [[LoginController alloc]init];
                        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
                        [self presentViewController:nv animated:YES completion:nil];
                    }

                }else if([number hasSuffix:@"recharge"]){
                    self.recharge = @"recharge";
                    [self AccountMoneyAnother];
                    
//                    NSString *url = [strPassport stringByAppendingString:strst];
//                    NSString *strurl = [NSString stringWithFormat:@"%@/%@",url,[Userinfo getUserTGT]];
//                    NSString *value = [strUTOUUWeb stringByAppendingString:@"recharge"];
//                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:value,@"service", nil];
//                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//                    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//                    manager.securityPolicy.allowInvalidCertificates = YES;
//                    NSMutableDictionary *headDic = [AppControlManager getSTHeadDictionary:dic strurl:strurl];
//                    for (NSString *key in [headDic allKeys]) {
//                        NSString *value = [headDic objectForKey:key];
//                        [manager.requestSerializer setValue:value forHTTPHeaderField:key];
//                    }
//                    BOOL isNet = [Common checkNetWorkStatus];
//                    if (!isNet) {
//                        [ShowMessage showMessage:@"亲,您的手机网络不太顺畅"];
//                    }
//                    
//                    [manager POST:strurl parameters:dic
//                          success:^(AFHTTPRequestOperation *operation,id responseObject) {
//                              NSString *st = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                              
//                              OneAnotherController *aVC = [[OneAnotherController alloc]init];
//                              aVC.myTitle = @"充值";
//                              aVC.oneAnotherUrl = @"OBJC.executeJs(\"init\",{\n \"platform\":\"app\"\n})";
//                              aVC.oneAnotherRequest =[NSString stringWithFormat:@"%@%@%@",strUTOUUWeb,@"recharge?ticket=",st];
//                              if (shops) {
//                                  aVC.hasShop = @"has";
//                                  
//                              }
//                              //[self.webView2 stopLoading];
//                              [self.navigationController pushViewController:aVC animated:NO];
//                              
//                          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
//                              NSLog(@"Error: %@", error);
//                          }];
                }else{
                    if ([number isEqualToString:@""] || number == nil) {
                    number = @"";
                    }
                    NSDictionary *dic = [param_dic objectForKey:@"parameters"];
                    if (dic == nil) {
                        self.isUrl =@"";
                    }else{
                        NSData *jsonData = [NSJSONSerialization
                                        dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
                    
                        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                                 encoding:NSUTF8StringEncoding];

                        NSString *strUrl = [NSString stringWithFormat:@"OBJC.executeJs(\"init\",%@)",jsonString];
                    
                        self.isUrl = strUrl;
                    
                    }
                    OneViewController *aVC = [[OneViewController alloc]init];
               
                    aVC.myTitle = [dic objectForKey:@"title"];
                    aVC.oneUrl = self.isUrl;
                    aVC.oneRequest = number;
                    if (shops) {
                        aVC.hasShop = @"has";
                        
                    }
                    [self.webView stopLoading];
                    [self.navigationController pushViewController:aVC animated:YES];
                    return YES;
                }
            }else if ([[param_dic objectForKey:@"action"] isEqualToString:@"message"]){
                NSString * number =  [param_dic objectForKey:@"target"];
                if (self.isLogin) {
  
                if ([number isEqualToString:@"collect/add"]) {
                    self.collect = @"collect";
                    NSDictionary *dic = [param_dic objectForKey:@"parameters"];
                    NSString *goods_id = [dic objectForKey:@"goodsId"];
                    NSString *randomKey = [param_dic objectForKey:@"randomKey"];
                    [BKService addGoodsToCollect:goods_id view:nil callback:^(id obj,NSError *error) {
                        Result *collect_result = obj;
                        NSDictionary *dic = (NSDictionary *)collect_result.data;
                        NSString *jsonString = [Common dictionaryToJson:dic];
                        NSString *strUrl = [NSString stringWithFormat:@"OBJC.executeJs(%@,%@)",randomKey,jsonString];
                        
                        if (collect_result.data!=nil) {
                            [self.webView stringByEvaluatingJavaScriptFromString: strUrl];
                            
                        }
                    }];
                }else if ([number isEqualToString:@"collect/delete"]){
                    self.collect = @"collect";
                    NSDictionary *dic = [param_dic objectForKey:@"parameters"];
                    NSString *goods_id = [dic objectForKey:@"goodsId"];
                    NSString *randomKey = [param_dic objectForKey:@"randomKey"];
                    [BKService deleteCollectGoods:goods_id view:nil callback:^(id obj,NSError *error) {
                        Result *collect_result = obj;
                        NSDictionary *dic = (NSDictionary *)collect_result.data;
                        NSString *jsonString = [Common dictionaryToJson:dic];
                        NSString *strUrl = [NSString stringWithFormat:@"OBJC.executeJs(%@,%@)",randomKey,jsonString];
                        
                        if (collect_result.data!=nil) {
                            [self.webView stringByEvaluatingJavaScriptFromString: strUrl];
                            
                        }
                    }];
                }else if ([number isEqualToString:@"shopping-cart/add"]){
                    self.addShopCar = @"add";
                    NSMutableDictionary *dic = [param_dic objectForKey:@"parameters"];
                    [dic removeObjectForKey:@"goods_reserve_id"];
                    NSString *randomKey = [param_dic objectForKey:@"randomKey"];
                    NSString *strjson = [Common dictionaryToJson:dic];
                    [BKService addProduciontoShoppingCar:strjson view:self.view callback:^(id obj,NSError *error) {
                        
                        Result *add_result = obj;
                        NSDictionary *dic = (NSDictionary *)add_result.data;
                        NSString *jsonString = [Common dictionaryToJson:dic];
                        NSString *strUrl = [NSString stringWithFormat:@"OBJC.executeJs(%@,%@)",randomKey,jsonString];
                        if (add_result.data!=nil) {
                            [self.webView stringByEvaluatingJavaScriptFromString: strUrl];
                            
                        }
                        
                        
                    }];
                    
                }

            }
                else{
                    LoginController *loginVC = [[LoginController alloc]init];
                    BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
                    [self presentViewController:nv animated:YES completion:nil];
                }

            }else if ([[param_dic objectForKey:@"action"] isEqualToString:@"close"]){
                [Userinfo setbacktag:@"1"];
                if ([ispop isEqualToString:@"1"]) {
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -3] animated:YES];
                }else if ([ispop isEqualToString:@"2"]){
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else if ([ispop isEqualToString:@"3"]){
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -3] animated:YES];
                }
            }

            return YES;
        }
    }
    return YES;
}
//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
        if (error) {
            //[messageView removeFromSuperview];
            if (![self.share isEqualToString:@"share"] && ![self.buy isEqualToString:@"buy"] && ![self.collect isEqualToString:@"collect"] &&![self.addShopCar isEqualToString:@"add"] && ![self.recharge isEqualToString:@"recharge"]) {
                messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"\U0000e606" emptyText:@"加载失败~" buttonTitle:@"重新加载" animationed:YES];
                [messageView setRetryBlock:^{
                    if (self.oneAnotherRequest!= nil) {
                        NSURL *url =[[NSURL alloc]initWithString:self.oneAnotherRequest];
                        NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url];
                        [_webView2 loadRequest:request];
                        
                    }
                }];
            }
        }
}
//等同于 = webview shouldStartLoadWithRequest:navigation
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSString *requestString =[navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      NSString *header =@"http://objc/";
        if ([requestString hasPrefix:header])
        {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)),dispatch_get_main_queue(),^{
            
            NSArray *components = [requestString componentsSeparatedByString:@"http://objc/"];
            if ([components count] >1 ) {
                BOOL shops = NO;
                NSUInteger range = [requestString rangeOfString:@"{"].location;
                NSString *b = [requestString substringFromIndex:range];
                NSDictionary *param_dic  = [b JSONValue];
                NSArray *widget = [param_dic objectForKey:@"widget"];
                if ([widget containsObject:@"shopcarbtn"] ) {
                    shops = YES;
    
                }
                if ([[param_dic objectForKey:@"action"] isEqualToString:@"open"]) {
                    NSString * number =  [param_dic objectForKey:@"target"];
                    //分享
                    if ([number isEqualToString:@"share"]) {
                        self.share = @"share";
                        //设置友盟社会化组件appkey
                        //messageView.hidden = YES;
                        self.share = @"share";
                        NSDictionary *dic = [param_dic objectForKey:@"parameters"];
                       // NSString *goodsName = [dic objectForKey:@"goodsName"];
                        // NSString *goodsNo = [dic objectForKey:@"goodsNo"];
                        NSString *imageUrl = [dic objectForKey:@"imageUrl"];
    
                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                        [UIImage imageWithData:imageData];
                        NSString *shareTitle = [dic objectForKey:@"shareTitle"];
                        //NSString *marketPrice = [dic objectForKey:@"marketPrice"];
                        //NSString *memberPrice = [dic objectForKey:@"memberPrice"];
                        NSString *shareContent = [dic objectForKey:@"shareContent"];
                        //NSString *shareWBContent = [dic objectForKey:@"shareWBContent"];
                        NSString *shareUrl = [dic objectForKey:@"shareUrl"];
                        if (self.invit == nil || !self.isLogin) {
                            LoginController *loginVC = [[LoginController alloc]init];
                            BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
                            [self presentViewController:nv animated:YES completion:nil];
                        }else{
                            NSString *shares = [shareUrl stringByReplacingOccurrencesOfString:@"{code}" withString:self.invit];
                            UIImage *images = [UIImage imageWithData:imageData];
                            //微信和朋友圈
                            //                  1WRI360206
                            NSString *com = shares;
                            [UMSocialData setAppKey:@"55d42806e0f55a92f0003530"];
                            //    //设置支持没有客户端情况下使用SSO授权
                            [UMSocialQQHandler setSupportWebView:YES];
                            [UMSocialWechatHandler setWXAppId:@"wx12ade979ef648797" appSecret:@"f9b523512927f15249dad73161d21934" url:com];
                            //qq空间和qq好友
                            [UMSocialQQHandler setQQWithAppId:@"1104759459" appKey:@"ymbLBKw0coxYre0r" url:com];
                            [self shareVideo:images title:shareTitle content:shareContent];
    
                        }
    
    
                    }else if([number isEqualToString:@"buy"]){
                        self.buy = @"buy";
                        NSDictionary *dic = [param_dic objectForKey:@"parameters"];
                        NSString *goods_id = [dic objectForKey:@"goods_id"];
                        NSString *amount = [dic objectForKey:@"amount"];
                        NSString *goods_pro_rel1 = [dic objectForKey:@"goods_pro_rel1"];
                        NSString *goods_pro_rel2 = [dic objectForKey:@"goods_pro_rel2"];
                        NSString *goods_pro_rel3 = [dic objectForKey:@"goods_pro_rel3"];
                        NSString *goods_pro_rel4 = [dic objectForKey:@"goods_pro_rel4"];
                        NSString *goods_pro_rel5 = [dic objectForKey:@"goods_pro_rel5"];
                        NSString *goods_reserve_id = [dic objectForKey:@"goods_reserve_id"];
                        NSMutableDictionary *buy_dic = [[NSMutableDictionary alloc]init];
                        NSMutableArray *array = [NSMutableArray new];
                        [buy_dic setObject:goods_id forKey:@"goods_id"];
                        [buy_dic setObject:amount forKey:@"amount"];
                        [buy_dic setObject:goods_pro_rel1 forKey:@"goods_pro_rel1"];
                        [buy_dic setObject:goods_pro_rel2 forKey:@"goods_pro_rel2"];
                        [buy_dic setObject:goods_pro_rel3 forKey:@"goods_pro_rel3"];
                        [buy_dic setObject:goods_pro_rel4 forKey:@"goods_pro_rel4"];
                        [buy_dic setObject:goods_pro_rel5 forKey:@"goods_pro_rel5"];
                        [buy_dic setObject:goods_reserve_id forKey:@"goods_reserve_id"];
                        [array addObject:buy_dic];
    
                        if (self.isLogin) {
                            ConfirmationIndentViewController *cVC =[[ConfirmationIndentViewController alloc]init];
                            cVC.sc_array = array;
                            cVC.formDetail = @"1";
                            [self.webView2 stopLoading];
                            [self.navigationController pushViewController:cVC animated:YES];
                        }else{
                            LoginController *loginVC = [[LoginController alloc]init];
                            BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
                            [self presentViewController:nv animated:YES completion:nil];
                        }
    
                    }else if([number containsString:@"recharge"]){
                        self.recharge = @"recharge";
                        [self AccountMoneyAnother];
//                        NSString *url = [strPassport stringByAppendingString:strst];
//                        NSString *strurl = [NSString stringWithFormat:@"%@/%@",url,[Userinfo getUserTGT]];
//                        NSString *value = [strUTOUUWeb stringByAppendingString:@"recharge"];
//                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:value,@"service", nil];
//                        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//                        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//                        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//                        manager.securityPolicy.allowInvalidCertificates = YES;
//                        NSMutableDictionary *headDic = [AppControlManager getSTHeadDictionary:dic strurl:strurl];
//                        for (NSString *key in [headDic allKeys]) {
//                            NSString *value = [headDic objectForKey:key];
//                            [manager.requestSerializer setValue:value forHTTPHeaderField:key];
//                        }
//                        BOOL isNet = [Common checkNetWorkStatus];
//                        if (!isNet) {
//                            [ShowMessage showMessage:@"亲,您的手机网络不太顺畅"];
//                        }
//                        
//                        [manager POST:strurl parameters:dic
//                              success:^(AFHTTPRequestOperation *operation,id responseObject) {
//                                  NSString *st = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                                  
//                                  OneAnotherController *aVC = [[OneAnotherController alloc]init];
//                                  aVC.myTitle = @"充值";
//                                  aVC.oneAnotherUrl = @"OBJC.executeJs(\"init\",{\n \"platform\":\"app\"\n})";
//                                  aVC.oneAnotherRequest =[NSString stringWithFormat:@"%@%@%@",strUTOUUWeb,@"recharge?ticket=",st];
//                                  if (shops) {
//                                      aVC.hasShop = @"has";
//                                      
//                                  }
//                                  //[self.webView2 stopLoading];
//                                  [self.navigationController pushViewController:aVC animated:NO];
//                                  
//                              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
//                                  NSLog(@"Error: %@", error);
//                              }];
                    }else{
                        if ([number isEqualToString:@""] || number == nil) {
                        number = @"";
                        }
                        NSDictionary *dic = [param_dic objectForKey:@"parameters"];
                        if (dic == nil) {
                            self.isUrl =@"";
                        }else{
                            NSData *jsonData = [NSJSONSerialization
                                            dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
                            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
                            NSString *strUrl = [NSString stringWithFormat:@"OBJC.executeJs(\"init\",%@)",jsonString];
    
                            self.isUrl = strUrl;
    
                        }
                        OneViewController *aVC = [[OneViewController alloc]init];
    
                        aVC.myTitle = [dic objectForKey:@"title"];
                        aVC.oneUrl = self.isUrl;
                        aVC.oneRequest = number;
                        if (shops) {
                            aVC.hasShop = @"has";
                        }
                        [self.webView2 stopLoading];
                        [self.navigationController pushViewController:aVC animated:YES];
                    }
                }else if ([[param_dic objectForKey:@"action"] isEqualToString:@"message"]){
                    NSString * number =  [param_dic objectForKey:@"target"];
                    if (self.isLogin) {
    
                    if ([number isEqualToString:@"collect/add"]) {
                        self.collect = @"collect";
                        NSDictionary *dic = [param_dic objectForKey:@"parameters"];
                        NSString *goods_id = [dic objectForKey:@"goodsId"];
                        NSString *randomKey = [param_dic objectForKey:@"randomKey"];
                        [BKService addGoodsToCollect:goods_id view:nil callback:^(id obj,NSError *error) {
                            Result *collect_result = obj;
                            NSDictionary *dic = (NSDictionary *)collect_result.data;
                            NSString *jsonString = [Common dictionaryToJson:dic];
                            NSString *strUrl = [NSString stringWithFormat:@"OBJC.executeJs(%@,%@)",randomKey,jsonString];
    
                            if (collect_result.data!=nil) {
                                [_webView2 evaluateJavaScript:strUrl completionHandler:nil];
                            }
                        }];
                    }else if ([number isEqualToString:@"collect/delete"]){
                         self.collect = @"collect";
                        NSDictionary *dic = [param_dic objectForKey:@"parameters"];
                        NSString *goods_id = [dic objectForKey:@"goodsId"];
                        NSString *randomKey = [param_dic objectForKey:@"randomKey"];
                        [BKService deleteCollectGoods:goods_id view:nil callback:^(id obj,NSError *error) {
                            Result *collect_result = obj;
                            NSDictionary *dic = (NSDictionary *)collect_result.data;
                            NSString *jsonString = [Common dictionaryToJson:dic];
                            NSString *strUrl = [NSString stringWithFormat:@"OBJC.executeJs(%@,%@)",randomKey,jsonString];
    
                            if (collect_result.data!=nil) {
                                 [_webView2 evaluateJavaScript:strUrl completionHandler:nil];
                            }
                        }];
                    }else if ([number isEqualToString:@"shopping-cart/add"]){
                        self.addShopCar = @"add";
                        NSMutableDictionary *dic = [param_dic objectForKey:@"parameters"];
                        [dic removeObjectForKey:@"goods_reserve_id"];
                        NSString *randomKey = [param_dic objectForKey:@"randomKey"];
                        NSString *strjson = [Common dictionaryToJson:dic];
                        [BKService addProduciontoShoppingCar:strjson view:self.view callback:^(id obj,NSError *error) {
    
                            Result *add_result = obj;
                            NSDictionary *dic = (NSDictionary *)add_result.data;
                            NSString *jsonString = [Common dictionaryToJson:dic];
                            NSString *strUrl = [NSString stringWithFormat:@"OBJC.executeJs(%@,%@)",randomKey,jsonString];
                            if (add_result.data!=nil) {
                                 [_webView2 evaluateJavaScript:strUrl completionHandler:nil];
                            }
                        }];
                    }
                }
                    else{
                        LoginController *loginVC = [[LoginController alloc]init];
                        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
                        [self presentViewController:nv animated:YES completion:nil];
                    }
    
                }else if ([[param_dic objectForKey:@"action"] isEqualToString:@"close"]){
                   [Userinfo setbacktag:@"1"];
                    if ([ispop isEqualToString:@"1"]) {
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -3] animated:YES];
                    }else if ([ispop isEqualToString:@"2"]){
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }else if ([ispop isEqualToString:@"3"]){
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -3] animated:YES];
                    }
                }
             }
            decisionHandler(WKNavigationActionPolicyAllow);
        });
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
//加载失败
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    [webView.scrollView headerEndRefreshing];
//}
//#pragma mark _分享
-(void)shareVideo:(UIImage *)image title:(NSString *)titles content:(NSString *)content{
    NSString *title = titles;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"53fbf399fd98c5a48f01c81f"
                                      shareText:title
                                     shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ, nil]
                                       delegate:nil];
}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess){
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
    
    [UMSocialData openLog:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     [[NSURLCache sharedURLCache] removeAllCachedResponses];
    self.webView = nil;
    self.webView.delegate = nil;
    
    if ([self.view window] == nil) {
        self.view = nil;
    }

}
#pragma mark -加载条
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"]&&object==_webView2) {
        [_progressView setAlpha:1.0f];
        [_progressView setProgress:_webView2.estimatedProgress animated:YES];
        if (_webView2.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [_progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [_progressView setProgress:0.0f animated:NO];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark 充值
-(void)AccountMoneyAnother{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"充值"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 300;
    UITextField *tf = [alert textFieldAtIndex:0];
    tf.placeholder = @"请输入充值金额";
    [alert show];
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSString * money = textField.text;
        if (![money isEqualToString:@""]) {
            NSLog(@"充值金额%@",money);
            if ([self checkRechargeMoney:[money integerValue]]) {
                [PassportService rechargeMoneyWithMoney:money callback:^(id obj,NSError *error) {
                    ALiPayResult * result = obj;
                    if (result.error) {
                        [ShowMessage showMessage:result.error.domain];
                    }else{
                        [ShowMessage showMessage:@"充值成功" withCenter:self.view.center];
                        [self.webView reload];
                        [self.webView2 reload];
                        //[self requestAccountBlance];
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
-(void)requestAccountBlance{
    //__weak typeof(self)wSelf = self;
    [CashDeskService getAvailableMoenyCompeletion:^(id obj, NSError *error) {
        NSArray * accountArr;
        if (error) {
            
        }else{
            accountArr = obj;
            
        }
        //[wSelf refreshAccountBalance:accountArr];
    }];
}
- (void)dealloc {
    [_webView2 removeObserver:self forKeyPath:@"estimatedProgress"];
    
    // if you have set either WKWebView delegate also set these to nil here
    [_webView2 setNavigationDelegate:nil];
    [_webView2 setUIDelegate:nil];
    messageView = nil;
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