//
//  CashDeskService.h
//  BESTKEEP
//
//  Created by dcj on 15/8/28.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestCompeliton)(id obj,NSError * error);


@interface CashDeskService : NSObject

/**
 *  获取用户账户信息
 *
 *  @param compeletion 返回账户数组
 */
+(void)getAvailableMoenyCompeletion:(RequestCompeliton)compeletion;

/**
 *  确认订单｀
 *
 *  @param headParams  头部参数字典
 *  @param bodyParams  参数字典
 *  @param compeletion 返回 true 或者 error
 */
+(void)confirmPayForOrderHeadParams:(NSDictionary *)headParams andBodyParams:(NSDictionary *)bodyParams RequestCompeliton:(RequestCompeliton)compeletion;

/**
 *  计算订单金额
 *
 *  @param orders      订单数组
 *  @param compeletion 返回订单总金额字典
 */
+(void)calculateOrdersMoneyWithOrders:(NSArray *)orders requestCompeletion:(RequestCompeliton)compeletion;

+(void)getMenberBind:(RequestCompeliton)compeletion;
@end
