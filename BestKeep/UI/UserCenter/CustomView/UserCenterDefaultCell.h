//
//  UserCenterDefaultCell.h
//  BESTKEEP
//
//  Created by dcj on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterDefaultCell : UITableViewCell

@property (nonatomic,strong) UILabel * bcLeftTextlabel;
@property (strong, nonatomic) UIView *bcAccessoryView;
@property (strong, nonatomic) UILabel *bcRightTextLabel;
@property (strong, nonatomic) UILabel *bcArrowImageView;

@property (nonatomic,assign) BOOL hideArrowImage;
@property (nonatomic,assign) BOOL showStrokeView;



@end
