//
//  MySaveViewController.m
//  BESTKEEP
//
//  Created by UTOUU on 15/8/26.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "MySaveViewController.h"
#import "BKService.h"
#import "UTMessageView.h"
#import "MJRefresh.h"
#import "OneViewController.h"
#import "FirstPageListDetailViewController.h"

#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
@interface MySaveViewController ()<MYSaveCollectionViewDelegaet>
@property (nonatomic,strong) NSMutableArray * collectionListSource;

@property (nonatomic,assign) NSInteger page_no;


@end

@implementation MySaveViewController
{
    NSMutableArray* allCollectSelect;
    NSMutableArray* collectCellSelect;
    float  cellWidth;
    
    
    NSMutableArray *contacts;
    UIButton* editBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    
    self.page_no = 1;
    self.view.backgroundColor = RgbColor(234, 234, 234);
    
    allCollectSelect = [NSMutableArray new];
    collectCellSelect = [NSMutableArray new];
    
    
    contacts = [NSMutableArray array];
    for (int i = 0; i <150; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"NO" forKey:@"checked"];
        [contacts addObject:dic];
    }
    [self setEditButton];
    
    [self loadCollectionListWithPageSize:10 pag_no:self.page_no];
    [self initView];
}
-(void)setEditButton{
    editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [editBtn setFrame:CGRectMake(0, 0, 50, 25)];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editBtn];
}

-(NSMutableArray *)collectionListSource{
    if (_collectionListSource == nil) {
        _collectionListSource = [[NSMutableArray alloc] init];
    }
    return _collectionListSource;
}
-(void)loadCollectionListWithPageSize:(NSInteger)pageSize pag_no:(NSInteger)pag_no{
    __weak typeof(self)wSelf =self;
    [BKService GetGoodsCollectionlist:[NSString stringWithFormat:@"%ld",(long)pageSize] pageno:[NSString stringWithFormat:@"%ld",(long)pag_no] view:self.view callback:^(id obj, NSError *error) {
           

        if (error) {
            
        }else{
            wSelf.page_no = self.page_no+1;

            [self.collectionListSource addObjectsFromArray:obj];
            
            if (wSelf.collectionListSource.count == 0) {
                [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"\U0000e601" emptyText:@"暂无收藏商品" buttonTitle:nil animationed:YES];
            }else{
                [wSelf.mySaveCollectionView reloadData];
            }
        }
        [_mySaveCollectionView headerEndRefreshing];
        [_mySaveCollectionView footerEndRefreshing];

    }];
}

- (void)initView
{
    cellWidth = (self.view.bounds.size.width - 6)/2;
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    
    _mySaveCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _mySaveCollectionView.backgroundColor = RgbColor(234, 234, 234);
    [_mySaveCollectionView registerClass:[MySaveCollectionViewCell class] forCellWithReuseIdentifier:@"KCell"];
     _mySaveCollectionView.delegate = self;
     _mySaveCollectionView.dataSource = self;
     [self.view addSubview:_mySaveCollectionView];
    
    _mySaveFooterView = [[MySaveFooterView alloc] init];
    [_mySaveFooterView.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _mySaveFooterView.frame = CGRectMake( 0, self.view.bounds.size.height - 0.1, self.view.bounds.size.width, 50);
    [self.view addSubview:_mySaveFooterView];
    _mySaveFooterView.hidden = YES;
    
    
    [_mySaveCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
    }];
    [self setupRefresh];
}

-(void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_mySaveCollectionView addHeaderWithTarget:self action:@selector(refreshData)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_mySaveCollectionView addFooterWithTarget:self action:@selector(updataMore)];
}


-(void)updataMore{
    [self loadCollectionListWithPageSize:10 pag_no:self.page_no];
    
}
-(void)refreshData{
    self.page_no = 1;
    [self.collectionListSource removeAllObjects];
    
    if (editBtn.selected == YES) {
        [contacts removeAllObjects];
        for (int i = 0; i <150; i++) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:@"NO" forKey:@"checked"];
            [contacts addObject:dic];
        }
    
    for (CollectionGoodsModel * goods in self.collectionListSource) {
        goods.isSelected = NO;
    }
    for (UIButton* btn in allCollectSelect) {
        btn.selected = NO;
    }
        
        NSMutableArray * selectedModelArr = [self getAllSelectedModel];
        [_mySaveFooterView.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",(unsigned long)selectedModelArr.count] forState:UIControlStateNormal];
    
    }
    [self loadCollectionListWithPageSize:10 pag_no:self.page_no];

}
#pragma mark -- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionListSource.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"KCell";
    MySaveCollectionViewCell* cell = [_mySaveCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.button1.hidden = YES;
    cell.mysaveCollectionDelegate = self;
    cell.button1.tag = 50 + indexPath.row;
    cell.button1.userInteractionEnabled = NO;
    
    if (editBtn.selected == YES) {
        NSUInteger row = cell.button1.tag;
        NSMutableDictionary *dic = [contacts objectAtIndex:row];
        if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
            cell.button1.hidden = NO;
            cell.button1.selected = NO;
        }else {
            cell.button1.hidden = NO;
            cell.button1.selected = YES;
        }
    }
    [allCollectSelect addObject:cell.button1];
    
    
    if (self.collectionListSource.count > 0) {
        CollectionGoodsModel * model = [self.collectionListSource objectAtIndex:indexPath.row];
        [cell updateCellContentViewWithModel:model];
    }
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellWidth, 250);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 6;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
        
    if ([editBtn.currentTitle isEqualToString:@"编辑"]) {
        CollectionGoodsModel * model = [self.collectionListSource objectAtIndex:indexPath.row];
        FirstPageListDetailViewController *firstPageDeatilVC = [[FirstPageListDetailViewController alloc] init];
        firstPageDeatilVC.goods_no = model.goods_no;
        firstPageDeatilVC.title = model.goods_name;
        firstPageDeatilVC.readyBuy = model.status;
        [self.navigationController pushViewController:firstPageDeatilVC animated:YES];


        
    }
    if ([editBtn.currentTitle isEqualToString:@"完成"]) {
        CollectionGoodsModel * goods = [self.collectionListSource objectAtIndex:indexPath.row];

        NSUInteger row =  50 + indexPath.row;
        NSMutableDictionary *dic = [contacts objectAtIndex:row];
        if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
            [dic setObject:@"YES" forKey:@"checked"];
            goods.isSelected = YES;
        }else {
            [dic setObject:@"NO" forKey:@"checked"];
            goods.isSelected = NO;
        }
        MySaveCollectionViewCell *cell = (MySaveCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.button1.selected = !cell.button1.selected;
        
    NSMutableArray * selectedModelArr = [self getAllSelectedModel];
    [_mySaveFooterView.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",(unsigned long)selectedModelArr.count] forState:UIControlStateNormal];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}
- (void)deleteBtnClick:(UIButton*)sender //删除按钮
{
    NSMutableArray * selectedModelArr = [self getAllSelectedModel];
    if (selectedModelArr.count == 0) {
        [Common showAlertViewWith:@"" message:@"还没选择喔!"];
        return;
    }
    [BKService deleteCollectGoods:[self getSelectedOrdersId:selectedModelArr] view:nil callback:^(id obj,NSError* error) {
        [self refreshData];
    }];
}

-(NSString *)getSelectedOrdersId:(NSMutableArray *)orderArr{
    NSMutableArray * tempOrderIdArr = [[NSMutableArray alloc] init];
    for (CollectionGoodsModel * model in orderArr) {
        [tempOrderIdArr addObject:model.collect_id];
    }
    return [tempOrderIdArr componentsJoinedByString:@","];
}

-(NSMutableArray *)getAllSelectedModel{
    NSMutableArray * selectedModelArr = [[NSMutableArray alloc] init];
    [self.collectionListSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CollectionGoodsModel *tempModel = (CollectionGoodsModel *)obj;
        if (tempModel.isSelected) {
            [selectedModelArr addObject:tempModel];
        }
    }];
    return selectedModelArr;
}

- (void)editBtnClick:(UIButton*)sender  //编辑按钮
{
    if (sender.selected == NO) {
         [sender setTitle:@"完成" forState:UIControlStateNormal];
        
         _mySaveFooterView.hidden = NO;
        [UIView animateWithDuration:0.7
                         animations:^{
                             CGRect rect =  CGRectMake( 0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50);
                             _mySaveFooterView.frame = rect;
                         }
                         completion:^(BOOL finished) {
                            
                         }];
        
        for (UIButton* btn in allCollectSelect ) {
            btn.hidden = NO;
            btn.selected = NO;
        }
    }else{
        [sender setTitle:@"编辑" forState:UIControlStateNormal];

        [UIView animateWithDuration:0.7
                         animations:^{
                             CGRect rect =  CGRectMake( 0, self.view.bounds.size.height - 0.1, self.view.bounds.size.width, 50);
                             _mySaveFooterView.frame = rect;
                         }
                         completion:^(BOOL finished) {
                      _mySaveFooterView.hidden = YES;
                         }];
        
        for (UIButton* btn in allCollectSelect ) {
            btn.hidden = YES;
            btn.selected = NO;
        }
        
        [collectCellSelect removeAllObjects];
    }
    
    [_mySaveFooterView.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",(unsigned long)collectCellSelect.count] forState:UIControlStateNormal];
    
    sender.selected = !sender.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)mySaveCollectionView:(MySaveCollectionViewCell *)cell selectedButton:(UIButton *)selectedButton{}

@end
