//
//  StrokeViewManager.m
//  labelTest
//
//  Created by dcj on 15/8/26.
//  Copyright (c) 2015年 dcj. All rights reserved.
//

#import "StrokeViewManager.h"

@implementation StrokeViewManager

+(StrokeView *)showStrokeView:(UIView *)view text:(NSInteger)count textColor:(UIColor *)textColor{
    
    UIImage * backImage;
    if (count>9&&count<99) {
        if (textColor == [UIColor whiteColor]) {
            backImage = [UIImage imageNamed:@"提示圈－实体2"];
        }else if (textColor == [UIColor redColor]){
            backImage = [UIImage imageNamed:@"提示圈－描边2"];
        }
        
    }else if (count<=9){
        if (textColor == [UIColor whiteColor]) {
            backImage = [UIImage imageNamed:@"提示圈－实体1"];
        }else if (textColor == [UIColor redColor]){
            backImage = [UIImage imageNamed:@"提示圈－描边1"];
        }
    }
    StrokeView * strokeView = [[StrokeView alloc] initWithFrame:CGRectZero andBackImage:backImage text:[NSString stringWithFormat:@"%ld",(long)count] textColor:textColor];
    [view addSubview:strokeView];
    return strokeView;
}

+(void)updateStrokeView:(StrokeView *)strokeView WithText:(NSInteger)count{
    
    UIImage * backImage;
    UIColor * textColor = strokeView.strokeLabel.textColor;
    //    count  = 102;
    
    if (count>9) {
        if (textColor == [UIColor whiteColor]) {
            backImage = [UIImage imageNamed:@"提示圈－实体2"];
        }else if (textColor == [UIColor redColor]){
            backImage = [UIImage imageNamed:@"提示圈－描边2"];
        }
        
    }else if (count<=9){
        if (textColor == [UIColor whiteColor]) {
            backImage = [UIImage imageNamed:@"提示圈－实体1"];
        }else if (textColor == [UIColor redColor]){
            backImage = [UIImage imageNamed:@"提示圈－描边1"];
        }
    }
    if (count == 0) {
        [strokeView hideStrokeView];
    }else if (count>99){
        [strokeView updateStrokeViewWithText:[NSString stringWithFormat:@"%d+",99] andBackImage:backImage textColor:textColor];
        
    }else{
        [strokeView updateStrokeViewWithText:[NSString stringWithFormat:@"%ld",(long)count] andBackImage:backImage textColor:textColor];
    }
}
+(void)hideStrokeView:(StrokeView *)strokeView{
    [UIView animateWithDuration:0.3 animations:^{
        strokeView.alpha = 0;
    } completion:^(BOOL finished) {
        [strokeView removeFromSuperview];
    }];


}

@end
