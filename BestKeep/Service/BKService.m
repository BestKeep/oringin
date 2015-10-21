
//
//  BKService.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//
#import "BKService.h"
#import "RequestFromServer.h"
#import "ShowMessage.h"
#import "ShoppingCarList.h"
#import "ShoppingCarCommon.h"
#import "CollectionList.h"
#import "OrderModel.h"
#import "Area.h"
#import "Result.h"
#import "GoodsModel.h"
#import "OrderInfo.h"
#import "Userinfo.h"
#import "HOME.h"
#import "Title.h"
#import "List.h"
#import "GoodsService.h"

#import "ConfirmOrderModel.h"
@implementation BKService
#pragma mark - 购物车商品数量
+(void)GetShoppingCartAmontOfgoods:(MyCallback)callback view:(UIView *)view;{
    
    
    NSString *strURL = [strBKAPI stringByAppendingString:strShoping_car_amount];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:nil strurl:strURL];
    
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:nil showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;;
        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        if (success) {
            NSDictionary *data_dic = [result_dic objectForKey:@"data"];
            NSString *amount = [data_dic objectForKey:@"amount"];
            callback(amount,nil);
        }
        else{
            NSString *msg = [result_dic objectForKey:@"msg"];
            [ShowMessage showMessage:msg];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
}

#pragma mark - 购物车列表
+(void)GetShoppingCartList:(MyCallback)callback view:(UIView *)view;{
    
     NSString *strURL = [strBKAPI stringByAppendingString:strShoping_car_list];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:nil strurl:strURL];
   
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:nil showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;
        
        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        if (success) {
            
            NSDictionary *data_dic = [result_dic objectForKey:@"data"];
            NSArray *list_array = [data_dic objectForKey:@"list"];
            
            NSMutableArray *allTemp_array = [NSMutableArray new];  //展示的所有信息集合
            for (NSDictionary *dic1 in list_array) {
                
                superShopping *superSH = [[superShopping alloc] init];
                superSH.shopList = [[NSMutableArray alloc] init];
                superSH.address = [dic1 objectForKey:@"deliver"];//发货地址
                superSH.global_status1 = [[dic1 objectForKey:@"global_status"] boolValue];//是否为全球购
                
                NSArray *itemArray = [dic1 objectForKey:@"item_list"];
                for (NSDictionary *dic2 in itemArray) {
                    ShoppingCarList* shoppingCarList = [[ShoppingCarList alloc] init];
                    shoppingCarList.record_id = [dic2 objectForKey:@"id"];//购物车记录id
                    shoppingCarList.good_id = [dic2 objectForKey:@"goods_id"] ;//商品id
                    shoppingCarList.goods_img = [dic2 objectForKey:@"goods_img"];//商品图片
                    shoppingCarList.goods_name = [dic2 objectForKey:@"goods_name"];//商品名称
                    shoppingCarList.member_price = [[dic2 objectForKey:@"member_price"] stringValue];//会员价
                    shoppingCarList.tax_amount = [[dic2 objectForKey:@"tax_amount"] stringValue];//糖赋
                    shoppingCarList.amount = [[dic2 objectForKey:@"amount"] stringValue];//商品数量
                    shoppingCarList.goods_reserve_id = [dic2 objectForKey:@"goods_reserve_id"];
                    shoppingCarList.sale_property =  checkNull([dic2 objectForKey:@"sale_property"]) ;//销售描述,例：颜色：黑色，尺码：S
//                    shoppingCarList.goods_pro_rel1 = checkNull([dic2 objectForKey:@"goods_pro_rel1"]) ;//商品销售属性1
//                    shoppingCarList.goods_pro_rel2 = checkNull([dic2 objectForKey:@"goods_pro_rel2"]);//商品销售属性2
//                    shoppingCarList.goods_pro_rel3 = checkNull([dic2 objectForKey:@"goods_pro_rel3"]);//商品销售属性3
//                    shoppingCarList.goods_pro_rel4 = checkNull([dic2 objectForKey:@"goods_pro_rel4"]);//商品销售属性4
//                    shoppingCarList.goods_pro_rel5 = checkNull([dic2 objectForKey:@"goods_pro_rel5"]);//商品销售属性5
                    shoppingCarList.buyEarth = [[dic2 objectForKey:@"global_status"] boolValue];//是否为全球购
                    [superSH.shopList addObject:shoppingCarList];//存储所有商品信息
                }
                [allTemp_array addObject:superSH];
            }
            callback(allTemp_array,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark - 编辑购物车商品
+(void)editShoppingCartGoods:(UIView*)view data:(NSDictionary*)data callback:(MyCallback)callback;{
    
     NSString *strURL = [strBKAPI stringByAppendingString:strShoping_car_edit];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:data strurl:strURL];
   
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:data showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        
        ShoppingCarCommon *shcar = [[ShoppingCarCommon alloc] init];
        shcar.success = success;
        shcar.msg = msg;
        shcar.code = code;
        callback(shcar,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}
#pragma mark - 删除购物车商品
+(void)deleteShoppingCartGoods:(MyCallback)callback ids:(NSString*)ids view:(UIView*)view;{
    
    NSString *strURL = [strBKAPI stringByAppendingString:strShoping_car_delete];
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:ids,@"data", nil];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
    
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result_dic = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        
        ShoppingCarCommon *shcar = [[ShoppingCarCommon alloc] init];
        shcar.success = success;
        shcar.msg = msg;
        shcar.code = code;
        callback(shcar,nil);
//        [ShowMessage showMessage:shcar.msg];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
}
#pragma mark - 收藏列表
+(void)GetGoodsCollectionlist:(NSString*)pagesize pageno:(NSString*)pageno view:(UIView *)view callback:(CompeletionCallBack)callback{
    
    NSString *strURL = [strBKAPI stringByAppendingString:strShoping_collect_list];
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:pageno,@"pageno",pagesize,@"pagesize", nil];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
   
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * result_dic = responseObject;
        NSArray * tempList = [[result_dic objectForKey:@"data"] objectForKey:@"list"];
        NSMutableArray * goosListArray = [NSMutableArray array];
        NSMutableArray * goodsNoArr = [[NSMutableArray alloc] init];

        for (NSDictionary * dcit in tempList) {
            CollectionGoodsModel * tempModel = [[CollectionGoodsModel alloc] initWithDictionary:dcit];
            [goosListArray addObject:tempModel];
            [goodsNoArr addObject:tempModel.goods_no];
        }
        
        
        NSString * goods_nos = [goodsNoArr componentsJoinedByString:@","];
        
        __block NSArray * tempGoodsArr = goosListArray;
        
        [GoodsService getGoodsReserveStatusWithGoodsNo:goods_nos compeletion:^(id result, NSError *error) {
            if (error) {
                callback?callback(nil,error):nil;
            }else{
                [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    for (CollectionGoodsModel * tempModel in tempGoodsArr) {
                        NSMutableString * goodsNo = [obj objectForKey:@"goodsNo"];
                        if ([tempModel.goods_no isEqualToString:goodsNo]) {
                            [tempModel objectForKeyValue:obj];
                        }
                    }
                }];
                callback?callback(tempGoodsArr,nil):nil;
            }
        }];

//        callback?callback(goosListArray,nil):nil;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback?callback(nil,error):nil;
    }];
}/**
 添加收藏
 **/
#pragma mark - 添加收藏
+(void)addGoodsToCollect:(NSString*)ids view:(UIView*)view callback:(MyCallback)callback;{
    
    NSString *strURL = [strBKAPI stringByAppendingString:strShoping_collect_add];
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:ids,@"data",nil];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
    
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        
        ShoppingCarCommon *shcar = [[ShoppingCarCommon alloc] init];
        shcar.success = success;
        shcar.msg = msg;
        shcar.code = code;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject allKeys] containsObject:@"success"]) {
                shcar.data = responseObject;
            }
        }
        callback(shcar,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
}

#pragma mark - 删除收藏接口/////////////接口确认
+(void)deleteCollectGoods:(NSString*)ids view:(UIView*)view callback:(MyCallback)callback;{
    
    NSString *strURL = [strBKAPI stringByAppendingString:strShoping_collect_delete];
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:ids,@"data",nil];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
    
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        
        ShoppingCarCommon *shcar = [[ShoppingCarCommon alloc] init];
        shcar.success = success;
        shcar.msg = msg;
        shcar.code = code;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject allKeys] containsObject:@"success"]) {
                shcar.data = responseObject;
            }
        }
        callback(shcar,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
}

#pragma mark - 获取订单状态数量
+(void)GetOrderStatusAmount:(UIView*)view callback:(MyCallback)callback{
    
   
    NSString *strURL = [strBKAPI stringByAppendingString:strOrder_status_amont];
     NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:nil strurl:strURL];
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:nil showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        NSDictionary *data_dic = [result_dic objectForKey:@"data"];
        
        ShoppingCarCommon *shcar = [[ShoppingCarCommon alloc] init];
        shcar.success = success;
        shcar.msg = msg;
        shcar.code = code;
        shcar.data = data_dic;
        callback(shcar,nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(nil,error);
    }];
}
#pragma mark - 获取用户订单数据
+(void)GetUserOrderdata:(NSString *)status pagesize:(NSString *)pagesize pageno:(NSString*)pageno view:(UIView*)view callback:(MyCallback)callback;{
    
    NSString *strURL = [strBKAPI stringByAppendingString:strOrder_listpage];
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:status,@"status",pageno,@"pageno",pagesize,@"pagesize", nil];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];

    
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray * tempOderList = [[NSMutableArray alloc] init];
        NSMutableArray * tempOrderArr = [[responseObject objectForKey:@"data"] objectForKey:@"rows"];
        [tempOrderArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            OrderInfo * orderModel = [[OrderInfo alloc] initWithDictionary:obj];
            [tempOderList addObject:orderModel];
        }];
        
        callback?callback(tempOderList,nil):nil;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
}
#pragma mark - 取消订单
+(void)cancelOrder:(NSString *)order_no reason:(NSString *)reason view:(UIView*)view callback:(MyCallback)callback;{
    
     NSString *strURL = [strBKAPI stringByAppendingString:strOrder_cancel];
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:order_no,@"order_id",reason,@"cancel_reason", nil];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
   
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        
        ShoppingCarCommon *shcar = [[ShoppingCarCommon alloc] init];
        shcar.success = success;
        shcar.msg = msg;
        shcar.code = code;
        callback(shcar,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
}
#pragma mark -确认订单
+(void)OrderInfoConfirm:(NSString*)data view:(UIView*)view callback:(MyCallback)callback;{
    
    NSString *strURL = [strBKAPI stringByAppendingString:strOrder_confirm];
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:data,@"data", nil];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
    
    
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;
        ConfirmOrderModel * confirmOrder = [[ConfirmOrderModel alloc] initWithDictionary:[result_dic objectForKey:@"data"]];
        
        callback(confirmOrder,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(nil,error);
    }];
    
}

//+(void)OrderInfoConfirm:(NSString*)data view:(UIView*)view callback:(MyCallback)callback;{
//    
//    NSString *strURL = [strBKAPI stringByAppendingString:strOrder_confirm];
//    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:data,@"data", nil];
//    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
//    
//    
//    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSDictionary *result_dic = responseObject;
//        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
//        NSString *msg = [result_dic objectForKey:@"msg"];
//        NSString *code = [result_dic objectForKey:@"code"];
//        
//        //临时存放数据
//        NSMutableArray *temp_array1 = [NSMutableArray new];
//        NSMutableArray *temp_array2;
//        NSMutableArray *temp_array3 = [NSMutableArray new];
//        OrderModel *OM = [[OrderModel alloc] init];
//        OM.success = success;
//        OM.msg = msg;
//        OM.code = code;
//        if (success) {
//            NSDictionary *data_dic = [result_dic objectForKey:@"data"];
//            NSArray *rows_array = [data_dic objectForKey:@"list"];
//            
//            for (NSDictionary *temp_dic1 in rows_array) {
//                OrderModel1 *OM1 = [[OrderModel1 alloc] init];
//                OM1.total_order_amount = [data_dic objectForKey:@"goods_amount"];//商品总件数
//                OM1.order_amount = [data_dic objectForKey:@"order_amount"];//订单总金额
//                OM1.express_amount = [data_dic objectForKey:@"express_amount"];//订单总运费
//                
//                OM1.deliver = [temp_dic1 objectForKey:@"deliver"];//发货地
//                OM1.deliver_code = [temp_dic1 objectForKey:@"deliver_code"];//发货地code
//                OM1.express_companyid = [temp_dic1 objectForKey:@"express_companyid"];//快递公司ID
//                OM1.global_status = [temp_dic1 objectForKey:@"global_status"];//是否为全球购
//                OM1.shopping_guide_amount = [temp_dic1 objectForKey:@"shoppingGuideAmount"];//导购金
//                
//                
//                OM1.express_amount = [temp_dic1 objectForKey:@"express_amont"];
//                [temp_array1 addObject:OM1];
//                NSArray *item_listArray = [temp_dic1 objectForKey:@"item_list"];
//                temp_array2 = [NSMutableArray new];
//                for (NSDictionary *temp_dic2 in item_listArray) {
//                    OrderModel2 *OM2 = [[OrderModel2 alloc] init];
//                    OM2.goods_id = [temp_dic2 objectForKey:@"goods_id"];
//                    OM2.goods_img = [temp_dic2 objectForKey:@"goods_img"];
//                    OM2.goods_name = [temp_dic2 objectForKey:@"goods_name"];
//                    OM2.sale_property = [temp_dic2 objectForKey:@"sale_property"];
//                    OM2.goods_pro_rel1 = checkNull([temp_dic2 objectForKey:@"goods_pro_rel1"]);
//                    OM2.goods_pro_rel2 = checkNull([temp_dic2 objectForKey:@"goods_pro_rel2"]);
//                    OM2.goods_pro_rel3 = checkNull([temp_dic2 objectForKey:@"goods_pro_rel3"]);
//                    OM2.goods_pro_rel4 = checkNull([temp_dic2 objectForKey:@"goods_pro_rel4"]);
//                    OM2.goods_pro_rel5 = checkNull([temp_dic2 objectForKey:@"goods_pro_rel5"]);
//                    OM2.member_price = [temp_dic2 objectForKey:@"member_price"];
//                    OM2.tax_amount = [temp_dic2 objectForKey:@"tax_amount"];
//                    OM2.customs_tax_amount = [temp_dic2 objectForKey:@"customs_tax_amount"];
//                    OM2.discount_amount = [temp_dic2 objectForKey:@"discount_amount"];
//                    OM2.total_amount = [temp_dic2 objectForKey:@"total_amount"];
//                    OM2.amount = [temp_dic2 objectForKey:@"amount"];
//                    OM2.goods_reserve_id = [temp_dic2 objectForKey:@"goods_reserve_id"];
//                    OM2.reserveFlag = [temp_dic2 objectForKey:@"reserveFlag"];
//                    OM2.reserveType = [temp_dic2 objectForKey:@"reserveType"];
//                    [temp_array2 addObject:OM2];
//                }
//                [OM1 setCustoms_tax_amount_totalWithGoodsArray:temp_array2];
//                [temp_array3 addObject:temp_array2];
//            }
//        }
//        else{
//           // [ShowMessage showMessage:OM.msg];
//        }
//        OM.row_array = temp_array1;
//        OM.item_array = temp_array3;
//        callback(OM,nil);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        callback(operation,error);
//    }];
//
//}

#pragma -mark 提交订单获取订单列表号
+(void)submitOrder:(NSString*)data view:(UIView*)view callback:(MyCallback)callback;{
    
     NSString *strURL = [strBKAPI stringByAppendingString:strOrder_submit ];
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:data,@"data", nil];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
   
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        NSDictionary *data = [result_dic objectForKey:@"data"];
        
        ShoppingCarCommon *shcar = [[ShoppingCarCommon alloc] init];
        shcar.success = success;
        shcar.msg = msg;
        shcar.code = code;
        shcar.data = data;
        callback(shcar,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
}
+(void)OrderCash:(NSString*)data view:(UIView*)view callback:(MyCallback)callback;{
    
    NSString *strURL = [strBKAPI stringByAppendingString:strOrder_total ];
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:data,@"order_no", nil];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
    
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        NSDictionary *data = [result_dic objectForKey:@"data"];
        
        ShoppingCarCommon *shcar = [[ShoppingCarCommon alloc] init];
        shcar.success = success;
        shcar.msg = msg;
        shcar.code = code;
        shcar.data = data;
        callback(shcar,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
}

#pragma mark - 确认付款
//+(void)orderpay:(OrderInfo *)order account_type:(NSString *)account view:(UIView *)view callback:(MyCallback)callback{
//    NSString *order_string = order.order_no;
//    NSString *url = [strPassport stringByAppendingString:strst];
//    NSString *strurl = [NSString stringWithFormat:@"%@/%@",url,[Userinfo getUserTGT]];
//    NSString *values = [strUTOUUWeb stringByAppendingString:@"pay/order?platform=app&order_no="];
//    NSString *value = [values stringByAppendingString:order_string];
//    NSString *url_string = [@"pay/order?platform=app&order_no=" stringByAppendingString:order_string];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:value,@"service", nil];
//    NSMutableDictionary *headDic = [AppControlManager getSTHeadDictionary:dic strurl:strurl];
//
//    [RequestFromServer requestWithURL:url type:@"POST" requsetHeadDictionary:headDic requestBodyDictionary:dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    
//    }];
//
//}
//
+(void)orderpay: (NSString*)order_no account_type:(NSString *)account view:(UIView*)view callback:(MyCallback)callback;{
    
     NSString *strURL = [strBKAPI stringByAppendingString:strOrder_pay];
//    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:order_no,@"order_no",account,@"account_type" ,nil];
        NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:order_no,@"order_no",nil];
    
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
   
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject) {
            NSDictionary *result_dic = responseObject;
            BOOL success = [[result_dic objectForKey:@"success"] boolValue];
            NSString *msg = [result_dic objectForKey:@"msg"];
            NSString *code = [result_dic objectForKey:@"code"];
            
            ShoppingCarCommon *shcar = [[ShoppingCarCommon alloc] init];
            shcar.success = success;
            shcar.msg = msg;
            shcar.code = code;
            callback(shcar,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];

}
#pragma mark - 添加到购物车
+(void)addProduciontoShoppingCar:(NSString*)strjson view:(UIView*)view callback:(MyCallback)callback;{
    
    NSString *strURL = [strBKAPI stringByAppendingString:strShoping_car_add];
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:strjson,@"data", nil];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        NSString *msg = @"添加成功";// [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        
        ShoppingCarCommon *shcar = [[ShoppingCarCommon alloc] init];
        shcar.success = success;
        shcar.msg = msg;
        shcar.code = code;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject allKeys] containsObject:@"success"]) {
                shcar.data = responseObject;
            }
        }
        callback(shcar,nil);

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
    
}
#pragma mark -确认收货
+(void)confirmReceive:(NSString*)order_no view:(UIView*)view callback:(MyCallback)callback; {
    
    NSString *strURL = [strBKAPI stringByAppendingString:strConfirm_receive];
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:order_no,@"order_id", nil];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;
        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        NSString *msg = [result_dic objectForKey:@"msg"];
        NSString *code = [result_dic objectForKey:@"code"];
        
        ShoppingCarCommon *shcar = [[ShoppingCarCommon alloc] init];
        shcar.success = success;
        shcar.msg = msg;
        shcar.code = code;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject allKeys] containsObject:@"success"]) {
                shcar.data = responseObject;
            }
        }
        callback(shcar,nil);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];

}

#pragma mark - 商品详情

+(void)GoodsDetail:(NSString*)goodsID view:(UIView*)view CompeletionCallBack:(CompeletionCallBack)callback;{
    
    NSString *strURL0 = [strBKAPI stringByAppendingString:strGoods_detail];
    NSString *strURL = [strURL0 stringByAppendingString:goodsID];
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:nil requestBodyDictionary:nil showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            BOOL success = [[responseObject objectForKey:@"success"] boolValue];
            if (success) {
                NSDictionary *data_dic = [responseObject objectForKey:@"data"];
                GoodsDataModel *goods = [GoodsDataModel objectWithKeyValues:data_dic];
                callback(goods,nil);
            }else{
                [ShowMessage showMessage:[responseObject objectForKey:@"msg"]];
                NSError *error = [responseObject objectForKey:@"msg"];
                callback(nil,error);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
        
    }];
}
#pragma mark - 商品首页
+(void)GoodsHomeView:(UIView*)view CompeletionCallBack:(CompeletionCallBack)callback;{
    NSString *strURL = [[strGOODSHOME stringByAppendingString:strGoods_list] stringByAppendingString:@".json"];
    
    [RequestFromServer requestWithURL:strURL type:@"GET" requsetHeadDictionary:nil requestBodyDictionary:nil showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if (responseObject) {
            HOME *goods = [HOME objectWithKeyValues:responseObject];
            NSMutableArray * topGoodsNoArr = [[NSMutableArray alloc] init];
            NSMutableArray * globalGoodsNoArr = [[NSMutableArray alloc] init];
            NSMutableArray * tshirtGoodsNoArr = [[NSMutableArray alloc] init];
            [goods.top enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                Title * title = obj;
                [title.list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    List * list = obj;
                    [topGoodsNoArr addObject:list.goods_no];
                }];
                
            }];
            [goods.global enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                Title * title = obj;
                [title.list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    List * list = obj;
                    [globalGoodsNoArr addObject:list.goods_no];
                }];
                
            }];
            [goods.tshirt enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                Title * title = obj;
                [title.list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    List * list = obj;
                    [tshirtGoodsNoArr addObject:list.goods_no];
                }];
                
            }];


            NSString * goodsNoStr1 = [topGoodsNoArr componentsJoinedByString:@","];
            [GoodsService getGoodsReserveStatusWithGoodsNo:goodsNoStr1 compeletion:^(id result, NSError *error) {
                [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    for (Title * tempTitle in goods.top) {
                        Title * title = tempTitle;
                        for (List * tempModel in title.list) {
                            NSMutableString * goodsNo = [obj objectForKey:@"goodsNo"];
                            if ([tempModel.goods_no isEqualToString:goodsNo]) {
                                [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                                    [tempModel setValue:obj forKey:key];
                                }];
                                
                            }
                        }

                    }
                }];
                callback(goods,nil);

            }];
            [goods.global enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                Title * title = obj;
                [title.list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    List * list = obj;
                    [topGoodsNoArr addObject:list.goods_no];
                    
                }];
                
            }];
            NSString * goodsNoStr2 = [globalGoodsNoArr componentsJoinedByString:@","];
            [GoodsService getGoodsReserveStatusWithGoodsNo:goodsNoStr2 compeletion:^(id result, NSError *error) {
                [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    for (Title * tempTitle in goods.global) {
                        Title * title = tempTitle;
                        for (List * tempModel in title.list) {
                            NSMutableString * goodsNo = [obj objectForKey:@"goodsNo"];
                            if ([tempModel.goods_no isEqualToString:goodsNo]) {
                                [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                                    [tempModel setValue:obj forKey:key];
                                }];
                                
                            }
                        }
                        
                    }
                }];
                callback(goods,nil);
                
            }];

            [goods.tshirt enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                Title * title = obj;
                [title.list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    List * list = obj;
                    [topGoodsNoArr addObject:list.goods_no];
                    
                }];
                
            }];
            NSString * goodsNoStr3 = [tshirtGoodsNoArr componentsJoinedByString:@","];
            [GoodsService getGoodsReserveStatusWithGoodsNo:goodsNoStr3 compeletion:^(id result, NSError *error) {
                [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    for (Title * tempTitle in goods.tshirt) {
                        Title * title = tempTitle;
                        for (List * tempModel in title.list) {
                            NSMutableString * goodsNo = [obj objectForKey:@"goodsNo"];
                            if ([tempModel.goods_no isEqualToString:goodsNo]) {
                                [obj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                                    [tempModel setValue:obj forKey:key];
                                }];
                                
                            }
                        }
                    }
                }];
                callback(goods,nil);
                
            }];

 
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        callback(operation,error);
    }];
}
#pragma mark - 判断收藏
+(void)isSaveGoodsToCollect:(NSString*)ids view:(UIView*)view callback:(MyCallback)callback;{
    
    NSString *strURL = [strBKAPI stringByAppendingString:strShoping_collect_isSave];
    NSDictionary *body_dic = [NSDictionary dictionaryWithObjectsAndKeys:ids,@"goodsId",nil];
    NSDictionary *head_dic = [AppControlManager getSTHeadDictionary:body_dic strurl:strURL];
    
    [RequestFromServer requestWithURL:strURL type:@"POST" requsetHeadDictionary:head_dic requestBodyDictionary:body_dic showHUDView:view showErrorAlertView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result_dic = responseObject;
        //        BOOL success = [[result_dic objectForKey:@"success"] boolValue];
        //        NSString *msg = [result_dic objectForKey:@"msg"];
        //        NSString *code = [result_dic objectForKey:@"code"];
        //
        //        ShoppingCarCommon *shcar = [[ShoppingCarCommon alloc] init];
        //        shcar.success = success;
        //        shcar.msg = msg;
        //        shcar.code = code;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject allKeys] containsObject:@"success"]) {
                callback(result_dic,nil);
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
