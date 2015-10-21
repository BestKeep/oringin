//
//  TOP_CollectionViewCell.m
//  UTOUU_TEST
//
//  Created by UTOUU on 15/9/7.
//  Copyright (c) 2015年 UTOUU. All rights reserved.
//

#import "TOP_CollectionViewCell.h"
#import "Masonry.h"
//#import "UIImageView+WebCache.h"
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
@implementation TOP_CollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _TOP_imageView = [[UIImageView alloc] init];
        _TOP_imageView.backgroundColor = [UIColor whiteColor];
        _TOP_imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_TOP_imageView];
        
        _state_imageView = [[UIImageView alloc] init];
        _state_imageView.backgroundColor = [UIColor clearColor];
        _state_imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_state_imageView];
        
        _TOP_label1 = [UILabel new];
        [_TOP_label1 setText:@"---"];
        [_TOP_label1 setFont:[UIFont boldSystemFontOfSize:15.0]];
        [_TOP_label1 setBackgroundColor:[UIColor whiteColor]];
        [_TOP_label1 setTextColor:RgbColor(0, 0, 0)];
        [self.contentView addSubview:_TOP_label1];
        
        _TOP_label2 = [UILabel new];
        [_TOP_label2 setText:@"---"];
        [_TOP_label2 setFont:[UIFont boldSystemFontOfSize:13.0]];
        [_TOP_label2 setBackgroundColor:[UIColor whiteColor]];
        [_TOP_label2 setTextColor:RgbColor(153, 153, 153)];
        [self.contentView addSubview:_TOP_label2];
        
        
        [_TOP_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.top.mas_equalTo(self.contentView.mas_top);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-50);
        }];

        [_TOP_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.top.mas_equalTo(_TOP_imageView.mas_bottom).offset(4);
        }];
        
        [_TOP_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-4);
        }];
        
        [_state_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(0);
            make.right.mas_equalTo(self.contentView.mas_right).offset(0);
            make.width.mas_equalTo(@(50));
            make.height.mas_equalTo(@(50));

            //make.width.mas_equalTo(self.contentView.mas_bottom).offset(-4);
        }];

        
    }
    return self;
}

@end
