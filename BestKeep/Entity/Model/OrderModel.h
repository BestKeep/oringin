//
//  OrderModel.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/28.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderModel2;

@interface OrderModel : NSObject

@property(nonatomic) BOOL success;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,copy) NSString *code;
@property(nonatomic,retain) NSArray *row_array;
@property(nonatomic,retain) NSArray *item_array;


@end
@interface OrderModel1 : NSObject

@property(nonatomic,copy) NSString *total;//总记录数
@property(nonatomic,copy) NSString *pageno;//当前第几页
@property(nonatomic,copy) NSString *pagesize;//每个显示多少条
@property(nonatomic,copy) NSString *deliver;//发货地
@property(nonatomic,copy) NSString *total_order_amount;//订单商品总数
@property(nonatomic,copy) NSString *order_no;//订单号
@property(nonatomic,copy) NSString *order_amount;//订单总金额
@property(nonatomic,copy) NSString *express_amount;//运费
@property(nonatomic,copy) NSString *status_name;//状态名称
@property(nonatomic,copy) NSString *status;//订单状态
@property(nonatomic,copy) NSString *express_companyid;//快递公司id
@property(nonatomic,copy) NSString *global_status;//是否为全球购
@property(nonatomic,copy) NSString *money;//单个订单总金额
@property(nonatomic,copy) NSString *deliver_code;//发货地code
@property(nonatomic,copy) NSString *order_id;//订单ID
@property(nonatomic,copy) NSString *shopping_guide_amount;//每笔订单导购金
@property(nonatomic,copy) NSString *customs_tax_amount_total;//海关税总额
@property(nonatomic,copy) NSString *channel_type;
//@property(nonatomic,retain) NSArray *item_array;


-(void)setCustoms_tax_amount_totalWithGoodsArray:(NSArray *)goodsArray;

-(BOOL)isGlobal;

@end
@interface OrderModel2 : NSObject

@property(nonatomic,copy) NSString *goods_id;//商品ID
@property(nonatomic,copy) NSString *goods_img;//商品图片
@property(nonatomic,copy) NSString *goods_name;//商品名称
@property(nonatomic,copy) NSString *sale_property;//销售属性描述，颜色：黑色
@property(nonatomic,copy) NSString *goods_pro_rel1;//商品销售属性1
@property(nonatomic,copy) NSString *goods_pro_rel2;//商品销售属性2
@property(nonatomic,copy) NSString *goods_pro_rel3;//商品销售属性3
@property(nonatomic,copy) NSString *goods_pro_rel4;//商品销售属性4
@property(nonatomic,copy) NSString *goods_pro_rel5;//商品销售属性5
@property(nonatomic,copy) NSString *member_price;//会员价
@property(nonatomic,copy) NSString *tax_amount;//糖赋
@property(nonatomic,copy) NSString *customs_tax_amount;//海关税（全球购）
@property(nonatomic,copy) NSString *discount_amount;//糖惠金（全球购）
@property(nonatomic,copy) NSString *total_amount;//实付款）
@property(nonatomic,copy) NSString *amount;//商品数量
@property(nonatomic,copy) NSString *goods_reserve_id;//库存ID
@property(nonatomic,copy) NSString *reserveFlag;//库存是否足够
@property(nonatomic,copy) NSString *reserveType;//库存类型
@end
