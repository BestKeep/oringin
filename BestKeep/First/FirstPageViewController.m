//
//  FirstPageViewController.m
//  UTOUU_TEST
//
//  Created by UTOUU on 15/9/7.
//  Copyright (c) 2015年 UTOUU. All rights reserved.
//

#import "FirstPageViewController.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "FirstPageHeaderView.h"
#import "TOP_CollectionViewCell.h"
#import "TSHIRT_CollectionViewCell.h"
#import "FirstPageSectionView.h"
#import "FirstPageListViewController.h"
#import "HOME.h"
#import "Title.h"
#import "List.h"
#import "FirstPageListDetailViewController.h"
#import "GoodsService.h"
#import "goodStatusModel.h"

#import "UTMessageView.h"
#import "LoadingView.h"
#import "ManagerSetting.h"
#import "PassportService.h"
#import "Result.h"

#define SCROLLVIEW_TAG  1001
#define SCREENHIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define RgbColor(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
@interface FirstPageViewController ()

@property (nonatomic,assign) NSInteger page_no;
@property (nonatomic,strong) NSArray* dataSourceShow;
@property (nonatomic,strong) NSArray* dataSourceTop;
@property (nonatomic,strong) NSArray* dataSourceGlobal;
@property (nonatomic,strong) NSArray* dataSourceTshirt;
@property (nonatomic,strong) NSMutableArray *statu_array;
@property (nonatomic,strong) NSMutableArray *status_array;
@property (nonatomic,strong) HOME *home;
@end

@implementation FirstPageViewController
{
    UIScrollView* firstPageScrollView;
    FirstPageHeaderView* headerView;
    UILabel* footerLabel;
    UIImageView *imageView;

}
-(void)setNavBarImage{
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];//初始化图片视图控件
    imageView.contentMode = UIViewContentModeScaleAspectFit;//设置内容样式,通过保持长宽比缩放内容适应视图的大小,任何剩余的区域的视图的界限是透明的。
    UIImage *image = [UIImage imageNamed:@"NavImage.png"];//初始化图像视图
    [imageView setImage:image];
    self.navigationItem.titleView = imageView;//设置导航栏的titleView为imageView
}

-(void)getdata{
    [LoadingView showLoadViewToView:self.view];
    __weak typeof(self)wSelf = self;
    [BKService GoodsHomeView:self.view CompeletionCallBack:^(id obj, NSError *error) {
        if (error) {
            UTMessageView * messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"" emptyText:@"加载失败" buttonTitle:@"重新加载" animationed:YES];
            [messageView setRetryBlock:^{
                [wSelf getdata];
            }];
            
        }else{
            [wSelf.statu_array removeAllObjects];
            [wSelf.status_array removeAllObjects];
            wSelf.home = obj;
            
            switch (wSelf.goodsType) {
                case TopType:
                    wSelf.dataSourceShow = wSelf.home.top;
                    break;
                case GlobalType:
                    wSelf.dataSourceShow = wSelf.home.global;
                    break;
                case TShirtType:
                    wSelf.dataSourceShow = wSelf.home.tshirt;
                    break;
                    
                default:
                    wSelf.dataSourceShow = wSelf.home.top;
                    break;
            }
            [_fristCollectionView reloadData];
        }
         [LoadingView hideLoadViewToView:wSelf.view];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.statu_array = [NSMutableArray new];
    self.status_array = [NSMutableArray new];
    [self setNavBarImage];
    [self initView];
    [self getdata];
    [self checkVersion];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)initView
{
    headerView = [[FirstPageHeaderView alloc] init];
    [headerView.TOP_Button addTarget:self action:@selector(TOP_ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    headerView.TOP_Button.selected = YES;
    [headerView.BuyEarth_Button addTarget:self action:@selector(BuyEarth_ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView.TSHIRT_Button addTarget:self action:@selector(TSHIRT_ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headerView];
    
    footerLabel = [UILabel new];
    footerLabel.backgroundColor = RgbColor(2, 162, 123);
    footerLabel.alpha = 0.7;
    footerLabel.frame = CGRectMake(0, 48, SCREENWIDTH/3, 2);
    [headerView addSubview:footerLabel];

    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.height.mas_equalTo(@(50));
    }];
    
    UICollectionViewFlowLayout *TOP_flowLayout= [[UICollectionViewFlowLayout alloc]init];
    TOP_flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    _fristCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:TOP_flowLayout];
    _fristCollectionView.backgroundColor = RgbColor(234, 234, 234);
    [_fristCollectionView registerClass:[TOP_CollectionViewCell class] forCellWithReuseIdentifier:@"TOPCell"];
    _fristCollectionView.delegate = self;
    _fristCollectionView.dataSource = self;
    _fristCollectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 50- 49);
    [self.view addSubview:_fristCollectionView];
    
     [_fristCollectionView registerClass:[FirstPageSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    TOP_flowLayout.headerReferenceSize = CGSizeMake(SCREENWIDTH, 45);
    
    [_fristCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(@(self.view.bounds.size.width));
        make.top.mas_equalTo(headerView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [self setupRefresh];
}

-(void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_fristCollectionView addHeaderWithTarget:self action:@selector(refreshData)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    //[_fristCollectionView addFooterWithTarget:self action:@selector(updataMore)];
}
-(void)updataMore{
   // [self loadCollectionListWithPageSize:10 pag_no:self.page_no];
    
}
-(void)refreshData{
    [self getdata];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [_fristCollectionView headerEndRefreshing];
        //[_fristCollectionView reloadData];
    });
   [_fristCollectionView reloadData];
}
- (void)TOP_ButtonClick:(UIButton*)sender  // TOP
{
    if ([sender isSelected]) {
        return ;
    }
    footerLabel.frame = CGRectMake(0,48, SCREENWIDTH/3, 2);
    [headerView.BuyEarth_Button setSelected:NO];
    [headerView.TSHIRT_Button setSelected:NO];
    [firstPageScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    sender.selected = !sender.selected;
    
    if (self.dataSourceShow.count>0) {
        self.dataSourceShow = self.home.top;
        self.goodsType = TopType;
    }
    [_fristCollectionView reloadData];
}
- (void)BuyEarth_ButtonClick:(UIButton*)sender // 全球购
{
    if ([sender isSelected]) {
        return ;
    }
    footerLabel.frame = CGRectMake(SCREENWIDTH/3,48, SCREENWIDTH/3, 2);
    [headerView.TOP_Button setSelected:NO];
    [headerView.TSHIRT_Button setSelected:NO];
    [firstPageScrollView setContentOffset:CGPointMake(self.view.bounds.size.width, 0) animated:YES];
    sender.selected = !sender.selected;
    if (self.dataSourceShow.count>0) {
        self.dataSourceShow = self.home.global;
        self.goodsType = GlobalType;
    }
    [_fristCollectionView reloadData];
}
- (void)TSHIRT_ButtonClick:(UIButton*)sender  // T-SHIRT
{
    if ([sender isSelected]) {
        return ;
    }
    footerLabel.frame = CGRectMake(SCREENWIDTH/3 * 2,48, SCREENWIDTH/3, 2);
    [headerView.TOP_Button setSelected:NO];
    [headerView.BuyEarth_Button setSelected:NO];
    [firstPageScrollView setContentOffset:CGPointMake(self.view.bounds.size.width*2, 0) animated:YES];
    sender.selected = !sender.selected;
    
    if (self.dataSourceShow.count>0) {
        self.dataSourceShow = self.home.tshirt;
        self.goodsType = TShirtType;
    }
    [_fristCollectionView reloadData];
}

#pragma mark -- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    Title *title = [self.dataSourceShow objectAtIndex:section];
        return title.list.count;

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSourceShow.count ;
  }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _fristCollectionView) {
        static NSString * CellIdentifier = @"TOPCell";
        TOP_CollectionViewCell* cell = [_fristCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        Title *title = [self.dataSourceShow objectAtIndex:indexPath.section];
        List *list = [title.list objectAtIndex:indexPath.row];
        cell.TOP_label1.text = list.title;
        cell.TOP_label2.text = list.text_ad;
        [cell.TOP_imageView sd_setImageWithURL:[NSURL URLWithString:list.face_image] placeholderImage:[UIImage imageNamed:@"default"]];
//        for (goodStatusModel *gs in self.status_array) {
//            if(![gs.goodsNo isEqualToString:list.goods_no]){
//                break ;
//            }else{
        
        
                if ([list.status isEqualToString:@"0"]) {
                    cell.state_imageView.image = [UIImage imageNamed:@"icon_no_buy.png"];
                }
                else if ([list.status isEqualToString:@"1"]){
                    cell.state_imageView.image = [UIImage imageNamed:@"icon_purchase_goods.png"];
                }
                else if ([list.status isEqualToString:@"2"]){
                    cell.state_imageView.image = [UIImage imageNamed:@"icon_no_goods.png"];
                }else if ([list.status isEqualToString:@"3"]){
                    cell.state_imageView.image = [UIImage imageNamed:@"icon_purchase_goods.png"];
                }
                else{
                    cell.state_imageView.image = [UIImage imageNamed:@""];
                }
        
//        }
        
        return cell;
    }
    return nil;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FirstPageSectionView* TOP_headerView;
    if (kind == UICollectionElementKindSectionHeader) {
        TOP_headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        Title *title = [self.dataSourceShow objectAtIndex:indexPath.section];
        TOP_headerView.sectionLabel3.text = title.group;
        return TOP_headerView;
    }
    return nil;
}
#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.bounds.size.width - 6)/2, 250);
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
    Title *title = [self.dataSourceShow objectAtIndex:indexPath.section];
    List *list = [title.list objectAtIndex:indexPath.row];
    if ([list.list_key isEqualToString:@""] || list.list_key == nil) {
        FirstPageListDetailViewController *firstDetailVC = [[FirstPageListDetailViewController alloc] init];
        firstDetailVC.goods_no = list.goods_no;
        firstDetailVC.title = list.title;
        firstDetailVC.readyBuy = list.status;
        [self.navigationController pushViewController:firstDetailVC animated:YES];
    }else{
        FirstPageListViewController* firstPageListVC = [[FirstPageListViewController alloc] init];
        firstPageListVC.listKey = list.list_key;
        firstPageListVC.title = list.title;
        firstPageListVC.readyBuy = list.status;
        [self.navigationController pushViewController:firstPageListVC animated:YES];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)checkVersion{
    
    if ([Common isLogin]) {
        
        NSString *app_Version = [Common getAppVersion];
        NSDictionary *param_dic = [NSDictionary dictionaryWithObjectsAndKeys:app_Version,@"version", nil];
        
        [PassportService checkOutVersionnext:param_dic :^(id obj,NSError* error) {
            
            Result * version_result  = [[Result alloc]init];
            
            version_result = (Result *)obj;
            
            if (version_result.success) {
                
                NSMutableDictionary *result_dic = (NSMutableDictionary *)version_result.data;
                
                //  NSDictionary *data_dic = [result_dic objectForKey:@"data"];
                NSString *isupdate = [[result_dic objectForKey:@"upgrade"] stringValue];
                [ManagerSetting setversionUrl:[result_dic objectForKey:@"url"]];
                if ([isupdate isEqualToString:@"1"]) {
                    BOOL isforce = [[result_dic objectForKey:@"force"] boolValue];
                    NSString *message = [result_dic objectForKey:@"upgrade_msg"];
                    if (isforce) {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"版本更新" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        
                        alertView.delegate = self;
                        alertView.tag = 100;
                        [alertView show];
                    }
                    else{
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"版本更新" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                        
                        alertView.tag = 200;
                        alertView.delegate = self;
                        [alertView show];
                    }
                }else{
                    
                }
                
            }
            
        }];
        
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ManagerSetting getversionUrl]]];
        
        exit(0);
    }else if(alertView.tag == 200){
        
        switch (buttonIndex) {
            case 0:
                //   [[NSNotificationCenter defaultCenter]removeObserver:self];
                return;
                break;
            case 1:{
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[ManagerSetting getversionUrl]]]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ManagerSetting getversionUrl]]];
                    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
                    exit(0);
                }
                break;
            default:
                break;
            }
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
