//
//  BuyCarSectionView.h
//  BESTKEEP
//
//  Created by UTOUU on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BuyCarSectionView;
@protocol BuyCarSectionDelegate <NSObject>

-(void)sectionView:(BuyCarSectionView *)sectionView editButtonClick:(UIButton *)editButton;
-(void)sectionView:(BuyCarSectionView *)sectionView sectionButtonClick:(UIButton *)sectionButton;

@end


@interface BuyCarSectionView : UIView  //购物车每组的头部加载view

@property (nonatomic , strong)UIButton* sectionButton; //头部按钮
@property (nonatomic , strong)UILabel* sectionLabel;   //发货地址
@property (nonatomic , strong)UIImageView* sectionImageView;//全球购标致
@property (nonatomic , strong)UILabel* sectionLine;    //灰色线
@property (nonatomic , strong)UIButton* sectionEdit;   //编辑按钮
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,weak) id <BuyCarSectionDelegate>sectionDelegate;



@end

