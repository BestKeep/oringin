
//
//  BKService.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//
#import <Foundation/Foundation.h>
@class OrderInfo;

@interface BKService : NSObject
typedef void (^MyCallback)(id obj,NSError *error);
typedef void (^CompeletionCallBack)(id obj,NSError *error);
/*
 购物车商品数量
 */
+(void)GetShoppingCartAmontOfgoods:(MyCallback)callback view:(UIView *)view;

/*
 购物车列表
 */
+(void)GetShoppingCartList:(MyCallback)callback view:(UIView *)view;

/*
 购物车商品修改接口
 */
+(void)editShoppingCartGoods:(UIView*)view data:(NSDictionary*)data callback:(MyCallback)callback;

/*
 购物车商品删除接口
 */
+(void)deleteShoppingCartGoods:(MyCallback)callback ids:(NSString*)ids view:(UIView*)view;

/*
 收藏列表
 */
+(void)GetGoodsCollectionlist:(NSString*)pagesize pageno:(NSString*)pageno view:(UIView *)view callback:(CompeletionCallBack)callback;

/*
 添加收藏商品
 */
+(void)addGoodsToCollect:(NSString*)ids view:(UIView*)view callback:(MyCallback)callback;

/*
 删除收藏商品
 */
+(void)deleteCollectGoods:(NSString*)ids view:(UIView*)view callback:(MyCallback)callback;

/*
 订单状态数量
 */
+(void)GetOrderStatusAmount:(UIView*)view callback:(MyCallback)callback;

/*
 添加到购物车
 */
+(void)addProduciontoShoppingCar:(NSString*)strjson view:(UIView*)view callback:(MyCallback)callback;

/*
 获取用户订单分页数据
 @param status 待付款：01   待发货：02 待收货：03
 */
+(void)GetUserOrderdata:(NSString *)status pagesize:(NSString *)pagesize pageno:(NSString*)pageno view:(UIView*)view callback:(MyCallback)callback;
/*
 取消订单
 @param order_no 订单号
 */
+(void)cancelOrder:(NSString *)order_no reason:(NSString*)reason view:(UIView*)view callback:(MyCallback)callback;


/*
 查询地区/省份
 */
+(void)GetArea:(UIView *)view callback:(MyCallback)callback;

/*
 查询地区/城市
 */
//+(void)GetCity:(NSString *)province_code view:(UIView *)view callback:(MyCallback)callback;

/*
 查询地区/区县
 */
//+(void)GetSquare:(NSString *)city_code view:(UIView *)view callback:(MyCallback)callback;

/*
 添加收货地址
 */
//+(void)addAddress:(NSString *)dic view:(UIView *)view callback:(MyCallback)callback;

/*生成订单确认信息*/

+(void)OrderInfoConfirm:(NSString*)data view:(UIView*)view callback:(MyCallback)callback;

/*提交订单*/
+(void)submitOrder:(NSString*)data view:(UIView*)view callback:(MyCallback)callback;

/***
 订单总金额计算
 ***/
+(void)OrderCash:(NSString*)data view:(UIView*)view callback:(MyCallback)callback;

/***
 
 确认付款
 ***/
+(void)orderpay: (OrderInfo*)order account_type:(NSString *)account view:(UIView*)view callback:(MyCallback)callback;

/***
 确认收货
 ***/
+(void)confirmReceive:(NSString*)order_no view:(UIView*)view callback:(MyCallback)callback;

/***
 商品详情
 ***/
+(void)GoodsDetail:(NSString*)goodsID view:(UIView*)view CompeletionCallBack:(CompeletionCallBack)callback;

/***
 首页列表
 ***/
+(void)GoodsHomeView:(UIView*)view CompeletionCallBack:(CompeletionCallBack)callback;
+(void)isSaveGoodsToCollect:(NSString*)ids view:(UIView*)view callback:(MyCallback)callback;
@end
