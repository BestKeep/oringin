//
//  StrokeView.h
//  labelTest
//
//  Created by dcj on 15/8/26.
//  Copyright (c) 2015年 dcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrokeView : UIView

@property (nonatomic,strong) UIImageView * backImageView;
@property (nonatomic,strong) UILabel * strokeLabel;

-(instancetype)initWithFrame:(CGRect)frame andBackImage:(UIImage *)backImage text:(NSString *)text textColor:(UIColor *)textColor;

-(void)updateStrokeViewWithText:(NSString *)text andBackImage:(UIImage *)backImage textColor:(UIColor *)textColor;

-(void)hideStrokeView;

@end
