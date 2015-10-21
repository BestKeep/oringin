//
//  DeliverAddressServer.h
//  BESTKEEP
//
//  Created by YISHANG on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeliverAddressServer : NSObject
typedef void (^MyCallback)(id obj,NSError* error);

//收货地址列表
+(void)getDeliverAddress:(MyCallback)callback;
//收货地址设置默认
+(void)getDeliverAddress:(NSDictionary *) parameters
                        :(MyCallback)callback;
//删除收货地址
+(void)getDleiverDelete:(NSDictionary *)parametser
                       :(MyCallback)callback;
//编辑收货地址
+(void)getdeliveredit:(NSDictionary *) parameters
                     :(MyCallback)callback;
/*
 添加收货地址
 */
+(void)addAddress:(NSString *)dic view:(UIView *)view callback:(MyCallback)callback;

/**
 获取用户默认收货地址
 **/
+(void)getDefaultAddress:(UIView*)view callback:(MyCallback)callback;
@end
