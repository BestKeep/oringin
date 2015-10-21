//
//  BuyCarSectionView.m
//  BESTKEEP
//
//  Created by UTOUU on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BuyCarSectionView.h"
#import "Masonry.h"


#define SECTIONFOOTER 60

@implementation BuyCarSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        
        _sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sectionButton setBackgroundColor:[UIColor whiteColor]];
        [_sectionButton setBackgroundImage:[UIImage imageNamed:@"select_image.png"] forState:UIControlStateSelected];
        [_sectionButton setBackgroundImage:[UIImage imageNamed:@"unselect_image.png"] forState:UIControlStateNormal];
        _sectionButton.layer.cornerRadius = 10;
        _sectionButton.layer.masksToBounds = YES;
        _sectionButton.layer.borderColor = COLOR_11.CGColor;
        _sectionButton.layer.borderWidth = 1;
        
        [_sectionButton addTarget:self action:@selector(sectionBUttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sectionButton];
        
        _sectionLabel = [UILabel new];
        [_sectionLabel setText:@"----"];
        [_sectionLabel setTextColor:[UIColor blackColor]];
        [_sectionLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_sectionLabel];
        
        _sectionImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _sectionImageView.layer.cornerRadius = 5.0;
//        _sectionImageView.layer.masksToBounds = YES;
        _sectionImageView.image = [UIImage imageNamed:@"全球购.png"];
        [self addSubview:_sectionImageView];
        
        
        _sectionEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sectionEdit setTitle:@"编辑" forState:UIControlStateNormal];
        [_sectionEdit setTitle:@"完成" forState:UIControlStateSelected];
        [_sectionEdit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sectionEdit addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sectionEdit];
        
        
        _sectionLine = [UILabel new];
        [_sectionLine setBackgroundColor:[UIColor grayColor]];
        _sectionLine.alpha = 0.3;
        [self addSubview:_sectionLine];
        
        [_sectionButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_sectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(12);
            make.width.mas_equalTo(@(20));
            make.top.mas_equalTo(self.mas_top).offset(11);
            make.height.mas_equalTo(@(20));
        }];
        
        [_sectionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_sectionButton.mas_right).offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [_sectionImageView setTranslatesAutoresizingMaskIntoConstraints:NO]; // 全球购
        [_sectionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_sectionLabel.mas_right).offset(4);
            make.width.mas_equalTo(@(38));
            make.height.mas_equalTo(@(12));
            make.centerY.mas_equalTo(self.mas_centerY).offset(0);
        }];
        
        [_sectionEdit setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_sectionEdit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-12);
            make.width.mas_equalTo(@(46));
            make.top.mas_equalTo(self.mas_top).offset(15);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-15);
        }];
        
        [_sectionLine setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_sectionLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_sectionEdit.mas_left).offset(-11);
            make.width.mas_equalTo(@(1));
            make.top.mas_equalTo(self.mas_top).offset(13);
            make.height.mas_equalTo(@(20));
        }];
        
        
    }
    return self;
}

-(void)sectionBUttonClick:(UIButton *)sectionButton{
    sectionButton.selected = !sectionButton.selected;
    
    if ([self.sectionDelegate respondsToSelector:@selector(sectionView:sectionButtonClick:)]) {
        [self.sectionDelegate sectionView:self sectionButtonClick:sectionButton];
    }
    
}
-(void)editButtonClick:(UIButton *)editButton{
    editButton.selected = !editButton.selected;
    
    if (editButton.selected == YES) {
        [editButton setTitle:@"完成" forState:UIControlStateSelected];
        
    }else{
        [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
    if ([self.sectionDelegate respondsToSelector:@selector(sectionView:editButtonClick:)]) {
        [self.sectionDelegate sectionView:self editButtonClick:editButton];
    }
}




@end
