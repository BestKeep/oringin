//
//  EICheckBox.m
//  EInsure
//
//  Created by ivan on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import "RegisterButton.h"

#define Q_CHECK_ICON_WH                    (20.0)
#define Q_ICON_TITLE_MARGIN                (5.0)

@implementation RegisterButton

@synthesize delegate = _delegate;
@synthesize checked = _checked;
@synthesize userInfo = _userInfo;

- (id)initWithDelegate:(id)delegate {
    self = [super init];

    if (self) {
        _delegate = delegate;
        
        self.exclusiveTouch = YES;
//        UILabel *fo= [[UILabel alloc]init];
//        fo.frame =CGRectMake(0, 0, 20, 20);
//        fo.font=[UIFont fontWithName:@"iconfont" size:20];
//        fo.text =@"\U0000e628";
//        [self addSubview:fo];
        
        
        //[self setTitle:fo.text forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"iconfont-square"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"iconfont-squarecheckfill"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setChecked:(BOOL)checked groupId:(NSString*)groupId{
    if (_checked == checked) {
        return;
    }
    
    _checked = checked;
    self.selected = checked;
    _groupID = groupId;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:groupId:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected groupId:_groupID];
    }
}

- (void)checkboxBtnChecked {
    self.selected = !self.selected;
    _checked = self.selected;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:groupId:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected groupId:_groupID];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, Q_CHECK_ICON_WH, Q_CHECK_ICON_WH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(Q_CHECK_ICON_WH + Q_ICON_TITLE_MARGIN+20, 0,
                      CGRectGetWidth(contentRect) - Q_CHECK_ICON_WH - Q_ICON_TITLE_MARGIN,
                      CGRectGetHeight(contentRect));
}

- (void)dealloc {
    [_userInfo release];
    _delegate = nil;
    [super dealloc];
}

@end
