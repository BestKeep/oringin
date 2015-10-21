//
//  UserCenterTextButtonView.h
//  BESTKEEP
//
//  Created by dcj on 15/8/19.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterTextButtonView : UIView

@property (nonatomic,strong) UIButton * button;
@property (nonatomic,strong) UILabel * textLabel;

-(void)changeTextLabelText:(NSString *)text;

@end

