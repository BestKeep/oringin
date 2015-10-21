//
//  UIColor+BestKeep.h
//  BESTKEEP
//
//  Created by dcj on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BestKeep)
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert ;
+ (NSString *) changeUIColorToRGB:(UIColor *)color ;
- (UIImage*)createImage;

@end
