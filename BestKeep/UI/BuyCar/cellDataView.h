//
//  cellDataView.h
//  BESTKEEP
//
//  Created by UTOUU on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class cellDataView;
@class ShoppingCarList;

@protocol CellDataViewDelegate <NSObject>

-(void)cellDataView:(cellDataView *)dataView addCount:(UIButton *)addButton;
-(void)cellDataView:(cellDataView *)dataView subCount:(UIButton *)subButton;
-(void)cellDataView:(cellDataView *)dataView deletButtonClick:(UIButton *)deleteButton;

@end



@interface cellDataView : UIView

@property (nonatomic,weak) id <CellDataViewDelegate> dataViewDelegate;

@property (nonatomic, strong) UILabel *label1; //中间数量

@property (nonatomic, strong) UILabel *label2;  //颜色Label//尺码Label

@property (nonatomic, strong) UILabel *label3;  //尺码Label

@property (nonatomic, strong) UILabel *line1;   //灰线

@property (nonatomic, strong) UILabel *line2;   //灰线

@property (nonatomic, strong) UILabel *line3;   //底部灰线

@property (nonatomic, strong) UIButton *button1;  //减号按钮

@property (nonatomic, strong) UIButton *button2;   //加好按钮

@property (nonatomic, strong) UIButton *button3;   //删除按钮

-(void)updateDataWithShoppingCarList:(ShoppingCarList *)orderModel;

@end
