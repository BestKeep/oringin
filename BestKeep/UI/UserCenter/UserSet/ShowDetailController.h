//
//  ShowDetailController.h
//  BESTKEEP
//
//  Created by cunny on 15/9/7.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface ShowDetailController : UIViewController<UIWebViewDelegate,NJKWebViewProgressDelegate>{
    UIWebView *webView;
    BOOL isSend ;
    BOOL isLoad;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
    UIButton *letButton;
    float press;

}

@end
