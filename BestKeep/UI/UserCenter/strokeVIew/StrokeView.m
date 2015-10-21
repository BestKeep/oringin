//
//  StrokeView.m
//  labelTest
//
//  Created by dcj on 15/8/26.
//  Copyright (c) 2015年 dcj. All rights reserved.
//

#import "StrokeView.h"
#import "Masonry.h"
#import "UIView+Position.h"

@implementation StrokeView

-(instancetype)initWithFrame:(CGRect)frame andBackImage:(UIImage *)backImage text:(NSString *)text  textColor:(UIColor *)textColor{
    frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    if (self = [super initWithFrame:frame]) {
        UIImageView * backImageView = [[UIImageView alloc] initWithImage:backImage];
        [self addSubview:backImageView];
        self.backImageView = backImageView;
    
        self.backgroundColor = [UIColor clearColor];
        UILabel * strokeLable = [[UILabel alloc] initWithFrame:self.bounds];
        strokeLable.text = text;
        strokeLable.font = [UIFont systemFontOfSize:8.5];
        strokeLable.textAlignment = NSTextAlignmentCenter;
        strokeLable.textColor = textColor;
        [self addSubview:strokeLable];
        self.strokeLabel = strokeLable;
    }
    return self;
}

-(void)updateStrokeViewWithText:(NSString *)text andBackImage:(UIImage *)backImage textColor:(UIColor *)textColor{
    self.hidden = NO;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, backImage.size.height, backImage.size.height);
    self.backImageView.width = backImage.size.width;
    self.backImageView.height = backImage.size.height;
    self.strokeLabel.width = backImage.size.width;
    self.strokeLabel.height = backImage.size.height;
    self.backImageView.backgroundColor = [UIColor clearColor];
    self.strokeLabel.textColor = textColor;
    self.backImageView.image = backImage;
    self.strokeLabel.text = text;
}

-(void)hideStrokeView{
    self.strokeLabel.text = @"";
    self.hidden = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
