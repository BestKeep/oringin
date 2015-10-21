//
//  GoodsModel.h
//  BESTKEEP
//
//  Created by dcj on 15/8/29.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BaseObject.h"

typedef NS_ENUM(NSUInteger, GoodsStatuIcon) {
    GoodsStatuIconNoIcon= 0,//没有图标
    GoodsStatuIconNoGoods,//缺货
    GoodsStatuIconNoSale,//下架
    GoodsStatuIconpurchase,//预售
    GoodsStatuIconHasGoods,//现货
};



@interface GoodsModel : BaseObject
@property (nonatomic,copy) NSString * goods_no;//商品number
@property (nonatomic,copy) NSString * goodsNo;
@property (nonatomic,copy) NSString * status;//商品库存状态
@property (nonatomic,copy) NSString * goods_img;//商品图片
@property (nonatomic,copy) NSString * goods_id;//商品ID
@property (nonatomic,copy) NSString * goods_name;//商品名称
@property (nonatomic,copy) NSString * member_price;//会员价
@property (nonatomic,copy) NSString * market_price;//市场价
@property (nonatomic,copy) NSString * tax_amount;//糖赋
@property (nonatomic,copy) NSString * amount;//商品数量
@property (nonatomic,copy) NSString * sale_property;//销售属性描述，颜色：黑色
@property (nonatomic,copy) NSString * goods_pro_rel1;
@property (nonatomic,copy) NSString * goods_pro_rel2;
@property (nonatomic,copy) NSString * goods_pro_rel3;
@property (nonatomic,copy) NSString * goods_pro_rel4;
@property (nonatomic,copy) NSString * goods_pro_rel5;
@property (nonatomic,copy) NSString * goods_img_small;//商品图片
@property (nonatomic,copy) NSString * goods_img_big;//商品图片
@property (nonatomic,copy) NSString * total_amount;//实付款
@property (nonatomic,copy) NSString * goods_image;//商品图片
@property (nonatomic,copy) NSString * group;
@property (nonatomic,copy) NSString * tax;
@property (nonatomic,copy) NSString * customs_tax_amount;//海关税（全球购
@property (nonatomic,copy) NSString * discount_amount;//糖惠金（全球购）

@property (nonatomic,assign) GoodsStatuIcon goodsStatu;//商品库存状态

@property (nonatomic,assign) BOOL isSelected;


@end


@interface CollectionGoodsModel : GoodsModel

@property (nonatomic,copy) NSString * collect_id;//收藏商品id


/**
 *  获得价格差
 *
 *  @return 返回价格差值
 */

-(NSString *)getPriceBalance;

@end
