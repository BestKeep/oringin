//
//  cellDetailCell.h
//  BESTKEEP
//
//  Created by UTOUU on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cellDetailView : UIView //购物车cell是详情时加载的View

@property (nonatomic, strong) UILabel *label1;  //物品详情介绍

@property (nonatomic, strong) UILabel *label2;  //会员价

@property (nonatomic, strong) UILabel *colorLabel;  //颜色

@property (nonatomic, strong) UILabel *sizeLabel;  //尺码

@property (nonatomic, strong) UILabel *label3;   //会员价  价格

@property (nonatomic, strong) UILabel *label4;   //糖赋

@property (nonatomic, strong) UILabel *label5;    //糖赋   税额

@property (nonatomic, strong) UILabel *label6;   //多少件

@end
