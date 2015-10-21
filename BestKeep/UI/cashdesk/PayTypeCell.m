//
//  PayTypeCell.m
//  BESTKEEP
//
//  Created by dcj on 15/8/25.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "PayTypeCell.h"
#import "UIColor+CJCategory.h"
#import "UIView+Position.h"
@interface PayTypeCell ()

@property (nonatomic,strong) UIView * containView;
@property (nonatomic,strong) UILabel * selectedButton;
@property (nonatomic,strong) PayMoneyLabel * payMoney;
@property (nonatomic,strong) UILabel * acountName;
@property (nonatomic,strong) UILabel * balanceLabel;




@end

@implementation PayTypeCell


- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.height = 95;
        self.contentView.height = 95;
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    UIView * tempView = [[UIView alloc] initWithFrame:CGRectZero];
    tempView.backgroundColor  = [UIColor whiteColor];
    tempView.layer.borderWidth = 0.5;
    tempView.clipsToBounds = YES;
    tempView.layer.cornerRadius = 4;
    [self.contentView addSubview:tempView];
    self.containView = tempView;
    
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).mas_offset(10);
        make.right.equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(-10);
    }];
    
    UILabel * selectedButton =[UILabel new];
    [tempView addSubview:selectedButton];
    selectedButton.font = [UIFont fontWithName:@"iconFont" size:20];
    self.selectedButton = selectedButton;
    [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tempView.mas_top).mas_offset(14);
        make.left.equalTo(tempView.mas_left).mas_offset(10);
    }];
    
    UILabel * personalAccountLabel = [UILabel new];
    [tempView addSubview:personalAccountLabel];
    self.acountName = personalAccountLabel;
    personalAccountLabel.text = @"有糖个人账户";
    personalAccountLabel.textColor = [UIColor colorWithString:@"#5F646E"];
    personalAccountLabel.font = [UIFont boldSystemFontOfSize:15];
    
    [personalAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectedButton.mas_right).mas_offset(8);
        make.centerY.equalTo(selectedButton.mas_centerY);
    }];
    
    UILabel * rightLabel = [UILabel new];
    [tempView addSubview:rightLabel];
    rightLabel.font = [UIFont boldSystemFontOfSize:14];
    rightLabel.text = @"查看限额";
    rightLabel.textColor = [UIColor colorWithString:@"#03b598"];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tempView.mas_right).mas_offset(-14);
        make.centerY.equalTo(personalAccountLabel.mas_centerY);
    }];
    
    UILabel * balanceLabel = [UILabel new];
    [tempView addSubview:balanceLabel];
    balanceLabel.text = @"余额: 12345.00元";
    self.balanceLabel = balanceLabel;
    
    balanceLabel.font = [UIFont boldSystemFontOfSize:13];
    balanceLabel.textColor = [UIColor colorWithString:@"#5F646E"];
    [balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personalAccountLabel.mas_bottom).mas_offset(12);
        make.left.equalTo(personalAccountLabel.mas_left);
    }];
    
    
    
    PayMoneyLabel * payMoneyLabel = [[PayMoneyLabel alloc] initWithFrame:CGRectZero];
    [tempView addSubview:payMoneyLabel];
    self.payMoney = payMoneyLabel;
    [payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tempView.mas_right).mas_offset(0);
        make.top.equalTo(balanceLabel.mas_bottom).mas_offset(0);
        make.width.equalTo(@(90));
        make.height.equalTo(@(17));
    }];
    //[payMoneyLabel updateMoneyWith:@"195.00"];
    
}


-(void)updateAccountInfoWithModel:(AccountInfoModel *)mdoel andMoney:(NSString *)totalMoney{
    [self.payMoney updateMoneyWith:totalMoney];
    if ([mdoel.account_type isEqualToString:@"001"]) {
        self.acountName.text = @"有糖个人账户";
    }else if ([mdoel.account_type isEqualToString:@"002"]){
        self.acountName.text = @"有糖申购金账户";
    }else{
        self.acountName.text = @"其他账户";
    }
    self.balanceLabel.text = [NSString stringWithFormat:@"余额: %@",mdoel.banlance];
}

-(void)updateSelectedStatusWith:(BOOL)selected{
    if (selected) {
        self.selectedButton.textColor = [UIColor colorWithString:@"#03b598"];
        self.selectedButton.text = @"\U0000e603";
        self.containView.layer.borderColor = [UIColor colorWithString:@"#03b598"].CGColor;
    }else{
        self.selectedButton.textColor = [UIColor colorWithString:@"#999999"];
        self.selectedButton.text = @"\U0000e620";
        self.containView.layer.borderColor = [UIColor colorWithString:@"#999999"].CGColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self updateSelectedStatusWith:selected];
    // Configure the view for the selected state
}

@end


@interface PayMoneyLabel ()

@property (nonatomic,strong) UILabel * moneyLabel;

@end


@implementation PayMoneyLabel

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self commonInit];
        
    }
    return self;
}

-(void)commonInit{
    
    UILabel * unitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:unitLabel];
    unitLabel.textColor = [UIColor colorWithString:@"#5F646E"];
    unitLabel.font = [UIFont boldSystemFontOfSize:12];
    unitLabel.text = @"元";
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).mas_offset(-15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    UILabel * moenyLabel = [UILabel new];
    [self addSubview:moenyLabel];
    self.moneyLabel = moenyLabel;
    moenyLabel.textColor = [UIColor colorWithString:@"#FF6600"];
    moenyLabel.font = [UIFont boldSystemFontOfSize:14];
    [moenyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(unitLabel.mas_left).mas_offset(-5);
        make.centerY.equalTo(unitLabel.mas_centerY);
    }];

    
    UILabel * payLabel = [UILabel new];
    [self addSubview:payLabel];
    payLabel.text = @"支付";
    payLabel.textColor = [UIColor colorWithString:@"#5F646E"];
    payLabel.font = [UIFont boldSystemFontOfSize:13];
    [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moneyLabel.mas_left).mas_offset(-5);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
//      self.backgroundColor = [UIColor yellowColor];
}


-(void)updateMoneyWith:(NSString *)money{
    self.moneyLabel.text = money;
}

@end




