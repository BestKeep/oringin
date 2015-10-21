//
//  AllOrderController.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/25.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BaseViewController.h"
#import "AllOrderCell.h"
#import "ThreeCell.h"
#import "OrderStatuCell.h"

@interface AllOrderController : BaseViewController<UITableViewDataSource,UITableViewDelegate,orderOperationDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) UITableView *orderTableView;
@property (nonatomic,assign) OrderStatuViewType type;

@property (nonatomic,copy) NSArray *order_no_array;
@property (nonatomic,retain) NSMutableArray *isglobal_array;


@end
