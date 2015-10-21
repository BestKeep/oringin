//
//  CashDeskBasicInfoCell.m
//  BESTKEEP
//
//  Created by dcj on 15/8/25.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "CashDeskBasicInfoCell.h"

@interface CashDeskBasicInfoCell ()

@property (nonatomic,strong) UIView * containView;
@property (nonatomic,strong) UILabel * totalAcountLabel;
@property (nonatomic,strong) UILabel * totalMoneyLabel;


@end


@implementation CashDeskBasicInfoCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    UIView * tempContainView = [[UIView alloc] initWithFrame:CGRectZero];
    tempContainView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:tempContainView];
    [tempContainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    UILabel * totalCountlabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.totalAcountLabel = totalCountlabel;
    totalCountlabel.font = [UIFont boldSystemFontOfSize:16];
    totalCountlabel.textColor  = [UIColor colorWithString:@"#5F646E"];
    totalCountlabel.text = @"共计4笔订单";
    [tempContainView addSubview:totalCountlabel];
    [totalCountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tempContainView.mas_left).mas_offset(15);
        make.top.equalTo(tempContainView.mas_top).mas_offset(10);
    }];
    
    UILabel * unitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    unitLabel.text = @"元";
    unitLabel.textColor = [UIColor colorWithString:@"#5F646E"];
    unitLabel.font = [UIFont boldSystemFontOfSize:13];
    [tempContainView addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tempContainView.mas_right).mas_offset(-15);
        make.bottom.equalTo(totalCountlabel.mas_bottom);
    }];
    
    UILabel * moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.totalMoneyLabel = moneyLabel;
    moneyLabel.textColor = [UIColor colorWithString:@"#FF6600"];
    moneyLabel.text = @"195.00";
    moneyLabel.font = [UIFont boldSystemFontOfSize:15];
    [tempContainView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(unitLabel.mas_left).mas_offset(2);
        make.centerY.equalTo(totalCountlabel.mas_centerY);
    }];
    
}


-(void)updateCellWithOrderCount:(NSString *)orderCount andTotalMoney:(NSString *)totalMoney{

    self.totalAcountLabel.text = [NSString stringWithFormat:@"共计%@笔订单",orderCount];
    self.totalMoneyLabel.text = totalMoney;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
