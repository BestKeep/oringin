//
//  FirstPageSectionView.m
//  UTOUU_TEST
//
//  Created by UTOUU on 15/9/7.
//  Copyright (c) 2015年 UTOUU. All rights reserved.
//

#import "FirstPageSectionView.h"
#import "Masonry.h"

#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
@implementation FirstPageSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RgbColor(232, 232, 232);
        
        
        _sectionLabel1 = [UILabel new];
        _sectionLabel1.backgroundColor = RgbColor(2, 162, 123);
        [self addSubview:_sectionLabel1];
        
        _sectionLabel2 = [UILabel new];
        _sectionLabel2.backgroundColor = RgbColor(2, 162, 123);
        [self addSubview:_sectionLabel2];
        
        
        _sectionLabel3 = [UILabel new];
        _sectionLabel3.backgroundColor = [UIColor whiteColor];
        _sectionLabel3.textColor = RgbColor(2, 162, 123);
        _sectionLabel3.textAlignment = NSTextAlignmentCenter;
        _sectionLabel3.text = @" --- ";
        _sectionLabel3.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_sectionLabel3];
        
        
        [_sectionLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(@(SCREEN_WIDTH - 100));
            make.height.mas_equalTo(@(30));
        }];
        
        
        [_sectionLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_sectionLabel3.mas_left);
            make.height.mas_equalTo(_sectionLabel3.mas_height);
            make.centerY.mas_equalTo(_sectionLabel3.mas_centerY);
            make.width.mas_equalTo(@(3));
        }];
        
        [_sectionLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_sectionLabel3.mas_right);
            make.height.mas_equalTo(_sectionLabel3.mas_height);
            make.centerY.mas_equalTo(_sectionLabel3.mas_centerY);
            make.width.mas_equalTo(@(3));
        }];
        
        
    }
    return self;
}

@end
