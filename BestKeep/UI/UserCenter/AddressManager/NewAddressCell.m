//
//  AddressCell.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/24.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "NewAddressCell.h"
#import "DeliverAddress.h"

@interface NewAddressCell ()


@end

@implementation NewAddressCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id)delegate tag:(NSInteger)tag{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
        [self.contentView addSubview:backView1];
        UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, backView1.frame.origin.y+backView1.frame.size.height, SCREEN_WIDTH, 50)];
        [self.contentView addSubview:backView2];
        //        self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, backView2.frame.origin.y+backView2.frame.size.height, SCREEN_WIDTH, 36)];
        //        [self.contentView addSubview:self.backView3];
        
        self.nameLabel = [UILabel new];
        self.cellNumLabel = [UILabel new];
        self.addressLabel = [UILabel new];
        self.tagLabel = [UILabel new];
        self.view1 = [UILabel new];
        self.view2 = [UILabel new];
        
        [self initLabel:self.nameLabel FontSize:16 Color:COLOR_05];
        [self initLabel:self.cellNumLabel FontSize:16 Color:COLOR_05];
        [self initLabel:self.addressLabel FontSize:14 Color:COLOR_05];
        [self initLabel:self.tagLabel FontSize:14 Color:COLOR_06];
        
        [backView1 addSubview:self.nameLabel];
        [backView1 addSubview:self.cellNumLabel];
        [backView1 addSubview:self.tagLabel];
        [backView2 addSubview:self.addressLabel];
        
        self.view1 = [[UIView alloc] initWithFrame:CGRectMake(15, backView1.frame.origin.y+backView1.frame.size.height, SCREEN_WIDTH-15, 1)];
        self.view1.backgroundColor = COLOR_05;
        self.view1.alpha = 0.15;
        [self addSubview:self.view1];
        self.view2 = [[UIView alloc] initWithFrame:CGRectMake(15, backView2.frame.origin.y+backView2.frame.size.height, SCREEN_WIDTH-15, 1)];
        self.view2.alpha = 0.15;
        self.view2.backgroundColor = COLOR_05;
        [self addSubview:self.view2];
        
        
        self.radiobutton = [UIButton buttonWithType:UIButtonTypeCustom];
           [self.radiobutton setBackgroundImage:[UIImage imageNamed:@"unselect_image"] forState:UIControlStateNormal];
        [self.radiobutton setBackgroundImage:[UIImage imageNamed:@"select_image"] forState:UIControlStateSelected];
        [self.radiobutton addTarget:self action:@selector(selectedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.radiobutton setTitleColor:COLOR_05 forState:UIControlStateNormal];
        self.radiobutton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.radiobutton setTitle:@"" forState:UIControlStateNormal];
        [backView1 addSubview:self.radiobutton];
        
        [self.radiobutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(backView1.mas_right).mas_offset(-15);
            make.centerY.equalTo(self.nameLabel.mas_centerY);
            make.width.equalTo(@(30));
            make.height.equalTo(@(30));
        }];

        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view1.mas_left).mas_offset(10);
            make.centerY.equalTo(backView1.mas_centerY);
        }];
        [self.cellNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).mas_offset(10);
            make.centerY.equalTo(backView1.mas_centerY);
        }];
        
                [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.contentView.mas_right).mas_offset(-60);
                    make.centerY.equalTo(backView1.mas_centerY);
                }];
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view1.mas_left).mas_offset(10);
            make.width.equalTo(@(SCREEN_WIDTH-30));
            make.centerY.equalTo(self.contentView.mas_centerY).mas_offset(15);
        }];
        
      
        
        //地址选择按钮
//        [self.radiobutton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.view1.mas_right).mas_offset(-10);
//            make.centerY.equalTo(self.nameLabel.mas_centerY);
//            
//        }];
    }
    return self;
}
-(void)initLabel:(UILabel*)textLabel  FontSize:(CGFloat)size Color:(UIColor*)color {
    textLabel.font = [UIFont boldSystemFontOfSize:size];
    textLabel.textColor = color;
    textLabel.numberOfLines = 2;
    textLabel.textAlignment = NSTextAlignmentLeft;
    [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
}

-(void)updateCellContentWithAddress:(DeliverAddress *)address{
    self.address = address;
    self.radiobutton.selected = address.isDefaultAddress;
    self.nameLabel.text = address.deliverName;
    self.cellNumLabel.text = address.deliverTelephone;
    self.addressLabel.text = address.deliverAddress;
    if (address.isDefaultAddress) {
        self.tagLabel.text = @"默认地址";
    }else{
        self.tagLabel.text = @"";
    }

}

#pragma mark 点击事件

-(void)selectedButtonClicked:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        
    }else{
        self.tagLabel.text = @"";
    }
    self.address.isDefaultAddress = button.selected;
    if ([self.addressCellDelegate respondsToSelector:@selector(newAddressCell:selectedButton:)]) {
        [self.addressCellDelegate newAddressCell:self selectedButton:button];
    }

}

//-(void)clickDeleteAddress:(UIButton*)sender{
//    if ([self.delegate respondsToSelector:@selector(clickDelegateButton:)]) {
//        [self.delegate clickDelegateButton:sender.tag];
//    }
//}
//-(void)clickEditAddress:(UIButton*)sender{
//    if ([self.delegate respondsToSelector:@selector(clickEditButton:)]) {
//        [self.delegate clickEditButton:sender.tag];
//    }
//}
-(void)dealloc{
    
}
@end
