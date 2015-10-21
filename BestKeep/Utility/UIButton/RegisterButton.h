//
//  EICheckBox.h
//  EInsure
//
//  Created by ivan on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCheckBoxDelegate;

@interface RegisterButton : UIButton {
    id<QCheckBoxDelegate> _delegate;
    BOOL _checked;
    id _userInfo;
    NSString *_groupID;
}

@property(nonatomic, assign)id<QCheckBoxDelegate> delegate;
@property(nonatomic, assign)BOOL checked;
@property(nonatomic, retain)id userInfo;

- (id)initWithDelegate:(id)delegate;

@end

@protocol QCheckBoxDelegate <NSObject>

@optional

- (void)didSelectedCheckBox:(RegisterButton *)checkbox checked:(BOOL)checked groupId:(NSString*)groupId;

@end
