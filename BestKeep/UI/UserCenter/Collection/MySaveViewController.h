//
//  MySaveViewController.h
//  BESTKEEP
//
//  Created by UTOUU on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySaveCollectionViewCell.h"
#import "MySaveFooterView.h"
#import "Masonry.h"

@interface MySaveViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UICollectionView* mySaveCollectionView;

@property (nonatomic , strong) MySaveCollectionViewCell* mySaveCollectionCell;

@property (nonatomic , strong) MySaveFooterView* mySaveFooterView;

@end
