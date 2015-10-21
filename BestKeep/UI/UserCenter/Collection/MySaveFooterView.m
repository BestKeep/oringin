//
//  MySaveFooterView.m
//  BESTKEEP
//
//  Created by UTOUU on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "MySaveFooterView.h"
#import "Masonry.h"

#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@implementation MySaveFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除(0)" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:RgbColor(2, 162, 123) forState:UIControlStateNormal];
        _deleteBtn.layer.borderWidth = 1.0;
        _deleteBtn.layer.borderColor = RgbColor(2, 162, 123).CGColor;
        _deleteBtn.layer.cornerRadius = 8.0;
        [_deleteBtn setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_deleteBtn];
        
        
        [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(@(100));
            make.right.mas_equalTo(self.mas_right).offset(-15);
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        }];
    }
    return self;
}

@end
