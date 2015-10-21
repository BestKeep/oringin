//
//  UserCenterTextButtonView.m
//  BESTKEEP
//
//  Created by dcj on 15/8/19.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "UserCenterTextButtonView.h"
#import "Masonry.h"
#import "UIView+Position.h"
@interface UserCenterTextButtonView ()

@end

@implementation UserCenterTextButtonView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{

    UILabel * tempTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:tempTextLabel];
    self.textLabel = tempTextLabel;
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.button];
    [self layoutSubviewsT];
    tempTextLabel.text = @"0";
    tempTextLabel.font = [UIFont boldSystemFontOfSize:15];
    tempTextLabel.textColor = [UIColor whiteColor];
    self.button.titleEdgeInsets = UIEdgeInsetsMake(-8, 0, 8, 0);
    self.button.titleLabel.font = [UIFont systemFontOfSize:13];
}

-(void)layoutSubviewsT{
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).mas_offset(10);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.textLabel.mas_bottom);
        make.bottom.equalTo(self.mas_bottom).mas_offset(10);
    }];
}
-(void)changeTextLabelText:(NSString *)text{

    self.textLabel.text = text;
    
}

@end
