//
//  HeaderView.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/21.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliverAddress.h"
@protocol headViewDelegate <NSObject>

-(void)tapHeaderViewEvent;

@end

@interface HeaderView : UIView

@property(nonatomic,weak) id<headViewDelegate>delegate;
@property(nonatomic,strong) UIImageView *posView;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *cellphoneLabel;
@property(nonatomic,strong) UILabel *addressLabel;
@property(nonatomic,strong) UILabel *posLabel;
-(void)updateHeaderViewWithModel:(DeliverAddress *)address;
@end
