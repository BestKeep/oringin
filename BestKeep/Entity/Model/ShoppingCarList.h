
//
//  ShoppingCarList.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCarList : NSObject

@property(nonatomic) BOOL success;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,copy) NSString *code;
@property(nonatomic,copy) NSString *deliver;
@property(nonatomic,copy) NSString *record_id;
@property(nonatomic,copy) NSString *good_id;
@property(nonatomic,copy) NSString *goods_img;
@property(nonatomic,copy) NSString *goods_name;
@property(nonatomic,copy) NSString *member_price;
@property(nonatomic,copy) NSString *tax_amount;
@property(nonatomic,copy) NSString *amount;
@property(nonatomic,copy) NSString *sale_property;
@property(nonatomic,copy) NSString *goods_pro_rel1;
@property(nonatomic,copy) NSString *goods_pro_rel2;
@property(nonatomic,copy) NSString *goods_pro_rel3;
@property(nonatomic,copy) NSString *goods_pro_rel4;
@property(nonatomic,copy) NSString *goods_pro_rel5;
@property(nonatomic,copy) NSString *goods_reserve_id;
@property(nonatomic,copy) NSString *amountSign;//用来记录订单商品数量 以判断订单是否修改 以后扩展可以扩展为一个model记录

@property(nonatomic,retain) NSMutableArray *deliverArray;
@property(nonatomic,retain) NSMutableArray *item_ListArray;

@property (nonatomic,assign) BOOL buyEarth;

@property (nonatomic , assign) BOOL isEdit;
@property (nonatomic, assign) BOOL  isCellBtnSelect;
@property (nonatomic , strong)NSString* address;
@property (nonatomic, assign) NSIndexPath *indexPahh;
-(BOOL)isOrderChanged;
@end

@interface superShopping : NSObject

@property(nonatomic,retain) NSString *address;
@property(nonatomic,retain) NSMutableArray* shopList;
@property(nonatomic,assign) BOOL global_status1;//0:非全球购，1：全球购;

@end


