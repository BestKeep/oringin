//
//  BuyCarButton.m
//  
//
//  Created by UTOUU on 15/10/20.
//
//

#import "BuyCarButton.h"

@interface BuyCarButton ()
{
    CGRect boundingRect;
    
}

@end

@implementation BuyCarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self setTitle:@"加入购物车" forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.backgroundColor = COLOR_14;
        [self setImage:[UIImage imageNamed:@"iconfont-cartfill"] forState:UIControlStateNormal];
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 10;
    CGFloat imageY=14;
    CGFloat width=self.frame.size.height/2;
    CGFloat height=self.frame.size.height/2;
    return CGRectMake(imageX, imageY, width, height);
    
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = self.frame.size.height/2 + 20;
    CGFloat imageY=14;
    CGFloat width=self.frame.size.width - self.frame.size.height/2 - 20;
    CGFloat height=25;
    return CGRectMake(imageX, imageY, width, height);
}

@end
