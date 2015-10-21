//
//  AddEditCell.m
//  BESTKEEP
//
//  Created by cunny on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AddEditCell.h"

@implementation AddEditCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.messageLabel = [[BTLabel alloc]initWithFrame:CGRectZero];
        self.messageLabel.verticalAlignment = BTVerticalAlignmentTop;
        self.messageLabel.textAlignment = NSTextAlignmentLeft;
        self.messageLabel.textColor = COLOR_05;
        self.messageLabel.font = [UIFont boldSystemFontOfSize:16];
        self.messageLabel.numberOfLines = 0;
        
        [self.contentView addSubview:self.messageLabel];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).mas_offset(15);
            make.top.equalTo(self.contentView.mas_top).mas_offset(15);
            make.width.equalTo(@(95));
           
        }];
        self.messageText = [[UITextField alloc]initWithFrame:CGRectZero];
        self.messageText.textAlignment = NSTextAlignmentRight;
        self.messageText.textColor = COLOR_05;
        self.messageText.font = [UIFont boldSystemFontOfSize:16];
        
        [self.contentView addSubview:self.messageText];
        [self.messageText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).mas_offset(-15);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.messageLabel.mas_right);
        }];
        
        
        
        
    }
    return self;
}
@end
