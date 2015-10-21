//
//  HLCell.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "HLCell.h"

@interface HLCell ()

@property (nonatomic,strong) UILabel * taxLabel;
@property (nonatomic,strong) UILabel * taxMoneyLabel;


@end

@implementation HLCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self loadSubView];
    }
    return self;
}

-(void)loadSubView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.label1 = [UILabel new];
    self.label2 = [UILabel new];
    self.label3 = [UILabel new];
    self.label4 = [UILabel new];
    self.label5 = [UILabel new];
    self.taxLabel = [[UILabel alloc] init];
    self.taxMoneyLabel = [[UILabel alloc] init];
    
    [self initLabel:self.label1 FontSize:12 Color:COLOR_07];
    [self initLabel:self.label2 FontSize:12 Color:COLOR_07];
    [self initLabel:self.label3 FontSize:12 Color:COLOR_07];
    [self initLabel:self.label4 FontSize:12 Color:COLOR_06];
    [self initLabel:self.label5 FontSize:12 Color:COLOR_07];
    [self initLabel:self.taxLabel FontSize:12 Color:COLOR_07];
    [self initLabel:self.taxMoneyLabel FontSize:12 Color:COLOR_06];
    
    //        self.label1.backgroundColor = [UIColor yellowColor];
    //        self.label2.backgroundColor = [UIColor redColor];
    //        self.label3.backgroundColor = [UIColor greenColor];
    //        self.label4.backgroundColor = [UIColor lightGrayColor];
    //        self.label5.backgroundColor = [UIColor cyanColor];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    [self.contentView addSubview:self.lineView];
    
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).mas_offset(15);
        make.top.equalTo(self.contentView.mas_top).mas_offset(8);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1.mas_right).mas_offset(5);
        make.centerY.equalTo(self.label1.mas_centerY);
    }];
    
    [self.taxMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).mas_offset(-15);
        make.top.equalTo(self.label1.mas_top);
    }];
    
    [self.taxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.taxMoneyLabel.mas_left).mas_offset(-2);
        make.top.equalTo(self.taxMoneyLabel.mas_top);
    }];
    
    [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).mas_offset(-15);
        make.centerY.equalTo(self.label4.mas_centerY);
    }];
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.label5.mas_left).mas_offset(-2);
        make.top.equalTo(self.taxMoneyLabel.mas_bottom).mas_offset(5);
    }];
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.label4.mas_left).mas_offset(-5);
        make.centerY.equalTo(self.label4.mas_centerY);
    }];
}


-(void)initLabel:(UILabel*)textLabel  FontSize:(CGFloat)size Color:(UIColor*)color {
    textLabel.font = [UIFont boldSystemFontOfSize:size];
    textLabel.numberOfLines = 0;
    textLabel.textColor = color;
    [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:textLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)setOrderInfo:(OrderInfo *)orderInfo{
    _orderInfo = orderInfo;
    [self updateCellContains];
    [self updateData];
    

}


//-(void)updateDataWithModel1:(OrderModel1 *)model1 orderModel2:(OrderModel2 *)model2{
//    //    [self updateCellContains];
//
//    self.lineView.backgroundColor = COLOR_08;
//    //    self.label5.text = @"元";
//    self.label1.text = @"运费: ";
//    self.label3.text = @"合计: ";
//    self.label2.text = [NSString stringWithFormat:@"¥%@",model1.express_amount];
//    NSInteger amount = [model1.express_amount integerValue] + [model2.total_amount integerValue];
//    self.label4.text = [NSString stringWithFormat:@"¥%lu",amount];
//    if ([self.model isGlobal]) {
//        if ([self.model.customs_tax_amount_total integerValue]>0) {
//            self.taxMoneyLabel.text = [NSString stringWithFormat:@"¥%@(≤50免征)",self.model.customs_tax_amount_total];
//            self.taxLabel.text = @"关税: ";
//        }
//    }
//
//}
//
-(void)updateData{

    self.lineView.backgroundColor = COLOR_08;
//    self.label5.text = @"元";
    self.label1.text = @"运费: ";
    self.label3.text = @"合计: ";
    self.label2.text = [NSString stringWithFormat:@"¥%@",self.orderInfo.express_amont];
    self.label4.text = [NSString stringWithFormat:@"¥%@",self.orderInfo.money];
    if ([self.orderInfo isGlobal]) {
        if ([self.orderInfo.customs_tax_amount_total integerValue]>0) {
            self.taxMoneyLabel.text = [NSString stringWithFormat:@"¥%@(≤50免征)",self.orderInfo.customs_tax_amount_total];
            self.taxLabel.text = @"关税: ";
        }
    }
    
}

-(void)updateCellContains{

    if ([self.orderInfo isGlobal]) {
        [self.label4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.taxMoneyLabel.mas_bottom).mas_offset(5);
        }];
    }else{
        [self.label4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.taxMoneyLabel.mas_bottom);
        }];
    }
    
}


-(CGFloat)cellHeightWithModel:(OrderInfo *)model{
    if ([model isGlobal]) {
        return 50;
    }
    return 30;
}



@end
