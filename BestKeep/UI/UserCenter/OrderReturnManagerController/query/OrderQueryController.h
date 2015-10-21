//
//  OrderQueryController.h
//  BESTKEEP
//
//  Created by dcj on 15/8/25.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BaseViewController.h"
/**
 *  退货查询
 */

typedef NS_ENUM(NSUInteger, QueryControllerTableViewSection) {
    QueryControllerTableViewSectionTime = 0,
    QueryControllerTableViewSectionReturnState,
    QueryControllerTableViewSectionOrderQuery,
};

@interface OrderQueryController : BaseViewController

@end
