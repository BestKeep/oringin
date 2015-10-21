//  cellDataView.m
//  BESTKEEP
//
//  Created by UTOUU on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "cellDataView.h"
#import "Masonry.h"
#import "ShoppingCarList.h"
#define DATAVIEWHIEGHT 80
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define KCELLWIDTH  88
#define KCELLHIEGITH  88

@implementation cellDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RgbColor(244, 244, 244);
        self.userInteractionEnabled = YES;
        
        
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setTitle:@"-" forState:UIControlStateNormal];
        [_button2.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        _button1.layer.borderWidth = 0.5;
        [_button1.titleLabel setTextAlignment:NSTextAlignmentCenter];
        //        _button1.layer.borderColor = [UIColor grayColor].CGColor;
        [self addSubview:_button1];
        
        [_button1 addTarget:self action:@selector(buttonClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _label1 = [UILabel new];
        [_label1 setText:@"--"];
        [_label1 setFont:[UIFont systemFontOfSize:15.0]];
        [_label1 setTextAlignment:NSTextAlignmentCenter];
        [_label1 setTextColor:[UIColor blackColor]];
        [self addSubview:_label1];
        
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:@"+" forState:UIControlStateNormal];
        [_button2.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        _button2.layer.borderWidth = 0.5;
        [_button2.titleLabel setTextAlignment:NSTextAlignmentCenter];
        //        _button2.layer.borderColor = [UIColor grayColor].CGColor;
        [self addSubview:_button2];
        [_button2 addTarget:self action:@selector(buttonClickWithButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _line1 = [UILabel new];
        _line1.backgroundColor = [UIColor grayColor];
        _line1.alpha = 0.4;
        [self addSubview:_line1];
        
        _line2 = [UILabel new];
        _line2.backgroundColor = [UIColor grayColor];
        _line2.alpha = 0.4;
        [self addSubview:_line2];
        
        _line3 = [UILabel new];
        _line3.backgroundColor = [UIColor grayColor];
        _line3.alpha = 0.4;
        [self addSubview:_line3];
        
        _label2 = [UILabel new];
        [_label2 setText:@""];
        [_label2 setFont:[UIFont systemFontOfSize:13.0]];
        [_label2 setTextColor:[UIColor blackColor]];
        [self addSubview:_label2];
        
//        _label3 = [UILabel new];
//        [_label3 setText:@""];
//        [_label3 setFont:[UIFont systemFontOfSize:13.0]];
//        [_label3 setTextColor:[UIColor blackColor]];
//        [self addSubview:_label3];
        
        //        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [_button3 setTitle:@"删除 " forState:UIControlStateNormal];
        //        [_button3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //        [self addSubview:_button3];
        
        
        [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top).offset(45);
            make.height.mas_equalTo(@(1));
        }];
        
        [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(70);
            make.width.mas_equalTo(@(1));
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(_line3.mas_top);
        }];
        
        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-70);
            make.width.mas_equalTo(@(1));
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(_line3.mas_top);
        }];
        
        [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(_line1.mas_left);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(_line3.mas_top);
        }];
        
        
        [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_line1.mas_right);
            make.right.mas_equalTo(_line2.mas_left);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(_line3.mas_top);
        }];
        
        [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_line2.mas_right);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(_line3.mas_top);
        }];
        
        [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
            //            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
//        [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(_label2.mas_right).offset(10);
//            //            make.width.mas_equalTo(_label2.mas_width);
//            make.top.mas_equalTo(_line3.mas_bottom).offset(10);
//            //            make.bottom.mas_equalTo(self.mas_bottom);
//        }];
    }
    return self;
}




-(void)buttonClickWithButton:(UIButton *)sender{
    if (sender == self.button2) {
        if ([self.dataViewDelegate respondsToSelector:@selector(cellDataView:addCount:)]) {
            [self.dataViewDelegate cellDataView:self addCount:sender];
        }
    }else if (sender == self.button1){
        if ([self.dataViewDelegate respondsToSelector:@selector(cellDataView:subCount:)]) {
            [self.dataViewDelegate cellDataView:self subCount:sender];
        }
    
    }else{
        if ([self.dataViewDelegate respondsToSelector:@selector(cellDataView:deletButtonClick:)]) {
            [self.dataViewDelegate cellDataView:self deletButtonClick:sender];
        }
    }
}



-(void)updateDataWithShoppingCarList:(ShoppingCarList *)orderModel{
    self.label1.text = orderModel.amount;
}













@end
