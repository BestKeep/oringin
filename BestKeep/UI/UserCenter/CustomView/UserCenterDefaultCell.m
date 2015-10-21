//
//  UserCenterDefaultCell.m
//  BESTKEEP
//
//  Created by dcj on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "UserCenterDefaultCell.h"
#import "UIColor+CJCategory.h"
#import "StrokeViewManager.h"
#import "UIView+Position.h"
#import "UserCenterViewController.h"


@interface UserCenterDefaultCell ()

//@property (nonatomic,strong) UIView * containView;
@property (nonatomic,strong) StrokeView * strokeView;
@property (nonatomic,strong) UserCenterViewController *uservc;

@end

@implementation UserCenterDefaultCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bcLeftTextlabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.bcLeftTextlabel];
        self.bcLeftTextlabel.font = [UIFont boldSystemFontOfSize:16];
        
        self.bcRightTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.bcRightTextLabel];
        
        self.bcArrowImageView = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.bcArrowImageView];
        
        
        [self.bcLeftTextlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).mas_offset(15);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.bcArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).mas_offset(-15);
            make.centerY.equalTo(self.contentView.mas_centerY);
    
        }];
        
        [self.bcRightTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bcArrowImageView.mas_left).mas_offset(-5);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
//        StrokeView * strokeView = [StrokeViewManager showStrokeView:self.contentView text:3 textColor:[UIColor whiteColor]];
//        self.strokeView = strokeView;
//    [strokeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.bcLeftTextlabel.mas_right);
//        make.centerY.equalTo(self.bcLeftTextlabel.mas_top).mas_offset(-5);
//    }];
        
        self.showStrokeView = NO;
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectZero];
       
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = COLOR_03;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.height.equalTo(@(1));
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        self.bcLeftTextlabel.textColor = [UIColor colorWithString:@"#5f646e"];
        self.bcRightTextLabel.textColor = [UIColor colorWithString:@"#999999"];
        self.bcRightTextLabel.font = [UIFont boldSystemFontOfSize:13];
        self.bcArrowImageView.textColor = [UIColor colorWithString:@"#aaaaaa"];
        self.bcArrowImageView.font=[UIFont fontWithName:@"iconfont" size:13];
        self.bcArrowImageView.text = @"\U0000e610";
        
        
    }
    return self;
}

-(void)setHideArrowImage:(BOOL)hideArrowImage{
    _hideArrowImage = hideArrowImage;
    if (_hideArrowImage) {
        self.bcArrowImageView.text = nil;
        self.bcArrowImageView.width = 0;
    }else{
        self.bcArrowImageView.text = @"\U0000e610";
    }

}
-(void)setShowStrokeView:(BOOL)showStrokeView{
    _showStrokeView = showStrokeView;
    self.strokeView.hidden = !showStrokeView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    

}



@end
