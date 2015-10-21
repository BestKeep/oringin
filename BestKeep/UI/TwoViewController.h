//
//  TwoViewController.h
//  BestKeep
//
//  Created by 魏鹏 on 15/8/18.
//  Copyright (c) 2015年 utouu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface TwoViewController : BaseViewController<UIWebViewDelegate>{
     UIButton *letButton;
//    NJKWebViewProgressView *_progressView;
//    NJKWebViewProgress *_progressProxy;
//    float press;
//    BOOL isLoad;
//    
}
@property(nonatomic,strong) NSString *oneUrl;



@end
