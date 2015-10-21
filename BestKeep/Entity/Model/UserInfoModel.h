//
//  UserInfoModel.h
//  BESTKEEP
//
//  Created by dcj on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface UserInfoModel : BaseObject

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * photo;
@property (nonatomic,copy) NSString * stock_account_state_name;
@property (nonatomic,copy) NSString * real_auth;
@property (nonatomic,copy) NSString * visitor_code;
@property (nonatomic,copy) NSString * money;
@property (nonatomic,assign) NSInteger userid;
@property (nonatomic,copy) NSString * mob_bind;
@property (nonatomic,copy) NSString * pay_bind;
@property (nonatomic,copy) NSString * roles;
@property (nonatomic,copy) NSString * account;

@end
