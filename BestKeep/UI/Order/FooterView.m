//
//  FooterView.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/24.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "FooterView.h"
#import "ConfirmOrderModel.h"
#import "OrderInfo.h"
@implementation FooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = COLOR_04;
        [btn setTitle:@"提交订单" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        SEL sel = @selector(commitOrder);
        [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self. mas_right).mas_offset(0);
            make.bottom.equalTo(self.mas_bottom).mas_offset(0);
            make.top.equalTo(self.mas_top).mas_equalTo(0);
            make.width.equalTo(@(SCREEN_WIDTH/3));
        }];
        self.label1 = [BTLabel new];
        self.label2 = [BTLabel new];
        self.label3 = [BTLabel new];
        self.label4 = [BTLabel new];
        self.guide_label = [BTLabel new];
        self.guide_textlabel = [BTLabel new];
        self.guide_cashlabel = [BTLabel new];
        [self initLabel:self.label1 FontSize:14 Color:COLOR_07];
        [self initLabel:self.label2 FontSize:14 Color:COLOR_07];
        [self initLabel:self.label3 FontSize:14 Color:COLOR_06];
        [self initLabel:self.label4 FontSize:14 Color:COLOR_07];
        [self initLabel:self.guide_textlabel FontSize:14 Color:COLOR_07];
        [self initLabel:self.guide_cashlabel FontSize:14 Color:COLOR_06];
        [self initLabel:self.guide_label FontSize:14 Color:COLOR_07];
        
        [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btn.mas_left).mas_offset(-10);
           // make.top.equalTo(self.mas_top).mas_offset(0);
            make.bottom.equalTo(self.mas_bottom).mas_offset(-2);
        }];
        [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.label4.mas_left).mas_offset(-2);
            //make.top.equalTo(self.mas_top).mas_offset(0);
            make.bottom.equalTo(self.mas_bottom).mas_offset(-2);
        }];
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.label3.mas_left).mas_offset(-2);
            //make.top.equalTo(self.mas_top).mas_offset(0);
            make.bottom.equalTo(self.mas_bottom).mas_offset(-2);
        }];
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.label2.mas_left).mas_offset(-5);
            //make.top.equalTo(self.mas_top).mas_offset(0);
            make.bottom.equalTo(self.mas_bottom).mas_offset(-2);
        }];
        
        [self.guide_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(btn.mas_left).mas_offset(-10);
            // make.top.equalTo(self.mas_top).mas_offset(0);
            make.top.equalTo(self.mas_top).mas_offset(2);
        }];
        
        [self.guide_cashlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.guide_label.mas_left).mas_offset(-2);
            // make.top.equalTo(self.mas_top).mas_offset(0);
            make.top.equalTo(self.mas_top).mas_offset(2);
        }];
        
        [self.guide_textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.guide_cashlabel.mas_left).mas_offset(-2);
            // make.top.equalTo(self.mas_top).mas_offset(0);
            make.top.equalTo(self.mas_top).mas_offset(2);
        }];




        



    }
    return self;
}

-(void)setOrderModel:(ConfirmOrderModel *)orderModel{
    _orderModel = orderModel;
    [self updateFooterView];
}

-(void)updateFooterView{
    self.label1.text = [NSString stringWithFormat:@"%@%@%@",@"共",@"1",@"笔订单,"];
    self.label2.text = @"总金额";
    self.label3.text = self.orderModel.order_amount;
    self.label4.text = @"元";
    self.guide_label.text = @"元";
    self.guide_textlabel.text = @",产生导购金:";
    UILabel *linkBut = [[UILabel alloc]initWithFrame:CGRectZero];
    linkBut.textColor = [UIColor blueColor];
    linkBut.font = [UIFont boldSystemFontOfSize:14];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"无会员卡"];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    
    linkBut.attributedText = content;
    linkBut.userInteractionEnabled = YES;
    UITapGestureRecognizer *pans = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTap:)];
    [linkBut addGestureRecognizer:pans];
    
    [self addSubview:linkBut];
    [linkBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.guide_textlabel.mas_top);
        make.right.equalTo(self.guide_textlabel.mas_left);
        make.height.equalTo(self.guide_textlabel.mas_height);
    }];
    CGFloat sh_guide = 0.0;
    for (OrderInfo * tempOrder in self.orderModel.orderList) {
        sh_guide += [tempOrder.shoppingGuideAmount floatValue];
    }
    self.guide_cashlabel.text = [NSString stringWithFormat:@"%.2f",sh_guide];
    if (sh_guide == 0) {
        linkBut.hidden = YES;
        self.guide_label.hidden = YES;
        self.guide_textlabel.hidden = YES;
        self.guide_cashlabel.hidden = YES;
        
    }


}

-(void)labelTap:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(footerView:tapgesture:)]) {
        [self.delegate footerView:self tapgesture:tap];
    }
}


-(void)initLabel:(BTLabel*)textLabel  FontSize:(CGFloat)size Color:(UIColor*)color {
    textLabel.font = [UIFont boldSystemFontOfSize:size];
    textLabel.textColor = color;
    [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    textLabel.verticalAlignment = BTVerticalAlignmentCenter;
    [self addSubview:textLabel];
}
-(void)commitOrder{
    if ([self.delegate respondsToSelector:@selector(ClickButtonEvent)]) {
        [self.delegate ClickButtonEvent];
    }
}

@end
