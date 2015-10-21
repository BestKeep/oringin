//
//  OrderStatuCell.m
//  BESTKEEP
//
//  Created by dcj on 15/8/19.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "OrderStatuCell.h"
#import "UIView+Position.h"
#import "PrefixHeader.pch"
#import "UIColor+CJCategory.h"
#import "StrokeViewManager.h"
#import "ShoppingCarCommon.h"
#define ButtonWidth               [UIScreen mainScreen].bounds.size.width/4
#define ButtonTag         200
#define LabelHeight           [UIImage imageNamed:@"anhao.png"].size.height

@interface OrderStatuCell ()<OrderStatuViewDelegate>

@property (nonatomic,strong) NSArray * titleArray;


@end

@implementation OrderStatuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.width = [UIScreen mainScreen].bounds.size.width;
        self.contentView.width = [UIScreen mainScreen].bounds.size.width;
        UIView * backView = [[UIView alloc] initWithFrame:self.bounds];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        backView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        

    }
    return self;
}


- (void)awakeFromNib {

}

-(void)updateCellContentViewWithTitleArray:(NSArray * )titleArray imageArray:(NSArray *)imageArray{
    self.titleArray = titleArray;
    for (int i = 0; i<titleArray.count; i++) {
        
        NSString * title = titleArray[i];
        NSString * imageStr = imageArray[i];
        
        OrderStatuView * orderStauView = [[OrderStatuView alloc] initWithFrame:CGRectMake(i*ButtonWidth, 0, ButtonWidth, 65) title:title imageStr:imageStr];
        orderStauView.statuViewDelegate = self;
        [self.contentView addSubview:orderStauView];
        orderStauView.tag = ButtonTag + i;
        orderStauView.type = i;
    }

}
-(void)updateCellWithCount:(NSInteger)count{
    for (int i = 0; i<self.titleArray.count; i++) {
        OrderStatuView * orderStatuView = (OrderStatuView *)[self.contentView viewWithTag:ButtonTag + i];
        [orderStatuView updateWithCount:0];
    }
    
}
-(void)updateCellContentDataWithShoppingCarCommon:(ShoppingCarCommon *)shoppingCarCommon{
    if (![shoppingCarCommon isKindOfClass:[ShoppingCarCommon class]]) {
        return;
    }
    for (int i = 0; i<self.titleArray.count; i++) {
        OrderStatuView * orderStatuView = (OrderStatuView *)[self.contentView viewWithTag:ButtonTag + i];

        switch (orderStatuView.type) {
            case OrderStatuViewTypeAllOrder:
                [orderStatuView updateWithCount:0];
                break;
            case OrderStatuViewTypeUnPay:
                [orderStatuView updateWithCount:[[shoppingCarCommon.data objectForKey:@"wait_pay"] integerValue]];
                break;
            case OrderStatuViewTypePaid:
                [orderStatuView updateWithCount:[[shoppingCarCommon.data objectForKey:@"paid"] integerValue]];
                break;
            case OrderStatuViewTypeWaitReceive:
                [orderStatuView updateWithCount:[[shoppingCarCommon.data objectForKey:@"wait_receive"] integerValue]];
                break;
                
            default:
                break;
        }
    }
}

-(void)orderStatuDelegateButtonClick:(OrderStatuViewType)type{
    
    if ([self.delegate respondsToSelector:@selector(onButtonClickWithIndex:)]) {
        [self.delegate onButtonClickWithIndex:type];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end


@interface OrderStatuView ()
@property (nonatomic,strong) StrokeView * strokeView;

@end

@implementation OrderStatuView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr{
    if (self = [super initWithFrame:frame]) {
        
        [self commonInitWith:title imageStr:imageStr];
    }
    return self;
}
-(void)commonInitWith:(NSString *)title imageStr:(NSString *)imageStr{

    UIButton * orderStatuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    orderStatuButton.frame = CGRectMake(0, 40, self.width, 20);
    [orderStatuButton setTitle:title forState:UIControlStateNormal];
    [orderStatuButton setTintColor:[UIColor darkGrayColor]];
    orderStatuButton.titleLabel.font =[UIFont systemFontOfSize:12];
    [orderStatuButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self addSubview:orderStatuButton];
    [orderStatuButton addTarget:self action:@selector(orderStatuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 25, 25)];
    imageLabel.font=[UIFont fontWithName:@"iconfont" size:25];
    imageLabel.text = imageStr;
    imageLabel.textColor = [UIColor colorWithString:@"#999999"];
    [self addSubview:imageLabel];
    imageLabel.bottom = orderStatuButton.top;
    imageLabel.centerX = orderStatuButton.centerX;
    StrokeView * strokeView = [StrokeViewManager showStrokeView:self text:12 textColor:[UIColor redColor]];
    self.strokeView = strokeView;
 
    strokeView.center = CGPointMake(imageLabel.right, imageLabel.top);
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
}
-(void)tap:(UITapGestureRecognizer *)tap{
    [self orderStatuButtonClick:nil];
}
-(void)orderStatuButtonClick:(UIButton *)button{
    if ([self.statuViewDelegate respondsToSelector:@selector(orderStatuDelegateButtonClick:)]) {
        [self.statuViewDelegate orderStatuDelegateButtonClick:self.type];
    }

}


-(void)updateWithCount:(NSInteger)count{
    [StrokeViewManager updateStrokeView:self.strokeView WithText:count];
}

@end






















