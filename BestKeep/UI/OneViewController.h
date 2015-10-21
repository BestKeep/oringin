//
//  OneViewController.h
//  BestKeep
//
//  Created by 魏鹏 on 15/8/18.
//  Copyright (c) 2015年 utouu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "OneAnotherController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface OneViewController : BaseViewController<UIWebViewDelegate>{
    UIWebView *_webView;

}

@property (nonatomic,strong)NSString *oneUrl;
@property (nonatomic,strong)NSString *oneRequest;
@property (nonatomic,strong)NSString *myTitle;
@property (nonatomic,strong)NSString *hasShop;
@property (nonatomic,strong)NSString *url_strings;


@property(nonatomic,strong) NSString *share;
@property(nonatomic,strong) NSString *collect;
@property(nonatomic,strong) NSString *addShopCar;
@property(nonatomic,strong) NSString *buy;
@property(nonatomic,strong) NSString *recharge;
@property (nonatomic,copy,nullable) void(^BackAction)();
@end
