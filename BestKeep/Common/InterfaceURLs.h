//
//  InterfaceURLs.h
//  MobileUU
//
//  Created by 王義傑 on 15/5/6.
//  Copyright (c) 2015年 Shanghai Pecker Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterfaceURLs : NSObject


extern NSString * const strUtouuAPI;
extern NSString * const strBKAPI;
extern NSString * const strCAPI;
extern NSString * const strLoginURL;
extern NSString * const strLogoutURL;
extern NSString * const strVersion;

extern NSString * const strRegister;
extern NSString * const strRegisterResult;
extern NSString * const strPassport;
extern NSString * const strSMSPic;
extern NSString * const strAccountLoginURL;
extern NSString * const strst;//获取st

extern NSString * const struser_baseinfo;//用户基本信息

extern NSString * const struser_detailinfo;//用户详细信息
extern NSString * const strIndexhtml;

extern NSString * const struser_vip;

extern NSString * const strBKWeb;
extern NSString * const strUTOUUWeb;
extern NSString *const rechargeMoney;
extern NSString * const strGOODSHOME;


/*
 * 购物车商品数量接口
 */
extern NSString * const strShoping_car_amount;

/*
 *购物车列表
 */
extern NSString * const strShoping_car_list;

/*
 * 购物车商品修改接口
 * 请求参数
 *  data=[{
 *  id:xxx//购物车记录ID,
 *  amount:xxx//商品数量
 *  }….]
 */
extern NSString * const strShoping_car_edit;

/*
 *购物车商品删除接口
 *@param data = id,id,id多个逗号分隔
 id:商品ID
 */
extern NSString * const strShoping_car_delete;

/*
 添加购物车商品接口
 @param goods_id  //商品ID
 */
extern NSString * const strShoping_car_add;

/*
 添加收藏商品接口
 @param data = id,id,id多个逗号分隔
 */
extern NSString * const strShoping_collect_add;

/*
 收藏列表
 */
extern NSString * const strShoping_collect_list;

/*
 删除收藏商品
 @param data = collect_id,....
 */
extern NSString * const strShoping_collect_delete;

/*
 订单状态数量接口
 */
extern NSString * const strOrder_status_amont;

/*
 用户订单分页接口
 @param status //订单状态
        pagesize //显示条数
        pageno //当前第几页
 */
extern NSString * const strOrder_listpage;

/*
 取消订单接口
 @param order_no //订单号
 */
extern NSString * const strOrder_cancel;

/**
 获取用户默认收货地址接口
 **/
extern NSString * const strDefault_address;

/*
 根据商品生成订单确认信息接口
 @param data={
 deliver_id:xxx//收货地址ID
 goodsinfo:[{
 goods_id:xxx商品ID
 amount:xxx//购买数量
 goods_pro_rel1:xxx//商品销售属性1,
 goods_pro_rel2:xxx//商品销售属性2
 goods_pro_rel3:xxx//商品销售属性3,
 goods_pro_rel4:xxx//商品销售属性4,
 goods_pro_rel5:xxx//商品销售属性5,
 }…]
 }
 */
extern NSString * const strOrder_confirm;

/*
 提交订单接口
 @param data={
 deliver_id:xxx//收货地址ID
 goods_info:[{
 goods_id:xxx//商品ID
 amount:xxx//购买数量
 goods_pro_rel1:xxx//商品销售属性1,
 goods_pro_rel2:xxx//商品销售属性2
 goods_pro_rel3:xxx//商品销售属性3,
 goods_pro_rel4:xxx//商品销售属性4,
 goods_pro_rel5:xxx//商品销售属性5,
 }…]
 }
 */
extern NSString * const strOrder_submit;

/*
 订单总金额计算
 @param order_no // 订单号多个以逗号分割
 */
extern NSString * const strOrder_total;


/*
 收银台账户信息
 */
extern NSString * const strAccount_info;

/*
确认订单付款
 @param order_no //订单号多个以逗号隔开
 account_type //账户类型
 */
extern NSString * const strOrder_pay;

/*
 收货地址列表
 */
extern NSString * const strDeliver_address_list;

/*
 设置默认收货地址
 @param deliver_id  //默认地址id
 */
extern NSString * const strDeliver_default_address;

/*
 删除收获地址
 @param deliver_id //地址ID
 */
extern NSString * const strDeliver_delete;

/*
 编辑收获地址
 data={
 id:xxx//收货地址ID
 deliver_name:xxx//收货人姓名
 province_name:xxx//省份名称
 city_name:xxx//城市名称
 county_name:xxx//区县名称
 address:xxx//详细地址
 post_code:xxx//邮编
 is_default:xxx//是否默认地址
 telephone:xxx//手机电话
 fixed_telephone:xxx//固定电话
 province_code:xxx//省份代码
 city_code:xxx//城市代码
 county_code:xxx//区县代码
 }
 */
extern NSString * const strDeliver_edit;

/*
 添加收获地址
 data={
 deliver_name:xxx//收货人姓名
 province_name:xxx//省份名称
 city_name:xxx//城市名称
 county_name:xxx//区县名称
 address:xxx//详细地址
 post_code:xxx//邮编
 is_default:xxx//是否默认地址
 telephone:xxx//手机电话
 fixed_telephone:xxx//固定电话
 province_code:xxx//省份代码
 city_code:xxx//城市代码
 county_code:xxx//区县代码
 }
 */
extern NSString * const strDeliver_add;

/*
 查询省份接口
 */
extern NSString * const strArea_province;

/*
 查询城市接口
 */
extern NSString * const strArea_city;

/*
 查询区县接口
 */
extern NSString * const strArea_county;


/*
版本检测
 */
extern NSString * const strCheck_version;

extern NSString *const strMenber_bind ;

/*
 确认订单
 */
extern NSString * const strConfirm_receive;

extern NSString * const strSave_detail;

/*
 商品详情
 */
extern NSString * const strGoods_detail;

/*
 首页列表
 */
extern NSString * const strGoods_list;
extern NSString * const goodsReserveStatus;
extern NSString * const strShoping_collect_isSave;



@end
