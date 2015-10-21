//
//  BuyCarDetailCell.h
//  BESTKEEP
//
//  Created by UTOUU on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cellDataView.h"
#import "cellDetailView.h"
#import "ShoppingCarList.h"


@class BuyCarDetailCell;

@protocol cellButtonDetegate <NSObject>

- (void)updataCellButtonModel:(ShoppingCarList*)sender tableViewCell:(BuyCarDetailCell*)cell;
- (void)updataCellContentData:(ShoppingCarList *)shoppingCarList tableViewCell:(BuyCarDetailCell *)cell;

@end

@interface BuyCarDetailCell : UITableViewCell  //购物车的Cell

@property (nonatomic, strong) UIButton *button1;   //cell 点击按钮

@property (nonatomic, strong) UIImageView* imageView1;  //物品图片

@property (nonatomic , strong) cellDataView* addView;    //编辑状态下得View  有加减号

@property (nonatomic , strong) cellDetailView* detailView;  //物品详情View

@property (nonatomic,weak ) id<cellButtonDetegate> cellBtnDetegate;


-(void)updateCellWithModel:(ShoppingCarList *)model;



@end

