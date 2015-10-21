//
//  MySaveCollectionViewCell.h
//  BESTKEEP
//
//  Created by UTOUU on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

@class MySaveCollectionViewCell;

@protocol MYSaveCollectionViewDelegaet <NSObject>

-(void)mySaveCollectionView:(MySaveCollectionViewCell *)cell selectedButton:(UIButton *)selectedButton;

@end


@interface MySaveCollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) id<MYSaveCollectionViewDelegaet>mysaveCollectionDelegate;

@property (nonatomic , strong) UIButton* button1;

@property (nonatomic , strong) UIImageView* imageView1;

@property (nonatomic , strong) UILabel* label1;

@property (nonatomic , strong) UILabel* label2;

//@property (nonatomic , strong) UILabel* label3;



-(void)updateCellContentViewWithModel:(CollectionGoodsModel *)goodModel;

@end
