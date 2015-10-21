//
//  UserCentrerBaceCell.m
//  BESTKEEP
//
//  Created by dcj on 15/8/19.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "UserCentrerBaseCell.h"
#import "UIView+Position.h"
#import "UIColor+CJCategory.h"

@interface UserCentrerBaseCell ()

@property (nonatomic,strong) UIView * backGroundView;

@end
@implementation UserCentrerBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        /**
         * 设置cell 圆角背景图
         */
        self.cellBackImageView =[[UIView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 48.0f)];
        self.cellBackImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.cellBackImageView];
        [self.cellBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.height.equalTo(@(44.0f));
        }];
        /**
         * 设置cell Label
         */
        CGRect ucTextFrame =CGRectMake(20.0f, 11.5f,180.0f, 21.0f);
        self.ucTextLabel =[[UILabel alloc] initWithFrame:ucTextFrame];
        self.ucTextLabel.font =[UIFont systemFontOfSize:14.0f];
        self.ucTextLabel.textColor =[UIColor colorWithString:@"#5f646e"];
        self.ucTextLabel.textAlignment =NSTextAlignmentLeft;
        self.ucTextLabel.backgroundColor =[UIColor clearColor];
        self.ucTextLabel.adjustsFontSizeToFitWidth =YES;
        [self.cellBackImageView addSubview:self.ucTextLabel];
        
        /**
         *  设置 selectedBackgroundView 背景为 clearColor
         *  达到点击cell 高亮显示
         */
        self.selectedBackgroundView= [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor =[UIColor clearColor];
    }
    return self;
}

#pragma mark
/**
 *  显示accesoryView
 */
- (void)layoutUcAccessoryView{
    
    /**
     * 设置cell accessoryView
     */
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        
        CGRect ucAccessoryViewFrame =CGRectMake(0.0f, 0.0f,200.0f, 44.0f);
        self.ucAccessoryView =[[UIView alloc] initWithFrame:ucAccessoryViewFrame];
        self.ucAccessoryView.backgroundColor =[UIColor clearColor];
        self.accessoryView =self.ucAccessoryView;
        
        //        UIImage *arrowImage =[UIImage imageNamed:@"maparrow"];
        self.bcArrowImageView =[[UILabel alloc] initWithFrame:CGRectZero];
        self.bcArrowImageView.frame =CGRectMake(self.ucAccessoryView.width -10, 14.0f, 15, 15);
        self.bcArrowImageView.backgroundColor =[UIColor clearColor];
        [self.ucAccessoryView addSubview:self.bcArrowImageView];
        self.bcArrowImageView.textColor = [UIColor colorWithString:@"#aaaaaa"];
        self.bcArrowImageView.font=[UIFont fontWithName:@"iconfont" size:13];
        self.bcArrowImageView.text = @"\U0000e610";
        
        
        CGRect ucRightFrame =CGRectMake(0.0f, 11.0f,self.ucAccessoryView.width-(self.bcArrowImageView.width), 21.0f);
        self.ucRightTextLabel =[[UILabel alloc] initWithFrame:ucRightFrame];
        self.ucRightTextLabel.font =[UIFont systemFontOfSize:12.0f];
        self.ucRightTextLabel.textColor =[UIColor lightGrayColor];
        self.ucRightTextLabel.textAlignment =NSTextAlignmentRight;
        self.ucRightTextLabel.backgroundColor =[UIColor clearColor];
        self.ucRightTextLabel.adjustsFontSizeToFitWidth =YES;
        [self.ucAccessoryView addSubview:self.ucRightTextLabel];
    }else{
        [self.ucAccessoryView removeFromSuperview];
    }
}

-(void)setAccessoryImage:(BOOL)accessoryImage{
    [self layoutAccessoryImage:accessoryImage];
}

-(void)layoutAccessoryImage:(BOOL)isImage{
    
    if (isImage) {
        self.userImageView =[[UIImageView alloc] init];
        self.userImageView.frame = CGRectMake(self.ucRightTextLabel.right-30,7.0f, 30.f, 30.f);
        self.userImageView.layer.masksToBounds = YES;
        self.userImageView.layer.cornerRadius = 15;
        self.userImageView.layer.borderWidth =1.0f;
        
        self.userImageView.layer.borderColor = [UIColor fromHexValue:0xa0a0a0].CGColor;
        [self.ucAccessoryView addSubview:self.userImageView];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
