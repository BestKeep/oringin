//
//  UserCentrerBaceCell.h
//  BESTKEEP
//
//  Created by dcj on 15/8/19.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//
//
#import <UIKit/UIKit.h>

@interface UserCentrerBaseCell : UITableViewCell

@property (nonatomic,strong) UIView * cellBackImageView;

@property (strong, nonatomic) UILabel *ucTextLabel;
@property (strong, nonatomic) UIView *ucAccessoryView;
@property (strong, nonatomic) UILabel *ucRightTextLabel;
@property (strong, nonatomic) UILabel *bcArrowImageView;
@property (strong, nonatomic) UIImageView *userImageView;
@property (strong, nonatomic) UIImageView *userCoverImageView;
@property (assign, nonatomic) BOOL accessoryImage;

- (void)layoutUcAccessoryView;

@end
