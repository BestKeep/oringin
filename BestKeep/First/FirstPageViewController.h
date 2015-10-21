//
//  FirstPageViewController.h
//  UTOUU_TEST
//
//  Created by UTOUU on 15/9/7.
//  Copyright (c) 2015年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, GoodsType) {
    TopType = 0,
    GlobalType,
    TShirtType
};

@interface FirstPageViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//@property (nonatomic , strong) UICollectionView* TOP_CollectionView;
//@property (nonatomic , strong) UICollectionView* BuyEarth_CollectionView;
//@property (nonatomic , strong) UICollectionView* TSHIRT_CollectionView;

@property (nonatomic , strong) UICollectionView* fristCollectionView;
@property (nonatomic) NSInteger goodsType;


@end
