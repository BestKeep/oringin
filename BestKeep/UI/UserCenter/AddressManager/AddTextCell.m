//
//  AddTextCell.m
//  BESTKEEP
//
//  Created by cunny on 15/8/27.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AddTextCell.h"

@implementation AddTextCell

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
        self.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
        self.messageLabel = [[BTLabel alloc]initWithFrame:CGRectZero];
        self.messageLabel.verticalAlignment = BTVerticalAlignmentTop;
        self.messageLabel.textAlignment = NSTextAlignmentLeft;
        self.messageLabel.textColor = [UIColor colorWithString:@"#999999"];
        self.messageLabel.font = [UIFont boldSystemFontOfSize:14];
        self.messageLabel.numberOfLines = 0;
        
        [self.contentView addSubview:self.messageLabel];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).mas_offset(15);
            make.right.equalTo(self.contentView.mas_right);
            make.top.equalTo(self.contentView.mas_top).mas_offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}
@end
