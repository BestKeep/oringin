//
//  HeaderView.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/21.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "HeaderView.h"


@implementation HeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        //rightArrow
        UILabel *rightArrow = [[UILabel alloc] initWithFrame:CGRectZero];
        rightArrow.font=[UIFont fontWithName:@"iconfont" size:20];
        rightArrow.textColor = COLOR_05;
        rightArrow.text = @"\U0000e610";
        [self addSubview:rightArrow];
        [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.centerY.equalTo(self.mas_centerY).offset(0) ;
            
        }];
        
        self.posLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 20, 40)];
        self.posLabel.font=[UIFont fontWithName:@"iconfont" size:20];
        self.posLabel.numberOfLines = 2;
        self.posLabel.textColor = COLOR_05;
        self.posLabel.text = @"\U0000e631";
        [self addSubview:self.posLabel];

        self.nameLabel = [UILabel new];
        self.cellphoneLabel = [UILabel new];
        self.addressLabel = [UILabel new];
        
        self.nameLabel.textColor = COLOR_07;
        self.cellphoneLabel.textColor = COLOR_07;
        self.addressLabel.textColor = COLOR_05;
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        
        self.cellphoneLabel.font = [UIFont boldSystemFontOfSize:16];
        self.addressLabel.font = [UIFont boldSystemFontOfSize:14];
        self.addressLabel.numberOfLines = 2;
        [self addSubview:self.nameLabel];
        [self addSubview:self.cellphoneLabel];
        [self addSubview:self.addressLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(50);
            make.top.equalTo(self.mas_top).mas_offset(10);
        }];
        
        [self.cellphoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel. mas_right).offset(10);
            make.top.equalTo(self.mas_top).mas_offset(10);
        }];
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self. mas_left).offset(50);
            make.right.equalTo(self.mas_right).offset(-30);
            make.top.equalTo(self.cellphoneLabel. mas_bottom).mas_offset(10);
        }];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        tap.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:tap];
        
    }return self;
}
-(void)singleTap:(UIGestureRecognizer*)tapReconnizer{
    if ([self.delegate respondsToSelector:@selector(tapHeaderViewEvent)]) {
        [self.delegate tapHeaderViewEvent];
    }
}
-(void)updateHeaderViewWithModel:(DeliverAddress *)address{
    self.nameLabel.text = address.deliverName;
    self.cellphoneLabel.text = address.deliverTelephone;
    self.addressLabel.text = address.deliverAddress;
}
@end
