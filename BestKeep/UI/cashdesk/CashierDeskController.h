//
//  CashierDeskController.h
//  BESTKEEP
//
//  Created by dcj on 15/8/25.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BaseViewController.h"


/**
 *  收银台
 */

typedef NS_ENUM(NSUInteger, CashierDeskSectionType) {
    CashierDeskSectionTypeBasicInfo = 0,
    CashierDeskSectionTypePayType,
};

@interface CashierDeskController : BaseViewController

/**
 *  初始化时必须传入
 */
@property (nonatomic,strong) NSArray * orderArr;
@property (nonatomic,strong) NSString *isGlobal;
@property (nonatomic,strong) NSDictionary *param_dic;


@end
