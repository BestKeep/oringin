//
//  FirstPageListViewController.m
//  UTOUU_TEST
//
//  Created by UTOUU on 15/9/8.
//  Copyright (c) 2015年 UTOUU. All rights reserved.
//

#import "FirstPageListViewController.h"
#import "FirstPageListCell.h"
#import "Masonry.h"
#import "FirstPageListDetailViewController.h"
#import "GoodsService.h"
#import "GoodsModel.h"
#import "UIScrollView+MJRefresh.h"
#import "UMSocialSnsService.h"
#import "UMSocialQQHandler.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "Userinfo.h"

#import "UTMessageView.h"
#import "LoadingView.h"
@interface FirstPageListViewController ()<UITableViewDelegate,UITableViewDataSource,GoodsListCellAction>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray * goodsList;

@end

@implementation FirstPageListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_03;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initView];
    [self getGoodsList];
}
#pragma mark -- 请求数据
-(void)getGoodsList{
    [LoadingView showLoadViewToView:self.view];
    __weak typeof(self)wSelf = self;
    [GoodsService getGoodsListWithListKey:self.listKey compeletion:^(id result, NSError *error) {
        [wSelf.tableView headerEndRefreshing];

        if(error){
            UTMessageView * messageView = [UTMessageView showEmptyMsgViewTo:self.view logoLabelText:@"" emptyText:@"加载失败" buttonTitle:@"重新加载" animationed:YES];
            [messageView setRetryBlock:^{
                [wSelf getGoodsList];
            }];
            
        }else{
            wSelf.goodsList = result;
            [wSelf reloadTableView];
        }
         [LoadingView hideLoadViewToView:wSelf.view];
    }];
}

- (void)initView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
     [_tableView addHeaderWithTarget:self action:@selector(refreshData)];
    _tableView.backgroundColor = [UIColor clearColor];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(7);
    }];
}

-(void)reloadTableView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}

-(void)refreshData{
    [self.goodsList removeAllObjects];
    [self getGoodsList];
}

#pragma mark -- tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstPageListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"pageListCell"];
    if (cell == nil) {
        cell = [[FirstPageListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pageListCell"];
    }
    GoodsModel * model;
    if (self.goodsList.count) {
        model = [self.goodsList objectAtIndex:indexPath.row];
    }
    return [cell cellHeightWithModel:model];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsList.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FirstPageListDetailViewController *firstPageDeatilVC = [[FirstPageListDetailViewController alloc] init];
    GoodsModel * model = [self.goodsList objectAtIndex:indexPath.row];
    firstPageDeatilVC.goods_no = model.goods_no;
    firstPageDeatilVC.title = model.goods_name;
    firstPageDeatilVC.readyBuy = model.status;
    [self.navigationController pushViewController:firstPageDeatilVC animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstPageListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"pageListCell"];
    if (cell == nil) {
        cell = [[FirstPageListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pageListCell"];
        cell.delegate = self;
    }
    if (self.goodsList.count) {
        cell.goodsModel = [self.goodsList objectAtIndex:indexPath.row];

    }
    return cell;
}

-(void)firstPageListCell:(FirstPageListCell *)cell action:(FirstPageListCellAction)action{
    if (action == FirstPageListCellActionShare) {
        
        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:cell.goodsModel.goods_image]];
        UIImage * shareImage = [UIImage imageWithData:imageData];
        [self shareVideo:shareImage model:cell.goodsModel];
    }
}

-(void)shareVideo:(UIImage *)image model:(GoodsModel *)model{
    
    if ([Common isLogin]) {
        NSString *shareurl = [NSString stringWithFormat:@"%@%@?%@%@",@"http://m.bestkeep.cn/invite/",[Userinfo getVisitor_code],@"goods_no=",model.goods_no];
        [UMSocialQQHandler setSupportWebView:YES];
        [UMSocialWechatHandler setWXAppId:@"wx12ade979ef648797" appSecret:@"f9b523512927f15249dad73161d21934" url:shareurl];
        //qq空间和qq好友
        [UMSocialQQHandler setQQWithAppId:@"1104759459" appKey:@"ymbLBKw0coxYre0r" url:shareurl];
        NSString *shareContent = @"Bestkeep,基于用户精准需求的专业导购型电商平台，彻底去除造成成本浪费的中间环节，让商品回归本来价值";
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"53fbf399fd98c5a48f01c81f"
                                          shareText:shareContent
                                         shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ, nil]
                                           delegate:nil];

    }else {
        LoginController *loginVC = [[LoginController alloc]init];
        BKNavigationController *nv = [[BKNavigationController  alloc] initWithRootViewController:loginVC];
        [self presentViewController:nv animated:YES completion:nil];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
