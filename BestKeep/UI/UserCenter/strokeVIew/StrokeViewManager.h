//
//  StrokeViewManager.h
//  labelTest
//
//  Created by dcj on 15/8/26.
//  Copyright (c) 2015年 dcj. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StrokeView.h"

@interface StrokeViewManager : NSObject

+(StrokeView *)showStrokeView:(UIView *)view text:(NSInteger)count textColor:(UIColor *)textColor;
+(void)updateStrokeView:(StrokeView *)strokeView WithText:(NSInteger)count;
+(void)hideStrokeView:(StrokeView *)strokeView;
@end
