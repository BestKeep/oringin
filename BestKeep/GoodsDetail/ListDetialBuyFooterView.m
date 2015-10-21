//
//  ListDetialBuyFooterView.m
//  
//
//  Created by UTOUU on 15/9/25.
//
//

#import "ListDetialBuyFooterView.h"
#import "Masonry.h"
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)


@implementation ListDetialBuyFooterView  //弹出视图的商品展示尾部

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _line1 = [UILabel new];
        _line1.backgroundColor = [UIColor grayColor];
        _line1.alpha = 0.4;
        [self addSubview:_line1];
        
        _buyDataLabel = [UILabel new];
        _buyDataLabel.text = @"购买数量";
        [_buyDataLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
        _buyDataLabel.backgroundColor = [UIColor whiteColor];
        _buyDataLabel.textColor = [UIColor blackColor];
        [self addSubview:_buyDataLabel];
        
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.borderWidth = 0.5;
        _bgView.layer.borderColor = [UIColor grayColor].CGColor;
        _bgView.layer.cornerRadius = 5.0;
        _bgView.layer.masksToBounds = YES;
        [self addSubview:_bgView];
        
        _reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceBtn setTitle:@"-" forState:UIControlStateNormal];
        [_reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_reduceBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
//        _reduceBtn.layer.borderWidth = 0.5;
//        _reduceBtn.layer.borderColor = [UIColor grayColor].CGColor;
//        _reduceBtn.layer.cornerRadius = 5.0;
//        _reduceBtn.layer.masksToBounds = YES;
        [_bgView addSubview:_reduceBtn];
        
        _dataLabel = [UILabel new];
        _dataLabel.text = @"1";
        _dataLabel.textColor = [UIColor blackColor];
        [_dataLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
        _dataLabel.layer.borderWidth = 0.5;
        _dataLabel.textAlignment = NSTextAlignmentCenter;
        _dataLabel.layer.borderColor = [UIColor grayColor].CGColor;
        [_bgView addSubview:_dataLabel];
        
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_addBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
//        _addBtn.layer.borderWidth = 0.5;
//        _addBtn.layer.borderColor = [UIColor grayColor].CGColor;
//        _addBtn.layer.cornerRadius = 5.0;
//        _addBtn.layer.masksToBounds = YES;
        [_bgView addSubview:_addBtn];
        

        
        [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(@(0.5));
            make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        }];
        
        [_buyDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.centerY.mas_equalTo(self.mas_centerY).offset(0);
        }];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(@(40));
            make.width.mas_equalTo(@(120));
        }];
        
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_bgView.mas_right).offset(0);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(@(40));
            make.width.mas_equalTo(@(40));
        }];
        
        [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_addBtn.mas_left).offset(0);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(@(40));
            make.width.mas_equalTo(@(40));
            
        }];
        
        [_reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_dataLabel.mas_left).offset(0
                                                               );
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(@(40));
            make.width.mas_equalTo(@(40));
        }];
        
    }
    return self;
}

@end
