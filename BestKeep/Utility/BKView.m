//
//  BKView.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/30.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BKView.h"

@implementation BKView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *back_view = [[UIView alloc] init];
        back_view.center = self.center;
        back_view.frame = CGRectMake(0, 0, SCREEN_WIDTH -60, SCREEN_HEIGHT/2);
        [self addSubview:back_view];
        
        self.name_textField = [[UITextField alloc] init];
        self.identification_card_textField = [[UITextField alloc] init];
        self.nameLabel = [[UILabel alloc] init];
        self.ident_Label = [[UILabel alloc] init];
        [back_view addSubview:self.nameLabel];
        [back_view addSubview:self.identification_card_textField];
        [back_view addSubview:self.ident_Label];
        
        self.nameLabel.text = @"姓名";
        self.ident_Label.text = @"身份证";
        
        [self.name_textField setBorderStyle:UITextBorderStyleNone];
        self.name_textField.layer.borderWidth = 1.0;
        self.name_textField.layer.borderColor = RGB(221, 221, 221).CGColor;
        self.name_textField.textColor = [UIColor blackColor];
        self.name_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

        [self.name_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(back_view.mas_right).mas_offset(-10);
            make.left.equalTo(back_view.mas_left).mas_offset(10);
            make.top.equalTo(back_view.mas_top).mas_offset(20);
        }];
        
        [self.name_textField setBorderStyle:UITextBorderStyleNone];
        self.name_textField.layer.borderWidth = 1.0;
        self.name_textField.layer.borderColor = RGB(221, 221, 221).CGColor;
        self.name_textField.textColor = [UIColor blackColor];
        self.name_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [self.name_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(back_view.mas_right).mas_offset(-10);
            make.left.equalTo(back_view.mas_left).mas_offset(10);
            make.top.equalTo(back_view.mas_top).mas_offset(20);
        }];
    }
    return self;
}
@end
