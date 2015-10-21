//
//  OrderStatuCell.h
//  BESTKEEP
//
//  Created by dcj on 15/8/19.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoppingCarCommon;

typedef NS_ENUM(NSUInteger, OrderStatuViewType) {
    OrderStatuViewTypeAllOrder = 0,
    OrderStatuViewTypeUnPay ,

    OrderStatuViewTypePaid,
    OrderStatuViewTypeWaitReceive,
};


@protocol ButtonClickDelegate <NSObject>

-(void)onButtonClickWithIndex:(OrderStatuViewType)type;

@end



@interface OrderStatuCell : UITableViewCell
@property (nonatomic,weak) id <ButtonClickDelegate>delegate;
/**
 *  make cell
 *
 *  @param titleArray 名称数组
 *  @param imageArray 图片数组
 */
-(void)updateCellContentViewWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray;
/**
 *  更新cell 的方法
 *
 *  @param shoppingCarCommon 传入model
 */
-(void)updateCellContentDataWithShoppingCarCommon:(ShoppingCarCommon *)shoppingCarCommon;
-(void)updateCellWithCount:(NSInteger)count;
@end



@protocol OrderStatuViewDelegate <NSObject>

-(void)orderStatuDelegateButtonClick:(OrderStatuViewType)type;

@end

@interface OrderStatuView : UIView

@property (nonatomic,assign) OrderStatuViewType type;
@property (nonatomic,weak)id<OrderStatuViewDelegate>statuViewDelegate;


-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr;
-(void)updateWithCount:(NSInteger)count;

@end
