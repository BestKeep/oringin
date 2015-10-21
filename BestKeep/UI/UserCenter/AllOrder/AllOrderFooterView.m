//
//  AllOrderFooterView.m
//  BESTKEEP
//
//  Created by dcj on 15/9/11.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AllOrderFooterView.h"
#import "GoodsModel.h"
#import "OrderInfo.h"
#import "UIView+Position.h"

#define SECTION_BOTTOM_MARGIN    10

@interface AllOrderFooterView ()<AllOrderFooterActionProtocol>

@property (nonatomic,strong) AllOrderFooterOrderInfoView * orderInfoView;
@property (nonatomic,strong) AllOrderFooterActionView * orderActionView;


@end

@implementation AllOrderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    
    self.orderInfoView = [[AllOrderFooterOrderInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    [self.contentView addSubview:self.orderInfoView];
    
    self.orderActionView = [[AllOrderFooterActionView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 50)];
    self.orderActionView.delegate = self;
    [self.contentView addSubview:self.orderActionView];
    
}

-(void)setOrder:(OrderInfo *)order{
    _order = order;
    [self updateFooterView];
}

-(void)updateFooterView{
    self.orderActionView.order = self.order;
    self.orderInfoView.order = self.order;
}

#pragma mark -- 根据order 返回footerView height
-(CGFloat)getFooterHeightWithOrder:(OrderInfo *)orderInfo{
//    if ([orderInfo.status isEqualToString:@""]) {
//        return [self.orderInfoView getFooterOrderInfoHeightWithOrder:orderInfo] + SECTION_BOTTOM_MARGIN;
//    }else{
        return [self.orderInfoView getFooterOrderInfoHeightWithOrder:orderInfo]+[self.orderActionView getFooterActionViewHeightWithOrder:orderInfo] + SECTION_BOTTOM_MARGIN;
//    }
}

-(void)allOrderFooterViewAction:(AllOrderFooterActionType)type orderInfo:(OrderInfo *)order{
    if ([self.footerDelegate respondsToSelector:@selector(allOrderView:actionType:order:)]) {
        [self.footerDelegate allOrderView:self actionType:type order:order];
    }
    
}

@end

@interface AllOrderFooterOrderInfoView ()
@property(nonatomic,strong) UIView *view3;
@property(nonatomic,strong) UIView *view_0;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *numLabel;
@property(nonatomic,strong) UILabel *label_0;
@property(nonatomic,strong) UILabel *label_1;
@property(nonatomic,strong) UILabel *tax_label1;
@property(nonatomic,strong) UILabel *tax_label2;

@end
@implementation AllOrderFooterOrderInfoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initContentView];
//        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

-(void)setOrder:(OrderInfo *)order{
    _order = order;
    [self updateData];
}
#pragma mark -- 更新数据
-(void)updateData{
    NSString * totalOrder = [NSString stringWithFormat:@"共%@件商品,合计:",self.order.amount];
    self.titleLabel.text = totalOrder;
    
    NSString * moneyStr = [NSString stringWithFormat:@"¥%@",self.order.order_amount];
    self.numLabel.text = moneyStr;
    
    NSString * taxStr;
    if ([self.order.channel_type isEqualToString:@"02"]) {
        taxStr = [NSString stringWithFormat:@"含运费:¥%@,海关税:¥%@",self.order.express_amount,self.order.customs_tax_amount_total];
    }else{
        taxStr =[NSString stringWithFormat:@"含运费:¥%@",self.order.express_amount];
    }
    self.tax_label1.text = taxStr;
}
#pragma mark -- 初始化subView
-(void)initContentView{
    
    self.view3 = [[UIView alloc] initWithFrame:CGRectMake(1,20, SCREEN_WIDTH, 30)];
    self.view3.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.view3];
    self.view_0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    self.view_0.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.view_0];
    self.titleLabel = [UILabel new];
    [self initLabel:self.titleLabel Frame:CGRectZero FontSize:16 Color:[UIColor blackColor]];
    [self.view3 addSubview:self.titleLabel];
    
    self.numLabel = [UILabel new];
    [self initLabel:self.numLabel Frame:CGRectZero FontSize:15 Color:COLOR_06];
    [self.view3 addSubview:self.numLabel];
    
    self.label_0 = [UILabel new];
    [self initLabel:self.label_0 Frame:CGRectZero FontSize:13 Color:COLOR_07];
    [self.view_0 addSubview:self.label_0];
    
    self.label_1 = [UILabel new];
    [self initLabel:self.label_1 Frame:CGRectZero FontSize:13 Color:COLOR_07];
    [self.view_0 addSubview:self.label_1];
    
    self.tax_label1 = [UILabel new];
    [self initLabel:self.tax_label1 Frame:CGRectZero FontSize:13 Color:COLOR_07];
    [self.view_0 addSubview:self.tax_label1];
    
    self.tax_label2 = [UILabel new];
    [self initLabel:self.tax_label2 Frame:CGRectZero FontSize:13 Color:COLOR_07];
    [self.view_0 addSubview:self.tax_label2];
    
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.view3.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numLabel.mas_left).offset(-5);
        make.centerY.equalTo(self.view3.mas_centerY);
    }];
    
    [self.tax_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view_0.mas_right).offset(-15);
        make.centerY.equalTo(self.view_0.mas_centerY);
    }];
    [self.tax_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view_0.mas_left).offset(-10);
        make.centerY.equalTo(self.view_0.mas_centerY);
    }];
    
    [self.label_0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tax_label2.mas_left).offset(-15);
        //make.top.equalTo(self.view_0.mas_top).offset(10);
        make.centerY.equalTo(self.view_0.mas_centerY);
    }];
    
    [self.label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.label_0.mas_left).offset(-5);
        // make.top.equalTo(self.view_0.mas_top).offset(10);
        make.centerY.equalTo(self.view_0.mas_centerY);
    }];
    
}
-(void)initLabel:(UILabel*)textLabel Frame:(CGRect)frame FontSize:(CGFloat)size Color:(UIColor*)color {
    textLabel.frame = frame;
    textLabel.font = [UIFont boldSystemFontOfSize:size];
    textLabel.numberOfLines = 0;
    textLabel.textColor = color;
    [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
}
#pragma mark -- 根据order 返回orderInfo height
-(CGFloat)getFooterOrderInfoHeightWithOrder:(OrderInfo *)orderInfo{
    
    return 50;
}

@end

@interface AllOrderFooterActionView ()
@property(nonatomic,strong) UIView *view4;
@property(nonatomic,strong) UIButton *button1;
@property(nonatomic,strong) UIButton *button2;
@property (nonatomic,strong) UIButton * button3;

@property(nonatomic,strong) UIView *lineView;

@end
@implementation AllOrderFooterActionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initContentView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setOrder:(OrderInfo *)order{
    if ([order.status isEqualToString:@"05"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    _order = order;
    [self updateData];
}

#pragma mark -- 更新数据
-(void)updateData{
    self.button1.hidden = NO;
    self.button2.hidden = NO;
    self.button3.hidden = NO;
    
    if ([self.order.status isEqualToString:@"01"]){
        self.button1.hidden = YES;
        self.button3.hidden = YES;
        [self.button2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(90));
        }];
        
    }
    else if ([self.order.status isEqualToString:@"02"]){
        self.button2.hidden = YES;
        self.button3.hidden = YES;
        [self.button2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(0));
        }];
    }
    else if ([self.order.status isEqualToString:@"03"]){
        self.button1.hidden = YES;
        self.button2.hidden = YES;
        [self.button1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(0));
        }];
        [self.button2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(0));
        }];
        
        [self.button3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(90));
        }];
        
    }
    else{
        self.button1.hidden = YES;
        self.button2.hidden = YES;
        self.button3.hidden = YES;
        
    }
    
}

#pragma mark -- 初始化subView
-(void)initContentView{
    
    //取消订单按钮
    self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button1 setTitle:@"取消订单" forState:UIControlStateNormal];
    [self.button1 setTitleColor:COLOR_04 forState:UIControlStateNormal];
    self.button1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.button1.layer.borderColor = COLOR_04.CGColor;
    self.button1.layer.borderWidth = 1.0;
    self.button1.layer.cornerRadius = 5.0f;
    [self.button1 addTarget:self action:@selector(cancleorderEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //付款按钮
    self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button2 setTitle:@"付款" forState:UIControlStateNormal];
    self.button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.button2 setTitleColor:COLOR_04 forState:UIControlStateNormal];
    self.button2.layer.borderColor = COLOR_04.CGColor;
    self.button2.layer.borderWidth = 1.0;
    self.button2.layer.cornerRadius = 5.0f;
    [self.button2 addTarget:self action:@selector(payOrderMoneyEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button3 setTitle:@"确认收货" forState:UIControlStateNormal];
    self.button3.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.button3 setTitleColor:COLOR_04 forState:UIControlStateNormal];
    self.button3.layer.borderColor = COLOR_04.CGColor;
    self.button3.layer.borderWidth = 1.0;
    self.button3.layer.cornerRadius = 5.0f;
    [self.button3 addTarget:self action:@selector(confirmReceiveEvent:) forControlEvents:UIControlEventTouchUpInside];

    
    [self addSubview:self.button1];
    [self addSubview:self.button2];
    [self addSubview:self.button3];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(90));
        make.height.equalTo(@(30));
    }];
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.button2.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(90));
        make.height.equalTo(@(30));
    }];
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.button1.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(90));
        make.height.equalTo(@(30));
    }];

    self.lineView = [UIView new];
    self.lineView.backgroundColor = COLOR_05;
    self.lineView.alpha = 0.1;
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(1));
    }];
    
}

#pragma mark -- button点击事件
-(void)cancleorderEvent:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(allOrderFooterViewAction:orderInfo:)]) {
        [self.delegate allOrderFooterViewAction:AllOrderFooterActionTypeCancle orderInfo:self.order];
    }
}
-(void)payOrderMoneyEvent:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(allOrderFooterViewAction:orderInfo:)]) {
        [self.delegate allOrderFooterViewAction:AllOrderFooterActionTypePay orderInfo:self.order];
    }
}
-(void)confirmReceiveEvent:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(allOrderFooterViewAction:orderInfo:)]) {
        [self.delegate allOrderFooterViewAction:AllOrderFooterActionTypeConfirm orderInfo:self.order];
    }
}
#pragma mark -- 根据order 返回action height
-(CGFloat)getFooterActionViewHeightWithOrder:(OrderInfo *)orderInfo{
    if ([orderInfo.status isEqualToString:@"01"]) {
        return 50;
    }else if ([orderInfo.status isEqualToString:@"02"]){
        return 50;
    }else if ([orderInfo.status isEqualToString:@"03"]){
        return 50;
    }
    return 0;
}


@end















