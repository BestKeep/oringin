//
//  cellDetailCell.m
//  BESTKEEP
//
//  Created by UTOUU on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "cellDetailView.h"
#import "Masonry.h"

//#define CELLHIEGHT  80
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
//#define KCELLWIDTH  88
#define KCELLHIEGITH  104

@implementation cellDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RgbColor(244, 244, 244);
        self.userInteractionEnabled = YES;
        
        _label1 = [UILabel new];
        [_label1 setText:@"----"];
        _label1.numberOfLines = 0;
        [_label1 setFont:[UIFont systemFontOfSize:13.0]];
        [_label1 setTextColor:COLOR_10];
        [self addSubview:_label1];
        
        _colorLabel = [UILabel new];
        [_colorLabel setText:@""];
        [_colorLabel setFont:[UIFont systemFontOfSize:11.0]];
        _colorLabel.numberOfLines = 2;
        [_colorLabel setTextColor:COLOR_05];
        [self addSubview:_colorLabel];
        
//        _sizeLabel = [UILabel new];
//        [_sizeLabel setText:@""];
//        [_sizeLabel setFont:[UIFont systemFontOfSize:13.0]];
//        [_sizeLabel setTextColor:[UIColor grayColor]];
//        [self addSubview:_sizeLabel];
        
        
        _label2 = [UILabel new];
        [_label2 setText:@"会员价:"];
        [_label2 setTextColor:COLOR_07];
        [_label2 setFont:[UIFont systemFontOfSize:11.0]];
        [self addSubview:_label2];
        
        _label3 = [UILabel new];
        [_label3 setText:@"￥--"];
        [_label3 setTextAlignment:NSTextAlignmentLeft];
        [_label3 setTextColor:COLOR_06];
        [_label3 setFont:[UIFont systemFontOfSize:11.0]];
        [self addSubview:_label3];
        
        _label4 = [UILabel new];
        [_label4 setText:@"糖赋:"];
        [_label4 setTextColor:COLOR_07];
        [_label4 setFont:[UIFont systemFontOfSize:11.0]];
        [self addSubview:_label4];
        
        _label5 = [UILabel new];
        [_label5 setText:@"￥--"];
        [_label5 setTextAlignment:NSTextAlignmentLeft];
        [_label5 setTextColor:COLOR_06];
        [_label5 setFont:[UIFont systemFontOfSize:11.0]];
        [self addSubview:_label5];
        
        _label6 = [UILabel new];
        [_label6 setText:@"--"];
        [_label6 setTextColor:[UIColor blackColor]];
        [_label6 setFont:[UIFont systemFontOfSize:12.0]];
        [_label6 setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_label6];
        
        [_label1 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.top.mas_equalTo(self.mas_top);
        }];
        _label1.numberOfLines = 2;
        
        [_colorLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.top.mas_equalTo(_label1.mas_bottom).offset(5);
        }];
        
//        [_sizeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [_sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(_colorLabel.mas_right);
//            make.top.mas_equalTo(_label1.mas_bottom).offset(5);
//        }];
////        
        [_label4 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
//
        [_label5 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_label5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_label4.mas_right);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
//
//        
        [_label2 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.bottom.mas_equalTo(_label4.mas_top).offset(-2);
        }];
//
        [_label3 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_label2.mas_right);
            make.bottom.mas_equalTo(_label5.mas_top).offset(-2);
        }];
//
        [_label6 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_label6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-12);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
    }
    return self;
}
@end

