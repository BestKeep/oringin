//
//  AddressManagerController.h
//  BESTKEEP
//
//  Created by cunny on 15/8/28.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NewAddressCell.h"
#import "QRadioButton.h"


@interface AddressManagerController : BaseViewController<UITableViewDelegate,UITableViewDataSource,NewclickButtonDelegate,QRadioButtonDelegate>
@property (nonatomic,strong) UITableView * ShopingTableView;
@property (nonatomic,strong) NSMutableArray * orderList;
@property (nonatomic,strong)NSString *DeliverName;
@property (nonatomic,strong)NSString *Telephone;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *isAddress;
@property (nonatomic,strong)NSString *addressmsg;

@property (nonatomic,copy)void(^SelectedAddressCompeletion)(DeliverAddress *selectedAddress);


@end
