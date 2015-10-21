//
//  InterfaceURLs.m
//  MobileUU
//==================================
//1.0更新新接口 万黎君
//1.1增加问题列表接口   万黎君
//==================================
//  Created by 王義傑 on 15/5/6.
//  Copyright (c) 2015年 Shanghai Pecker Network Technology. All rights reserved.
//  提交测试

#import "InterfaceURLs.h"

@implementation InterfaceURLs

#pragma mark ------服务器地址(单一数据）------ 开发

//NSString * const strUtouuAPI = @"http://api.dev.utouu.com/v1/";
//NSString * const strBKAPI = @"http://api.dev.bestkeep.cn/";
//NSString * const strCAPI = @"http://api.cac.dev.utouu.com/";
//NSString * const strPassport = @"https://passport.dev.utouu.com/";
//NSString * const strRegister = @"http://msg.dev.utouu.com/";//获取验证码
//NSString * const strVersion = @"http://api.dev.bestkeep.cn/v1/";
//NSString * const strBKWeb = @"http://m.dev.bestkeep.cn/";
//NSString * const strUTOUUWeb = @"http://cac.dev.utouu.com/";
//NSString * const strIndexhtml = @"http://m.dev.bestkeep.cn/app/index.html";
//NSString * const strSave_detail = @"http://m.dev.bestkeep.cn/app/productDetail.html";
//NSString *const rechargeMoney = @"http://api.dev.bestkeep.cn/recharge/alipay";


#pragma mark ------服务器地址(单一数据）------ 测试
//NSString * const strUtouuAPI = @"http://api.test.utouu.com/v1/";
//NSString * const strBKAPI = @"http://api.test.bestkeep.cn/";
//NSString * const strCAPI = @"http://api.cac.test.utouu.com/";
//NSString * const strPassport = @"https://passport.test.utouu.com/";
//NSString * const strRegister = @"http://msg.test.utouu.com/";//获取验证码
//NSString * const strVersion = @"http://api.test.bestkeep.cn/v1/";
//NSString * const strIndexhtml = @"http://m.test.bestkeep.cn/app/index.html";
//NSString * const strBKWeb = @"http://m.test.bestkeep.cn/";
//NSString * const strUTOUUWeb = @"http://cac.test.utouu.com/";
//NSString * const strSave_detail = @"http://m.test.bestkeep.cn/app/productDetail.html";
//NSString *const rechargeMoney = @"http://api.test.bestkeep.cn/recharge/alipay";

#pragma mark ===  生产
NSString * const strUtouuAPI = @"http://api.utouu.com/v1/";
NSString * const strBKAPI = @"http://api.bestkeep.cn/";
NSString * const strCAPI = @"http://api.cac.utouu.com/";
NSString * const strPassport = @"https://passport.utouu.com/";
NSString * const strRegister = @"http://msg.utouu.com/";//获取验证码
NSString * const strVersion = @"http://api.bestkeep.cn/v1/";
NSString * const strIndexhtml = @"http://m.bestkeep.cn/app/index.html";
NSString * const strBKWeb = @"http://m.bestkeep.cn/";
NSString * const strUTOUUWeb = @"http://cac.utouu.com/";
NSString * const strSave_detail = @"http://m.bestkeep.cn/app/productDetail.html";
NSString *const rechargeMoney = @"http://api.bestkeep.cn/recharge/alipay";



NSString * const strGOODSHOME = @"http://file.bestkeep.cn/ui/mobile/app/data/";
NSString * const strRegisterResult = @"api/v1/account/register";//注接口
NSString * const strAccountLoginURL = @"m1/tickets";//登录接口

NSString * const strst = @"m1/tickets";//获取ST
NSString * const strSMSPic = @"v1/img/vcode";//获取验证码
NSString * const strCheckPic = @"v1/img/vcode/validate";//验证验证码

NSString * const struser_baseinfo = @"user/info";//用户基本信息

NSString * const struser_detailinfo = @"user/detail";//用户详细信息

NSString * const struser_vip = @"profile/vip";//会员卡信息
/*
 
 */


/*
 * 购物车商品数量接口
 */
NSString * const strShoping_car_amount = @"shopping-cart/amount";

/*
 *购物车列表
 */
NSString * const strShoping_car_list = @"shopping-cart/list";

/*
 *购物车商品修改接口
 */
NSString * const strShoping_car_edit = @"shopping-cart/edit";


/*
 *购物车商品删除接口
 */
NSString * const strShoping_car_delete = @"shopping-cart/delete";

/*
 添加购物车商品接口
 */
NSString * const strShoping_car_add = @"shopping-cart/add";

/*
 添加收藏商品接口
 */
NSString * const strShoping_collect_add = @"collect/add";

/*
 收藏列表
 */
NSString * const strShoping_collect_list = @"collect/list";

/*
 删除收藏商品
 */
NSString * const strShoping_collect_delete = @"collect/delete";

/*
 订单状态数量接口
 */
NSString * const strOrder_status_amont = @"order/status-amount";

/*
 用户订单分页接口
 */
NSString * const strOrder_listpage = @"order/listpage";

/*
 取消订单接口
 */
NSString * const strOrder_cancel = @"order/cancel";

/**
 获取用户默认收货地址接口
 **/
NSString * const strDefault_address = @"deliver-address/default";

/*
 根据商品生成订单确认信息接口
 */
NSString * const strOrder_confirm = @"order/confirm";

/*
 提交订单接口
 */
NSString * const strOrder_submit = @"order/submit";

/*
 订单总金额计算
 */
NSString * const strOrder_total = @"order/total";

/*
 收银台账户信息
 */
NSString * const strAccount_info = @"account/info";

/*
 确认订单付款
 */
NSString * const strOrder_pay = @"order/pay";

/*
 收货地址列表
 */
NSString * const strDeliver_address_list = @"deliver-address/list";

/*
 设置默认收货地址
 */
NSString * const strDeliver_default_address = @"deliver-address/setdefault";

/*
 删除收获地址
 */
NSString * const strDeliver_delete = @"deliver-address/delete";

/*
 编辑收获地址
 */
NSString * const strDeliver_edit = @"deliver-address/edit";

/*
 添加收获地址
 */
NSString * const strDeliver_add = @"deliver-address/add";

/*
 查询省份接口
 */
NSString * const strArea_province = @"area/province";

/*
 查询城市接口
 */
NSString * const strArea_city = @"area/city";

/*
 查询区县接口
 */
NSString * const strArea_county = @"area/county";

NSString *const strCheck_version = @"version/ios-p";

NSString *const strMenber_bind = @"member/bind";

NSString *const strConfirm_receive = @"order/confirmOrder";

/*
 商品详情
 */
NSString *const strGoods_detail = @"goods/";

NSString * const strGoods_list = @"index_data";

NSString * const goodsReserveStatus = @"reserve/goodsReserve-status";
/*
 判断收藏商品接口
 */
NSString * const strShoping_collect_isSave = @"collect/getStatus";
@end

