//
//  AllOrderHeaderView.m
//  BESTKEEP
//
//  Created by dcj on 15/9/11.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AllOrderHeaderView.h"

@interface AllOrderHeaderView ()

//@property (nonatomic,strong) UILabel * addressLabel;
//@property (nonatomic,strong) UILabel * orderNoLabel;
//@property (nonatomic,strong) UILabel * orderStatuLabel;

@property(nonatomic,strong) UIView *view1;

//@property(nonatomic,strong) UILabel *addressLabel;
//@property(nonatomic,strong) UILabel *orderStatusLabel;
//@property(nonatomic,strong) UILabel *order_no;
//@property(nonatomic,strong) UIView *singleLine;

@end

@implementation AllOrderHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initContentView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



-(void)initContentView{
    //背景视图
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    self.view1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.view1];
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(@(30));
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    //地址label
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.addressLabel.font = [UIFont boldSystemFontOfSize:16];
    self.addressLabel.textColor = COLOR_07;
    [self.view1 addSubview:self.addressLabel];
    
    self.orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.orderStatusLabel.font = [UIFont boldSystemFontOfSize:14];
    self.orderStatusLabel.textColor = COLOR_04;
    [self.view1 addSubview:self.orderStatusLabel];
    
    self.order_no = [[UILabel alloc] initWithFrame:CGRectZero];
    self.order_no.font = [UIFont boldSystemFontOfSize:12];
    self.order_no.textColor = COLOR_07;
    [self.view1 addSubview:self.order_no];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.centerY.equalTo(self.view1.mas_centerY);
    }];
    
    [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.view1.mas_centerY);
    }];
    
    [self.order_no mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right).offset(15);
        //make.right.equalTo(self.orderStatusLabel.mas_left).offset(-5);
        make.centerY.equalTo(self.view1.mas_centerY);
    }];
    
}

-(void)setOrderInfo:(OrderInfo *)orderInfo{
    _orderInfo = orderInfo;
    [self updateHeaderView];
    
}

-(void)updateHeaderView{
    self.addressLabel.text = self.orderInfo.deliver;
    self.order_no.text = [NSString stringWithFormat:@"NO.%@",self.orderInfo.order_no];
    self.orderStatusLabel.text = self.orderInfo.status_name;
}

-(void)initLabel:(UILabel*)textLabel Frame:(CGRect)frame FontSize:(CGFloat)size Color:(UIColor*)color {
    textLabel.frame = frame;
    textLabel.font = [UIFont boldSystemFontOfSize:size];
    textLabel.numberOfLines = 0;
    textLabel.textColor = color;
    [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
}

@end
