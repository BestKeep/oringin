//
//  AllOrderFooterView.h
//  BESTKEEP
//
//  Created by dcj on 15/9/18.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@class OrderInfo;
@class AllOrderFooterView;

typedef NS_ENUM(NSUInteger, AllOrderFooterActionType) {
    AllOrderFooterActionTypeCancle = 0,
    AllOrderFooterActionTypePay,
    AllOrderFooterActionTypeConfirm,
};

@protocol AllOrderFooterProtocol <NSObject>
@optional
-(void)allOrderView:(AllOrderFooterView *)footerView actionType:(AllOrderFooterActionType)type order:(OrderInfo *)order;

@end

@interface AllOrderFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong) OrderInfo * order;
@property (nonatomic,weak)id<AllOrderFooterProtocol>footerDelegate;

-(CGFloat)getFooterHeightWithOrder:(OrderInfo *)orderInfo;

@end


@interface AllOrderFooterOrderInfoView : UIView

@property (nonatomic,strong) OrderInfo * order;
-(CGFloat)getFooterOrderInfoHeightWithOrder:(OrderInfo *)orderInfo;


@end


@protocol AllOrderFooterActionProtocol <NSObject>

@optional
-(void)allOrderFooterViewAction:(AllOrderFooterActionType)type orderInfo:(OrderInfo *)order;
@end


@interface AllOrderFooterActionView : UIView


@property (nonatomic,weak)id<AllOrderFooterActionProtocol>delegate;
@property (nonatomic,strong) OrderInfo * order;

-(CGFloat)getFooterActionViewHeightWithOrder:(OrderInfo *)orderInfo;


@end