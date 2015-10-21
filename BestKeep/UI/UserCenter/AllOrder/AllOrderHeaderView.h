//
//  AllOrderHeaderView.h
//  BESTKEEP
//
//  Created by dcj on 15/9/11.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfo.h"
@interface AllOrderHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong) OrderInfo * orderInfo;

@property(nonatomic,strong) UILabel *addressLabel;
@property(nonatomic,strong) UILabel *orderStatusLabel;
@property(nonatomic,strong) UILabel *order_no;
@property(nonatomic,strong) UIView *singleLine;

@end
