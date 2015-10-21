//
//  ThreeCell.m
//  BESTKEEP
//
//  Created by YISHANG on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "ThreeCell.h"

@implementation ThreeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.view4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        [self.contentView addSubview:self.view4];
        //取消订单按钮
        self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button1 setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.button1 setTitleColor:COLOR_04 forState:UIControlStateNormal];
        self.button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.button1.layer.borderColor = COLOR_04.CGColor;
        self.button1.layer.borderWidth = 1.0;
        self.button1.layer.cornerRadius = 5.0f;
        [self.button1 addTarget:self action:@selector(cancelorderEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //付款按钮
        self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button2 setTitle:@"付款" forState:UIControlStateNormal];
        self.button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.button2 setTitleColor:COLOR_04 forState:UIControlStateNormal];
        self.button2.layer.borderColor = COLOR_04.CGColor;
        self.button2.layer.borderWidth = 1.0;
        self.button2.layer.cornerRadius = 5.0f;
        [self.button2 addTarget:self action:@selector(payMoneyEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        //确认订单按钮
        self.button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button3 setTitle:@"确认收货" forState:UIControlStateNormal];
        self.button3.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.button3 setTitleColor:COLOR_04 forState:UIControlStateNormal];
        self.button3.layer.borderColor = COLOR_04.CGColor;
        self.button3.layer.borderWidth = 1.0;
        self.button3.layer.cornerRadius = 5.0f;
        [self.button3 addTarget:self action:@selector(confirmReceiveEvent:) forControlEvents:UIControlEventTouchUpInside];

        
        
        [self.view4 addSubview:self.button1];
        [self.view4 addSubview:self.button2];
        [self.view4 addSubview:self.button3];
        [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view4.mas_right).offset(-15);
            make.centerY.equalTo(self.view4.mas_centerY);
            make.width.equalTo(@(90));
            make.height.equalTo(@(30));
        }];
        [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.button2.mas_left).offset(-10);
            make.centerY.equalTo(self.view4.mas_centerY);
            make.width.equalTo(@(90));
            make.height.equalTo(@(30));
        }];
        [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.button1.mas_left).offset(-10);
            make.centerY.equalTo(self.view4.mas_centerY);
            make.width.equalTo(@(90));
            make.height.equalTo(@(30));
        }];

        
        self.lineView = [UIView new];
        self.lineView.backgroundColor = COLOR_05;
        self.lineView.alpha = 0.1;
        [self.view4 addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view4.mas_right).offset(0);
            make.left.equalTo(self.view4.mas_left).offset(0);
            make.top.equalTo(self.view4.mas_top).offset(0);
            make.width.equalTo(@(SCREEN_WIDTH));
            make.height.equalTo(@(1));
        }];

        
    }
    return self;
}
-(void)initLabel:(UILabel*)textLabel Frame:(CGRect)frame FontSize:(CGFloat)size Color:(UIColor*)color {
    textLabel.frame = frame;
    textLabel.font = [UIFont boldSystemFontOfSize:size];
    textLabel.numberOfLines = 0;
    textLabel.textColor = color;
    [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
}

-(void)cancelorderEvent:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(clickCanelOrder:)]) {
        [self.delegate clickCanelOrder:sender.tag];
    }
}
-(void)payMoneyEvent:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(clickPayOrder:)]) {
        [self.delegate clickPayOrder:sender.tag];
    }
}
-(void)confirmReceiveEvent:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(clickConfirmReceive:)]) {
        [self.delegate clickConfirmReceive:sender.tag];
    }
}

@end
