//
//  PassportService.h
//  MobileUU
//====================================
//1.0 新增获取验证码方法   万黎君
//1.1 新增用户注册        万黎君
//====================================
//  Created by 王义杰 on 15/5/14.
//  Copyright (c) 2015年 Shanghai Pecker Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//#import "PassportAnalyze.h"
//#import "DatabaseCache.h"
@class UserInfoModel;

typedef void (^Compeletion)(id obj,NSError * error);

@interface PassportService : NSObject

typedef void (^MyCallback)(id obj,NSError* error);

//从服务获取ST
+ (void) getSTbyTGT:(NSString*)tgt url:(NSString*)url success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;//获取st

//登录
+(void)login:(UIView *)view
            :(NSDictionary *) parameters
            :(Compeletion)callback;

+(void)logout;


+(void)applyforVerifyCode:(MyCallback)callback;//获取验证码


+(void)registerUserAccount:(UIViewController *)viewController
                          :(NSDictionary *) parameters
                          :(MyCallback)callback;//用户注册



typedef void (^GetUjserInfoCallBack)(UserInfoModel * userInfo,NSError * error);

+(void)getUserInfoWithHeadParams:(NSDictionary *)headDic bodyParams:(NSDictionary *)bodyParams callBack:(GetUjserInfoCallBack)callBack;

+(void)checkOutVersionnext:(NSDictionary*)parameters
                          :(MyCallback)callback;//版本检测

+(void)rechargeMoneyWithMoney:(NSString *)money callback:(MyCallback)callback;


@end
