//
//  ViewController.h
//  MobileUU
//
//  Created by 王義傑 on 14-5-29.
//  Copyright (c) 2014年 Shanghai Pecker Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@interface LoginController : UIViewController
@property (nonatomic,assign) BOOL isFromPresent;


@property (nonatomic,copy)void (^LoginSucessCallBack)(UserInfoModel * userModel);


@end
