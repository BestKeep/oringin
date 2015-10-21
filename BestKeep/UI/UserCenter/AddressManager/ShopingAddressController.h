//
//  ShopingAddressController.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/24.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressCell.h"
#import "QRadioButton.h"
#import "DeliverAddress.h"
#import "AddController.h"

@interface ShopingAddressController : BaseViewController<UITableViewDelegate,UITableViewDataSource,clickButtonDelegate,QRadioButtonDelegate>
@property (nonatomic,strong) UITableView * ShopingTableView;
@property (nonatomic,strong) NSMutableArray * orderList;
@property (nonatomic, strong)NSMutableArray *list_data;
@property (nonatomic,strong)NSString *DeliverName;//收货人名字
@property (nonatomic,strong)NSString *Telephone;//收货人电话
@property (nonatomic,strong)NSString *address;//收货人地址
@property (nonatomic,strong)NSString *isAddress;
@property (nonatomic,strong)NSString *addressmsg;



@end