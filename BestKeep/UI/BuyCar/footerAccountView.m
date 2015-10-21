//
//  footerAccountView.m
//  BESTKEEP
//
//  Created by UTOUU on 15/8/21.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "footerAccountView.h"
#import "Masonry.h"

#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@implementation footerAccountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setBackgroundImage:[UIImage imageNamed:@"select_image.png"] forState:UIControlStateSelected];
        [_button1 setBackgroundImage:[UIImage imageNamed:@"unselect_image.png"] forState:UIControlStateNormal];
        _button1.layer.cornerRadius = 10;
        _button1.layer.borderWidth = 1.0;
        _button1.layer.borderColor = COLOR_11.CGColor;
        [self addSubview:_button1];
        
        [_button1 addTarget:self action:@selector(allSelectedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _label1 = [UILabel new];
        [_label1 setText:@"全选"];
        [_label1 setTextColor:[UIColor blackColor]];
        [_label1 setFont:[UIFont boldSystemFontOfSize:16.0]];
        [self addSubview:_label1];
        
        _label2 = [UILabel new];
        [_label2 setText:@"合计:"];
        [_label2 setFont:[UIFont systemFontOfSize:14.0]];
        [_label2 setTextAlignment:NSTextAlignmentRight];
        [_label2 setTextColor:[UIColor grayColor]];
        [self addSubview:_label2];
        
        _label3 = [UILabel new];
        [_label3 setText:@"￥0.00"];
        [_label3 setFont:[UIFont systemFontOfSize:14.0]];
        [_label3 setTextColor:[UIColor orangeColor]];
        [self addSubview:_label3];
        
        _label4 = [UILabel new];
        [_label4 setText:@"不含运费"];
        [_label4 setTextColor:[UIColor grayColor]];
        [_label4 setFont:[UIFont systemFontOfSize:14.0]];
        [self addSubview:_label4];
        
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setTitle:@"结算(0)" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button2 setBackgroundColor:RgbColor(23, 169, 134)];
        [self addSubview:_button2];
        [_button2 addTarget:self action:@selector(calculateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _moveSaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moveSaveButton setBackgroundColor:[UIColor grayColor]];
        [_moveSaveButton setTitle:@"移到收藏夹" forState:UIControlStateNormal];
        [_moveSaveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_moveSaveButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
        [self addSubview:_moveSaveButton];
        [_moveSaveButton addTarget:self action:@selector(moveToSaveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setBackgroundColor:RgbColor(23, 169, 134)];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
        [self addSubview:_deleteButton];
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.moveSaveButton.hidden = YES;
        self.deleteButton.hidden = YES;
        
        [_button1 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_equalTo(12);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [_label1 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_button1.mas_right).mas_offset(4);
            make.centerY.equalTo(_button1.mas_centerY);
        }];
        [_button2 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
            make.width.equalTo(@(104));
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
        [_label3 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_button2.mas_left).mas_offset(-10);
            make.top.equalTo(self.mas_top).mas_offset(5);
        }];
        [_label4 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_button2.mas_left).mas_offset(-10);
            make.bottom.equalTo(self.mas_bottom).mas_offset(-4);
        }];
        
        [_label2 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_label3.mas_left).mas_offset(-10);
            make.top.equalTo(self.mas_top).mas_offset(5);
        }];
        
        [_moveSaveButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_moveSaveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(140);
            make.width.equalTo(@(119));
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [_deleteButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_moveSaveButton.mas_right);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return self;
}

-(void)allSelectedButtonClicked:(UIButton *)allSelectedButton{
    allSelectedButton.selected = !allSelectedButton.selected;
    if ([self.footerDelegate respondsToSelector:@selector(footerAccountView:allSelectedButtonClicked:)]) {
        [self.footerDelegate footerAccountView:self allSelectedButtonClicked:allSelectedButton];
    }
}
-(void)moveToSaveButtonClicked:(UIButton *)moveToSaveButgton{
    if ([self.footerDelegate respondsToSelector:@selector(footerAccountView:moveToSaveButtonClicked:)]) {
        [self.footerDelegate footerAccountView:self moveToSaveButtonClicked:moveToSaveButgton];
    }
}
-(void)deleteButtonClicked:(UIButton *)deleteButton{
    if ([self.footerDelegate respondsToSelector:@selector(footerAccountView:deleteButtonClicked:)]) {
        [self.footerDelegate footerAccountView:self deleteButtonClicked:deleteButton];
    }
}
-(void)calculateButtonClicked:(UIButton *)calculateButton{
    if ([self.footerDelegate respondsToSelector:@selector(footerAccountView:calculateButtonClicked:)]) {
        [self.footerDelegate footerAccountView:self calculateButtonClicked:calculateButton];
    }
}


//如果有编辑状态 则footview 就设置为编辑状态
-(void)updateFooterAccountView:(BOOL)isEdit{
    self.moveSaveButton.hidden = !isEdit;
    self.deleteButton.hidden = !isEdit;
    self.label2.hidden = isEdit;
    self.label3.hidden = isEdit;
    self.label4.hidden = isEdit;

}

-(void)updateAllSelectedButtonSelected:(BOOL)isAllSelected{
    self.button1.selected = isAllSelected;
//    [self updateFooterAccountView:isAllSelected];
}
@end