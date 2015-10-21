//
//  FirstPageSectionView.h
//  UTOUU_TEST
//
//  Created by UTOUU on 15/9/7.
//  Copyright (c) 2015年 UTOUU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Title;

@interface FirstPageSectionView : UICollectionReusableView   //每一组头部信息

@property(nonatomic , strong)UILabel* sectionLabel1;
@property(nonatomic , strong)UILabel* sectionLabel2;
@property(nonatomic , strong)UILabel* sectionLabel3;
@property(nonatomic,strong)Title *title_group;

@end
