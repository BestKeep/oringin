//
//  TwoCell.m
//  BESTKEEP
//
//  Created by YISHANG on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "TwoCell.h"

@implementation TwoCell

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
        self.view3 = [[UIView alloc] initWithFrame:CGRectMake(0,20, SCREEN_WIDTH, 30)];
        self.view3.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.view3];
        self.view_0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        self.view_0.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.view_0];
        self.titleLabel = [UILabel new];
        [self initLabel:self.titleLabel Frame:CGRectZero FontSize:16 Color:[UIColor blackColor]];
        [self.view3 addSubview:self.titleLabel];
        
        self.numLabel = [UILabel new];
        [self initLabel:self.numLabel Frame:CGRectZero FontSize:15 Color:COLOR_06];
        [self.view3 addSubview:self.numLabel];
        
        self.label_0 = [UILabel new];
        [self initLabel:self.label_0 Frame:CGRectZero FontSize:13 Color:COLOR_07];
        [self.view_0 addSubview:self.label_0];
        
        self.label_1 = [UILabel new];
        [self initLabel:self.label_1 Frame:CGRectZero FontSize:13 Color:COLOR_07];
        [self.view_0 addSubview:self.label_1];
        
        self.tax_label1 = [UILabel new];
        [self initLabel:self.tax_label1 Frame:CGRectZero FontSize:13 Color:COLOR_07];
        [self.view_0 addSubview:self.tax_label1];
        
        self.tax_label2 = [UILabel new];
        [self initLabel:self.tax_label2 Frame:CGRectZero FontSize:13 Color:COLOR_07];
        [self.view_0 addSubview:self.tax_label2];

        
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.centerY.equalTo(self.view3.mas_centerY);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.numLabel.mas_left).offset(-5);
            make.centerY.equalTo(self.view3.mas_centerY);
        }];
        
    //////////////////////
        
        
        [self.tax_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view_0.mas_right).offset(-15);
            make.centerY.equalTo(self.view_0.mas_centerY);
        }];
        [self.tax_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view_0.mas_left).offset(-10);
            make.centerY.equalTo(self.view_0.mas_centerY);
        }];
        
        [self.label_0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.tax_label2.mas_left).offset(-15);
            //make.top.equalTo(self.view_0.mas_top).offset(10);
            make.centerY.equalTo(self.view_0.mas_centerY);
        }];
        
        [self.label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.label_0.mas_left).offset(-5);
            // make.top.equalTo(self.view_0.mas_top).offset(10);
            make.centerY.equalTo(self.view_0.mas_centerY);
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
