//
//  WPTextField.m
//  UTOUU
//
//  Created by 魏鹏 on 15/5/13.
//  Copyright (c) 2015年 utouu. All rights reserved.
//

#import "WPTextField.h"

@implementation WPTextField
-(id)initWithFrame:(CGRect)frame Icon:(UIImageView*)icon;{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftView = icon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}
-(CGRect) leftViewRectForBounds:(CGRect)bounds {
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 20;// 右偏5
    return iconRect;
}
@end
