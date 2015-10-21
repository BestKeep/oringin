//
//  BuyCarViewController.h
//  BESTKEEP
//
//  Created by UTOUU on 15/8/20.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyCarDetailCell.h"
#import "BuyCarSectionView.h"
#import "footerAccountView.h"

@interface BuyCarViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,cellButtonDetegate>

@property (nonatomic , strong) UITableView* buyCarTableView;
@property (nonatomic , strong) footerAccountView* footerAccountView;   //结算
@property (nonatomic , strong) BuyCarSectionView* buyCarSectionView;  //每一组的头部

@property (nonatomic , strong) NSMutableArray* sectionSourceArray;   //头部按钮选中状态数组
@property (nonatomic , strong) NSMutableArray* cellSourceArray;       //cell按钮选中状态数组

@property (nonatomic , strong) NSMutableArray* sectionBtnArray;    //每一组 头部 按钮的控件数组
@property (nonatomic , strong) NSMutableArray* cellBtnArray;       //每一组 cell 按钮的控件数组
@property (nonatomic , strong) NSMutableArray* editBtnArray;       //每一组 编辑、完成 按钮的控件数组






//- (void)cellDataSourceWithCellBtn:(BOOL)btnSelect andDetailView:(BOOL)isHidden andDataView:(BOOL)isApper andCellIndex:(NSIndexPath*)cellIndex;
//
//
//
//- (void)sectionDataSourceWithBtn:(BOOL)sectionBtn andGrayLine:(BOOL)isHidden andEditBtnSelected:(BOOL)editSelect withEditHidden:(BOOL)editHidden andSectionIndex:(NSInteger)sectionIndex;


@end
