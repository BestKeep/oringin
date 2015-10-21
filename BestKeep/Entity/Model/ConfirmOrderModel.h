//
//  ConfirmOrderModel.h
//  BESTKEEP
//
//  Created by dcj on 15/10/21.
//  Copyright © 2015年 YISHANG. All rights reserved.
//

#import "BaseObject.h"

@interface ConfirmOrderModel : BaseObject

@property (nonatomic,copy) NSString * order_amount;
@property (nonatomic,strong) NSMutableArray * orderList;
@property (nonatomic,copy) NSString * goods_amount;
@property (nonatomic,copy) NSString * express_amount;


@end
