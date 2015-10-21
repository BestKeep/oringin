//
//  footerAccountView.h
//  BESTKEEP
//
//  Created by UTOUU on 15/8/21.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class footerAccountView;
@protocol FooterAccountViewDelegate <NSObject>

-(void)footerAccountView:(footerAccountView *)footerAccountView allSelectedButtonClicked:(UIButton *)allselectedButton;
-(void)footerAccountView:(footerAccountView *)footerAccountView moveToSaveButtonClicked:(UIButton *)moveToSaveButton;
-(void)footerAccountView:(footerAccountView *)footerAccountView deleteButtonClicked:(UIButton *)deleteButton;
-(void)footerAccountView:(footerAccountView *)footerAccountView calculateButtonClicked:(UIButton *)calculateButton;

@end


@interface footerAccountView : UIView //结算View

@property (nonatomic, strong) UILabel *label1; //全选Label

@property (nonatomic, strong) UILabel *label2;  //合计Label

@property (nonatomic, strong) UILabel *label3;  //金额

@property (nonatomic, strong) UILabel *label4;  //是否包含运费

@property (nonatomic, strong) UIButton *button1; // 全选按钮

@property (nonatomic, strong) UIButton *button2; // 结算

@property (nonatomic, strong) UIButton *moveSaveButton; // 移到收藏夹

@property (nonatomic, strong) UIButton *deleteButton; // 删除

@property (nonatomic,weak) id <FooterAccountViewDelegate>footerDelegate;

- (void)updateFooterAccountView:(BOOL)isEdit;

- (void)updateAllSelectedButtonSelected:(BOOL)isAllSelected;
@end