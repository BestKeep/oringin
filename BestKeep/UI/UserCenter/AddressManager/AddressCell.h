//
//  AddressCell.h
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/24.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"
#import "DeliverAddress.h"
@class AddressCell;
@protocol clickButtonDelegate <NSObject>

@optional
-(void)clickEditButton:(UIButton *)editButton addressModel:(DeliverAddress *)address;
-(void)clickDelegateButton:(DeliverAddress *)address;-(void)newAddressCell:(AddressCell *)cell selectedButton:(UIButton *)selectedButton;
@end

@interface AddressCell : UITableViewCell

@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *cellNumLabel;
@property(nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel*tagButLabel;
@property(nonatomic,strong) UIButton *editBtn;
@property(nonatomic,strong) UIButton *deleteBtn;
@property(nonatomic,strong) UIView *view1;
@property(nonatomic,strong) UIView *view2;
@property(nonatomic,strong) UIView *backView3;
@property(nonatomic,strong) UILabel *tagLabel;
@property (nonatomic)BOOL defult;
@property(nonatomic,strong) UIButton *radiobutton;
@property (nonatomic,strong) DeliverAddress *datas; 

@property(nonatomic,weak) id<clickButtonDelegate>adddelegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id)delegate tag:(NSInteger)tag;
-(void)updateCellContentWithAddress:(DeliverAddress *)address;
@end
