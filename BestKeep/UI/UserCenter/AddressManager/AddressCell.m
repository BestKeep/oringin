//
//  AddressCell.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/24.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "AddressCell.h"
#import "AddSet.h"

@interface AddressCell()
@end

@implementation AddressCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id)delegate tag:(NSInteger)tag{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
//        [self.contentView addSubview:backView1];
//        UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, backView1.frame.origin.y+backView1.frame.size.height, SCREEN_WIDTH, 50)];
//        [self.contentView addSubview:backView2];
//        self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, backView2.frame.origin.y+backView2.frame.size.height, SCREEN_WIDTH, 36)];
//        [self.contentView addSubview:self.backView3];
//        
//        self.nameLabel = [UILabel new];
//        self.cellNumLabel = [UILabel new];
//        self.addressLabel = [UILabel new];
//        self.tagLabel = [UILabel new];
//        self.tagButLabel = [UILabel new];
//        self.view1 = [UILabel new];
//        self.view2 = [UILabel new];
//        
//        [self initLabel:self.nameLabel FontSize:16 Color:COLOR_05];
//        [self initLabel:self.cellNumLabel FontSize:16 Color:COLOR_05];
//        [self initLabel:self.addressLabel FontSize:14 Color:COLOR_05];
//        [self initLabel:self.tagLabel FontSize:16 Color:COLOR_06];
//        [self initLabel:self.tagButLabel FontSize:16 Color:COLOR_05];
//        
//        [backView1 addSubview:self.nameLabel];
//        [backView1 addSubview:self.cellNumLabel];
//        [backView1 addSubview:self.tagLabel];
//        [backView2 addSubview:self.addressLabel];
//        [backView2 addSubview:self.tagButLabel];
//        
//        self.view1 = [[UIView alloc] initWithFrame:CGRectMake(15, backView1.frame.origin.y+backView1.frame.size.height, SCREEN_WIDTH-15, 1)];
//        self.view1.backgroundColor = COLOR_05;
//        self.view1.alpha = 0.15;
//        [self addSubview:self.view1];
//        self.view2 = [[UIView alloc] initWithFrame:CGRectMake(15, backView2.frame.origin.y+backView2.frame.size.height, SCREEN_WIDTH-15, 1)];
//        self.view2.alpha = 0.15;
//        self.view2.backgroundColor = COLOR_05;
//        [self addSubview:self.view2];
//        
//        
//        //删除按钮
//        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//        self.deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
//        [self.deleteBtn setTitleColor:COLOR_05 forState:UIControlStateNormal];
//        self.deleteBtn.layer.cornerRadius = 5.0f;
//        self.deleteBtn.layer.borderWidth = 1.0f;
//        self.deleteBtn.layer.borderColor = COLOR_05.CGColor;
//        self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        [self.deleteBtn addTarget:self action:@selector(clickDeleteAddress:) forControlEvents:UIControlEventTouchUpInside];
//        [self.backView3 addSubview:self.deleteBtn];
//        
//        UILabel *deleteLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        deleteLabel.font=[UIFont fontWithName:@"iconfont" size:14];
//        deleteLabel.textColor = COLOR_05;
//        deleteLabel.text = @"\U0000e622";
//        [self.deleteBtn addSubview:deleteLabel];
//        
//        
//        //编辑按钮
//        self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
//        self.editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
//        [self.editBtn setTitleColor:COLOR_05 forState:UIControlStateNormal];
//        self.editBtn.layer.cornerRadius = 5.0f;
//        self.editBtn.layer.borderWidth = 1.0f;
//        self.editBtn.layer.borderColor = COLOR_05.CGColor;
//        self.editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        [self.editBtn addTarget:self action:@selector(clickEditAddress:) forControlEvents:UIControlEventTouchUpInside];
//        [self.backView3 addSubview:self.editBtn];
//        
//        UILabel *editLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        editLabel.font=[UIFont fontWithName:@"iconfont" size:14];
//        editLabel.textColor = COLOR_05;
//        editLabel.text = @"\U0000e61d";
//        [self.editBtn addSubview:editLabel];
//        
//        self.radiobutton = [[QRadioButton alloc] initWithDelegate:delegate groupId:@"00000"];
//        [self.radiobutton setTitleColor:COLOR_05 forState:UIControlStateNormal];
//        self.radiobutton.titleLabel.font = [UIFont systemFontOfSize:14];
//        [self.radiobutton setTitle:@"设置为默认地址" forState:UIControlStateNormal];
//        if ([[AddSet getAddIsDefaulit] isEqualToString:@"1"]) {
//            self.radiobutton.selected = _defult;
//        }else{
//            self.radiobutton.selected = _defult;
//        }
//        [self.backView3 addSubview:self.radiobutton];
//        
//        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(backView1.mas_left).mas_offset(15);
//            make.centerY.equalTo(backView1.mas_centerY);
//        }];
//        [self.cellNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.nameLabel.mas_right).mas_offset(30);
//            make.centerY.equalTo(backView1.mas_centerY);
//        }];
//        
//        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.contentView.mas_right).mas_offset(-15);
//            make.centerY.equalTo(backView1.mas_centerY);
//        }];
//        
//        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView.mas_left).mas_offset(15);
//            make.width.equalTo(@(SCREEN_WIDTH-30));
//            make.centerY.equalTo(self.contentView.mas_centerY);
//        }];
//        
//        //按钮约束
//        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.contentView.mas_right).mas_offset(-15);
//            make.width.equalTo(@(60));
//            make.height.equalTo(@(25));
//            make.centerY.equalTo(self.backView3.mas_centerY);
//        }];
//        [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.deleteBtn.mas_left).mas_offset(-10);
//            make.width.equalTo(@(60));
//            make.height.equalTo(@(25));
//            make.centerY.equalTo(self.backView3.mas_centerY);
//        }];
//        //编辑按钮图片
//        [editLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.editBtn.mas_left).mas_offset(5);
//            make.centerY.equalTo(self.editBtn.mas_centerY);
//        }];
//        //删除按钮图片
//        [deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.deleteBtn.mas_left).mas_offset(5);
//            make.centerY.equalTo(self.deleteBtn.mas_centerY);
//        }];
//        
//        //地址选择按钮
//        [self.radiobutton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView.mas_left).mas_offset(15);
//            make.centerY.equalTo(self.deleteBtn.mas_centerY);
//        }];
//        //设为默认地址
//        [self.tagButLabel setText:@"设为默认地址"];
//        [self.tagButLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.radiobutton.mas_right).mas_offset(15);
//            make.centerX.equalTo(self.backView3.mas_centerX);
//            make.centerY.equalTo(self.backView3.mas_centerY);
//        }];
//    }
//    return self;
//}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id)delegate tag:(NSInteger)tag{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
        [self.contentView addSubview:backView1];
        UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, backView1.frame.origin.y+backView1.frame.size.height, SCREEN_WIDTH, 50)];
        [self.contentView addSubview:backView2];
        self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, backView2.frame.origin.y+backView2.frame.size.height, SCREEN_WIDTH, 36)];
        [self.contentView addSubview:self.backView3];

        self.nameLabel = [UILabel new];
        self.cellNumLabel = [UILabel new];
        self.addressLabel = [UILabel new];
        self.tagLabel = [UILabel new];
        self.tagButLabel = [UILabel new];
        self.view1 = [UILabel new];
        self.view2 = [UILabel new];
        
        [self initLabel:self.nameLabel FontSize:16 Color:COLOR_05];
        [self initLabel:self.cellNumLabel FontSize:16 Color:COLOR_05];
        [self initLabel:self.addressLabel FontSize:14 Color:COLOR_05];
        [self initLabel:self.tagLabel FontSize:16 Color:COLOR_06];
        [self initLabel:self.tagButLabel FontSize:16 Color:COLOR_05];
        
        [backView1 addSubview:self.nameLabel];
        [backView1 addSubview:self.cellNumLabel];
        [backView1 addSubview:self.tagLabel];
        [backView2 addSubview:self.addressLabel];
        [backView2 addSubview:self.tagButLabel];
        
        self.view1 = [[UIView alloc] initWithFrame:CGRectMake(15, backView1.frame.origin.y+backView1.frame.size.height, SCREEN_WIDTH-15, 1)];
        self.view1.backgroundColor = COLOR_05;
        self.view1.alpha = 0.15;
        [self addSubview:self.view1];
        self.view2 = [[UIView alloc] initWithFrame:CGRectMake(15, backView2.frame.origin.y+backView2.frame.size.height, SCREEN_WIDTH-15, 1)];
        self.view2.alpha = 0.15;
        self.view2.backgroundColor = COLOR_05;
        [self addSubview:self.view2];
        
        
        //删除按钮
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
         self.deleteBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        [self.deleteBtn setTitleColor:COLOR_05 forState:UIControlStateNormal];
        self.deleteBtn.layer.cornerRadius = 5.0f;
        self.deleteBtn.layer.borderWidth = 1.0f;
        self.deleteBtn.layer.borderColor = COLOR_05.CGColor;
        self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.deleteBtn addTarget:self action:@selector(clickDeleteAddress:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView3 addSubview:self.deleteBtn];
        
        UILabel *deleteLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        deleteLabel.font=[UIFont fontWithName:@"iconfont" size:14];
        deleteLabel.textColor = COLOR_05;
        deleteLabel.text = @"\U0000e622";
        [self.deleteBtn addSubview:deleteLabel];
        
        
        //编辑按钮
        self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        self.editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        [self.editBtn setTitleColor:COLOR_05 forState:UIControlStateNormal];
        self.editBtn.layer.cornerRadius = 5.0f;
        self.editBtn.layer.borderWidth = 1.0f;
        self.editBtn.layer.borderColor = COLOR_05.CGColor;
        self.editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.editBtn addTarget:self action:@selector(clickEditAddress:) forControlEvents:UIControlEventTouchUpInside];
        [self.backView3 addSubview:self.editBtn];
        
        UILabel *editLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        editLabel.font=[UIFont fontWithName:@"iconfont" size:14];
        editLabel.textColor = COLOR_05;
        editLabel.text = @"\U0000e61d";
        [self.editBtn addSubview:editLabel];
        
        self.radiobutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.radiobutton setBackgroundImage:[UIImage imageNamed:@"unselect_image"] forState:UIControlStateNormal];
        [self.radiobutton setBackgroundImage:[UIImage imageNamed:@"select_image"] forState:UIControlStateSelected];
        [self.radiobutton addTarget:self action:@selector(selectedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.radiobutton setTitleColor:COLOR_05 forState:UIControlStateNormal];
        self.radiobutton.titleLabel.font = [UIFont systemFontOfSize:14];
        //[self.radiobutton setTitle:@"设置为默认地址" forState:UIControlStateNormal];
        [self.backView3 addSubview:self.radiobutton];
        
        [self.radiobutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView3.mas_left).mas_offset(15);
            make.centerY.equalTo(self.backView3.mas_centerY);
            make.height.equalTo(@(25));
            make.width.equalTo(@(25));
        }];
        
        //设为默认地址
        [self.tagButLabel setText:@"设为默认地址"];
        [self.tagButLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.radiobutton.mas_right).mas_offset(10);
            make.centerY.equalTo(self.backView3.mas_centerY);
            make.centerX.equalTo(self.backView3.mas_centerX);
            
            
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backView1.mas_left).mas_offset(15);
            make.centerY.equalTo(backView1.mas_centerY);
        }];
        [self.cellNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_right).mas_offset(30);
            make.centerY.equalTo(backView1.mas_centerY);
        }];
        
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).mas_offset(-15);
            make.centerY.equalTo(backView1.mas_centerY);
        }];

        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).mas_offset(15);
            make.width.equalTo(@(SCREEN_WIDTH-30));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        //按钮约束
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).mas_offset(-15);
            make.width.equalTo(@(60));
            make.height.equalTo(@(25));
            make.centerY.equalTo(self.backView3.mas_centerY);
        }];
        [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.deleteBtn.mas_left).mas_offset(-10);
            make.width.equalTo(@(60));
            make.height.equalTo(@(25));
            make.centerY.equalTo(self.backView3.mas_centerY);
        }];
        //编辑按钮图片
        [editLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.editBtn.mas_left).mas_offset(5);
            make.centerY.equalTo(self.editBtn.mas_centerY);
        }];
        //删除按钮图片
        [deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.deleteBtn.mas_left).mas_offset(5);
            make.centerY.equalTo(self.deleteBtn.mas_centerY);
        }];
        
//        //地址选择按钮
//        [self.radiobutton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView.mas_left).mas_offset(15);
//            make.centerY.equalTo(self.deleteBtn.mas_centerY);
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

#pragma mark 点击事件
-(void)clickDeleteAddress:(UIButton*)sender{
    if ([self.adddelegate respondsToSelector:@selector(clickDelegateButton:)]) {
        [self.adddelegate clickDelegateButton:self.datas];
    }
}
-(void)clickEditAddress:(UIButton*)sender{
    if ([self.adddelegate respondsToSelector:@selector(clickEditButton:addressModel:)]) {
        [self.adddelegate clickEditButton:sender addressModel:self.datas];
    }
}
-(void)updateCellContentWithAddress:(DeliverAddress *)address{
    self.datas = address;
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

-(void)selectedButtonClicked:(UIButton *)button{
    button.selected = !button.selected;
    self.datas.isDefaultAddress = button.selected;
    if (button.selected) {
    
    }else{
        self.tagLabel.text =@"";
    }
    self.datas.isDefaultAddress = button.selected;
    if ([self.adddelegate respondsToSelector:@selector(newAddressCell:selectedButton:)]) {
        [self.adddelegate newAddressCell:self selectedButton:button];
    }
}
-(void)dealloc{
    
}
@end
