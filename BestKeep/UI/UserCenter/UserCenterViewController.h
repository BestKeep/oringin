//
//  UserCenterViewController.h
//  BESTKEEP
//
//  Created by dcj on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, UserCenterTableViewSection) {
    UserCenterTableViewSectionOrder = 0,//order状态
    UserCenterTableViewSectionAccountBlance,//账户余额
    UserCenterTableViewSectionManagerReutrn,//退货管理
    UserCenterTableViewSectionSet,//设置
};


@interface UserCenterViewController : BaseViewController
@property (nonatomic,strong) UIButton *linkBtn;

@end
