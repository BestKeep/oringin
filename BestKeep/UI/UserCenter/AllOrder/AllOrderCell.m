//
//  AllOrderCell.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/25.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AllOrderCell.h"
#define LEFT 15
#define CELLHEIGHT 243


@implementation AllOrderCell

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
        
        //背景视图
        self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        self.view1.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.view1];
        
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
    return self;
}
-(void)initLabel:(UILabel*)textLabel Frame:(CGRect)frame FontSize:(CGFloat)size Color:(UIColor*)color {
    textLabel.frame = frame;
    textLabel.font = [UIFont boldSystemFontOfSize:size];
    textLabel.numberOfLines = 0;
    textLabel.textColor = color;
    [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
}


@end
