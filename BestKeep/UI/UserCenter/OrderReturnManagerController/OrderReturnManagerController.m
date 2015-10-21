//
//  OrderReturnManagerController.m
//  BESTKEEP
//
//  Created by dcj on 15/8/21.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "OrderReturnManagerController.h"
#import "OrderReturnCell.h"
#import "UIColor+CJCategory.h"
#import "OrderQueryController.h"//查询
@interface OrderReturnManagerController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * OrderReturnTableView;
@property (nonatomic,strong) NSMutableArray * orderList;


@end

@implementation OrderReturnManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"退换货管理";
    [self.view addSubview:self.OrderReturnTableView];
    [self.OrderReturnTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self.OrderReturnTableView reloadData];
    [self addRightButtonItem];
}

-(void)addRightButtonItem{
    UIButton * queryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    queryButton.frame = CGRectMake(0, 0, 40, 20);
    [queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [queryButton setTitle:@"查询" forState:UIControlStateNormal];
    [queryButton addTarget:self action:@selector(queryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    queryButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    queryButton.backgroundColor = [UIColor clearColor];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:queryButton];
    self.navigationItem.rightBarButtonItem = rightItem;

}

-(void)queryButtonClick:(UIButton *)sender{
    OrderQueryController * queryViewController = [[OrderQueryController alloc] init];
    [self.navigationController pushViewController:queryViewController animated:YES];
}

-(NSMutableArray *)orderList{
    if (_orderList == nil) {
        _orderList = [[NSMutableArray alloc] init];
    }
    return _orderList;
}

-(UITableView *)OrderReturnTableView{
    if (_OrderReturnTableView == nil) {
        _OrderReturnTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _OrderReturnTableView.backgroundColor = [UIColor clearColor];
        _OrderReturnTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _OrderReturnTableView.delegate = self;
        _OrderReturnTableView.dataSource = self;

    }
    return _OrderReturnTableView;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderReturnCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderReturnCell"];
    if (cell  == nil) {
        cell = [[OrderReturnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderReturnCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    [cell updateDataWithModel:nil];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
    return _orderList.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
