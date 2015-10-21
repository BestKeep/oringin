//
//  FirstPageHeaderView.m
//  UTOUU_TEST
//
//  Created by UTOUU on 15/9/7.
//  Copyright (c) 2015年 UTOUU. All rights reserved.
//

#import "FirstPageHeaderView.h"
#import "Masonry.h"

#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation FirstPageHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _TOP_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_TOP_Button setTitle:@"TOP" forState:UIControlStateNormal];
        [_TOP_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_TOP_Button setTitleColor:RgbColor(2, 162, 123) forState:UIControlStateSelected];
        [_TOP_Button setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_TOP_Button];
        
        _BuyEarth_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_BuyEarth_Button setTitle:@"全球购" forState:UIControlStateNormal];
        [_BuyEarth_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_BuyEarth_Button setTitleColor:RgbColor(2, 162, 123) forState:UIControlStateSelected];
        [_BuyEarth_Button setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_BuyEarth_Button];
        
        
        _TSHIRT_Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_TSHIRT_Button setTitle:@"T-SHIRT" forState:UIControlStateNormal];
        [_TSHIRT_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_TSHIRT_Button setTitleColor:RgbColor(2, 162, 123) forState:UIControlStateSelected];
        [_TSHIRT_Button setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_TSHIRT_Button];
        
        
        
        
        
        [_TOP_Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.width.mas_equalTo(@(SCREEN_WIDTH/3));
            make.top.mas_equalTo(self.mas_top).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-2);
        }];
        
        [_BuyEarth_Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_TOP_Button.mas_right);
            make.width.mas_equalTo(@(SCREEN_WIDTH/3));
            make.top.mas_equalTo(self.mas_top).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-2);
        }];
        
        [_TSHIRT_Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_BuyEarth_Button.mas_right);
            make.width.mas_equalTo(@(SCREEN_WIDTH/3));
            make.top.mas_equalTo(self.mas_top).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-2);
        }];
        
    }
    return self;
}


@end
