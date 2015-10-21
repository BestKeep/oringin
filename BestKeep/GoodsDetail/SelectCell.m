//
//  SelectCell.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/10/17.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "SelectCell.h"

@implementation SelectCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH,0.1);
        self.backgroundColor = [UIColor whiteColor];
        
        _selectLabel = [UILabel new];
        _selectLabel.backgroundColor = [UIColor whiteColor];
        _selectLabel.textColor = [UIColor grayColor];
        _selectLabel.textAlignment = NSTextAlignmentLeft;
        _selectLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_selectLabel];
        
        self.bcArrowImageView = [[UILabel alloc] initWithFrame:CGRectZero];
        self.bcArrowImageView.textColor = [UIColor colorWithString:@"#aaaaaa"];
        self.bcArrowImageView.font=[UIFont fontWithName:@"iconfont" size:13];
        self.bcArrowImageView.text = @"\U0000e610";
        [self.contentView addSubview:self.bcArrowImageView];

        [self.bcArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).mas_offset(-15);
            make.centerY.equalTo(self.contentView.mas_centerY);
            
        }];
        [_selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(15);
            make.top.mas_equalTo(self.mas_top).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).offset(0);
            make.width.mas_equalTo(@(SCREEN_WIDTH -30));
        }];
        
        
        
    }
    return self;
}

@end


