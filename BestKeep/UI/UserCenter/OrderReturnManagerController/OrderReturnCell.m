//
//  OrderReturnCell.m
//  BESTKEEP
//
//  Created by dcj on 15/8/21.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "OrderReturnCell.h"
#import "UIColor+CJCategory.h"
#import "UIView+Position.h"

@interface OrderReturnCell ()

@property (nonatomic,strong) UILabel * OrderNameLabel;
@property (nonatomic,strong) UILabel * orderStatuLabel;
@property (nonatomic,strong) UILabel * refundMoneyLabel;
@property (nonatomic,strong) UILabel * dueDateLabel;
@property (nonatomic,strong) UILabel * dueTimeLabel;


@property (nonatomic,strong) UILabel * refundLabel;
@property (nonatomic,strong) UILabel * dueLabel;
@property (nonatomic,strong) UILabel * goLabel;

@property (nonatomic,strong) UIView * backView;





@end

@implementation OrderReturnCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.width, 100);
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self commonInit];
        [self layoutCellSubView];
        self.contentView.backgroundColor = [UIColor colorWithString:@"#ffffff"];
    }
    return self;
}

- (void)awakeFromNib {
}

-(void)updateDataWithModel:(id)model{
    self.OrderNameLabel.text = @"《有米》东北五常稻花香";
    self.orderStatuLabel.text = @"退货成功";
    self.refundMoneyLabel.text = @"208";
    self.dueDateLabel.text = @"2015-08-14";
    self.dueTimeLabel.text = @"12:20:12";
}

-(void)layoutCellSubView{
    [self.OrderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).mas_offset(15);
        make.top.equalTo(self.backView.mas_top);
        make.height.equalTo(@(36));
    }];
    
    [self.orderStatuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).mas_offset(-15);
        make.centerY.equalTo(self.OrderNameLabel.mas_centerY);
    }];
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = [UIColor colorWithString:@"#999999"];
    [self.backView addSubview:lineView];
    lineView.alpha = 0.15;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.OrderNameLabel.mas_left);
        make.right.equalTo(self.backView.mas_right);
        make.top.equalTo(self.OrderNameLabel.mas_bottom);
        make.height.equalTo(@(1));
    }];
    
    [self.refundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.OrderNameLabel.mas_left);
        make.top.equalTo(self.OrderNameLabel.mas_bottom).mas_offset(10);
    }];
    
    [self.refundMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.refundLabel.mas_right).mas_offset(15);
        make.centerY.equalTo(self.refundLabel.mas_centerY);
    }];
    
    [self.dueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.OrderNameLabel.mas_left);
        make.top.equalTo(self.refundLabel.mas_bottom).mas_offset(10);
    }];
    
    [self.dueDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dueLabel.mas_right).mas_offset(20);
        make.centerY.equalTo(self.dueLabel.mas_centerY);
    }];
    
    [self.dueTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dueDateLabel.mas_right).mas_offset(20);
        make.centerY.equalTo(self.dueDateLabel.mas_centerY);
    }];
    
    [self.goLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).mas_offset(-15);
        make.centerY.equalTo(self.dueTimeLabel.mas_centerY);
    }];
}

-(void)commonInit{
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor colorWithString:@"#ffffff"];
    [self.contentView addSubview:backView];
    self.backView = backView;
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top).mas_offset(5);
//        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@(90));
    }];
    
    UILabel * tempOrderNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempOrderNameLabel.textColor = [UIColor colorWithString:@"#5F646E"];
    tempOrderNameLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.backView addSubview:tempOrderNameLabel];
    self.OrderNameLabel = tempOrderNameLabel;
    
    UILabel * tempOrderStatuLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempOrderStatuLabel.textColor = [UIColor colorWithString:@"#999999"];
    tempOrderStatuLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.backView addSubview:tempOrderStatuLabel];
    self.orderStatuLabel = tempOrderStatuLabel;
    
    UILabel * tempRefundMoneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempRefundMoneyLabel.textColor = [UIColor colorWithString:@"#FF6600"];
    tempRefundMoneyLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.backView addSubview:tempRefundMoneyLabel];
    self.refundMoneyLabel = tempRefundMoneyLabel;
    
    UILabel * tempDueDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempDueDateLabel.textColor = [UIColor colorWithString:@"#999999"];
    tempDueDateLabel.font = [UIFont boldSystemFontOfSize:11];
    [self.backView addSubview:tempDueDateLabel];
    self.dueDateLabel = tempDueDateLabel;
    
    UILabel * tempDueTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempDueTimeLabel.textColor = [UIColor colorWithString:@"#999999"];
    tempDueTimeLabel.font =[UIFont boldSystemFontOfSize:11];
    [self.backView addSubview:tempDueTimeLabel];
    self.dueTimeLabel = tempDueTimeLabel;
    
    self.goLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.goLabel.textColor = [UIColor colorWithString:@"#999999"];
    self.goLabel.font=[UIFont fontWithName:@"iconfont" size:11];
    self.goLabel.text = @"\U0000e610";
    [self.backView addSubview:self.goLabel];
    
    self.refundLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.refundLabel.textColor = [UIColor colorWithString:@"#999999"];
    self.refundLabel.font = [UIFont boldSystemFontOfSize:11];
    self.refundLabel.text = @"退款金额";
    [self.backView addSubview:self.refundLabel];
    
    self.dueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.dueLabel.textColor = [UIColor colorWithString:@"#999999"];
    self.dueLabel.font = [UIFont boldSystemFontOfSize:11];
    self.dueLabel.text = @"处理时间";
    [self.backView addSubview:self.dueLabel];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
