//
//  OrderInfo.h
//  BESTKEEP
//
//  Created by dcj on 15/9/11.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BaseObject.h"

@interface OrderInfo : BaseObject
@property (nonatomic,copy) NSString * amount;
@property (nonatomic,copy) NSString * channel_type;
@property (nonatomic,copy) NSString * customs_tax_amount_total;//关税
@property (nonatomic,copy) NSString * deliver;//发货地
@property (nonatomic,copy) NSString * express_amount;
@property (nonatomic,copy) NSString * order_amount;
@property (nonatomic,copy) NSString * order_id;
@property (nonatomic,copy) NSString * order_no;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * status_name;

@property (nonatomic,copy) NSString * deliver_code;//发货地code
@property (nonatomic,copy) NSString * express_companyid;//快递公司id
@property (nonatomic,copy) NSString * global_status;//是否全球购
@property (nonatomic,copy) NSString * money;//订单金额
@property (nonatomic,copy) NSString * shoppingGuideAmount;//导购金
@property (nonatomic,copy) NSString * express_amont;//运费

@property (nonatomic,strong) NSMutableArray * goodslist;

-(BOOL)isGlobal;


@end
