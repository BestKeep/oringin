//
//  NewAddressCell.h
//  BESTKEEP
//
//  Created by cunny on 15/8/28.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"
#import "DeliverAddress.h"

@class NewAddressCell;
@protocol NewclickButtonDelegate <NSObject>

@optional

-(void)newAddressCell:(NewAddressCell *)cell selectedButton:(UIButton *)selectedButton;

//-(void)clickEditButton:(NSInteger)index;
//-(void)clickDelegateButton:(NSInteger)index;

@end

@interface NewAddressCell : UITableViewCell

@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *cellNumLabel;
@property(nonatomic,strong) UILabel *addressLabel;
@property(nonatomic,strong) UIView *view1;
@property(nonatomic,strong) UIView *view2;
@property(nonatomic,strong) UILabel *tagLabel;
@property(nonatomic,strong) UIButton *radiobutton;
@property (nonatomic,strong) DeliverAddress * address;


@property(nonatomic,weak) id<NewclickButtonDelegate> addressCellDelegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id)delegate tag:(NSInteger)tag;
-(void)updateCellContentWithAddress:(DeliverAddress *)address;

@end