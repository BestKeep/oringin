//
//  HLCell.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "OrderModel.h"
#import "OrderInfo.h"
@interface HLCell : UITableViewHeaderFooterView

@property(nonatomic,strong) UILabel *label1;
@property(nonatomic,strong) UILabel *label2;
@property(nonatomic,strong) UILabel *label3;
@property(nonatomic,strong) UILabel *label4;
@property(nonatomic,strong) UILabel *label5;
@property(nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) OrderInfo * orderInfo;


//@property (nonatomic,strong) OrderModel1 * model;
//@property (nonatomic,strong) OrderModel2 * goodsModel;
//
//-(void)updateDataWithModel1:(OrderModel1 *)model1 orderModel2:(OrderModel2 *)model2;
//
//
-(CGFloat)cellHeightWithModel:(OrderInfo*)model;

@end
