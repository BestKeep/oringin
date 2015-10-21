//
//  ListDetailImageView.m
//  
//
//  Created by UTOUU on 15/9/18.
//
//

#import "ListDetailImageView.h"
#import "Masonry.h"


@implementation ListDetailImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _detailImageScroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _detailImageScroll.backgroundColor = [UIColor whiteColor];
        [self addSubview:_detailImageScroll];
        
        _detailImagePageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _detailImagePageControl.userInteractionEnabled = NO;
        [self addSubview:_detailImagePageControl];
        
        
        [_detailImageScroll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        }];

        [_detailImagePageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY).offset(70);
            make.width.mas_equalTo(@(SCREEN_WIDTH));
            make.height.mas_equalTo(@(30));
        }];
    }
    return self;
}
@end
