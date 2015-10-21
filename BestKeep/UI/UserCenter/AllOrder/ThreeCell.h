//
//  ThreeCell.h
//  BESTKEEP
//
//  Created by YISHANG on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol orderOperationDelegate <NSObject>

@optional
-(void)clickCanelOrder:(NSInteger)index;
-(void)clickPayOrder:(NSInteger)index;
-(void)clickConfirmReceive:(NSInteger)index;

@end

@interface ThreeCell : UITableViewCell

@property(nonatomic,weak) id<orderOperationDelegate>delegate;

@property(nonatomic,strong) UIView *view4;
@property(nonatomic,strong) UIButton *button1;
@property(nonatomic,strong) UIButton *button2;
@property(nonatomic,strong) UIButton *button3;

@property(nonatomic,strong) UIView *lineView;
@end
