//
//  AppDelegate.h
//  BestKeep
//
//  Created by 魏鹏 on 15/8/18.
//  Copyright (c) 2015年 utouu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKNavigationController.h"
#import "UserInfoModel.h"
#import "LoginController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    BKNavigationController *nav;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) UserInfoModel * userInfo;
@property (nonatomic,strong) LoginController *logVC;
-(BOOL)isLogin;

@end

