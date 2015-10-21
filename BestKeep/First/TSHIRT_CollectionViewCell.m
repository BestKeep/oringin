//
//  TSHIRT_CollectionViewCell.m
//  UTOUU_TEST
//
//  Created by UTOUU on 15/9/7.
//  Copyright (c) 2015年 UTOUU. All rights reserved.
//

#import "TSHIRT_CollectionViewCell.h"
#import "Masonry.h"
//#import "UIImageView+WebCache.h"
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
@implementation TSHIRT_CollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _TSHIRT_imageView = [[UIImageView alloc] init];
        _TSHIRT_imageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_TSHIRT_imageView];
        
        _TSHIRT_label = [UILabel new];
        [_TSHIRT_label setText:@"---"];
        [_TSHIRT_label setFont:[UIFont boldSystemFontOfSize:15.0]];
        [_TSHIRT_label setBackgroundColor:[UIColor whiteColor]];
        [_TSHIRT_label setTextColor:RgbColor(0, 0, 0)];
        [self.contentView addSubview:_TSHIRT_label];
        
        [_TSHIRT_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.top.mas_equalTo(self.contentView.mas_top);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-50);
        }];
        
        [_TSHIRT_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-4);
        }];
        
    }
    return self;
}

@end
