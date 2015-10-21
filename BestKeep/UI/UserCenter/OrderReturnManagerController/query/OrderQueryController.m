//
//  OrderQueryController.m
//  BESTKEEP
//
//  Created by dcj on 15/8/25.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "OrderQueryController.h"
#import "UserCenterDefaultCell.h"
#import "UIView+Position.h"


@interface OrderQueryController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * queryTableView;

@end

@implementation OrderQueryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退换货查询";
    self.view.backgroundColor = COLOR_03;
    
    [self.view addSubview:self.queryTableView];
    // Do any additional setup after loading the view.
}

-(UITableView *)queryTableView{
    if (_queryTableView == nil) {
        _queryTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _queryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _queryTableView.backgroundColor  = [UIColor clearColor];
        _queryTableView.delegate = self;
        _queryTableView.dataSource = self;
    }
    return _queryTableView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCenterDefaultCell * defaultCell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
    if (defaultCell == nil) {
        defaultCell = [[UserCenterDefaultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
        defaultCell.backgroundColor = [UIColor whiteColor];
        defaultCell.contentView.backgroundColor = [UIColor whiteColor];
//        defaultCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        defaultCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == QueryControllerTableViewSectionTime) {
        defaultCell.textLabel.text = @"成交时间";
    }else if (indexPath.section == QueryControllerTableViewSectionReturnState){
        if (indexPath.row  == 0) {
            defaultCell.bcLeftTextlabel.text = @"退换货状态";
            defaultCell.bcRightTextLabel.text = @"全部";
        }else if (indexPath.row ==1){
            defaultCell.bcLeftTextlabel.text = @"退换货类型";
            defaultCell.bcRightTextLabel.text = @"全部";
        }
    }else{
        defaultCell.bcLeftTextlabel.text = @"订单搜索";
        defaultCell.bcRightTextLabel.text = @"输入订单号";
    }
    
    return defaultCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == QueryControllerTableViewSectionOrderQuery) {
        return 1;
    }else if (section ==QueryControllerTableViewSectionTime){
        return 1;
    }else if (section == QueryControllerTableViewSectionReturnState){
        return 2;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return QueryControllerTableViewSectionOrderQuery + 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == QueryControllerTableViewSectionTime) {
        return 5;
    }else{
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == QueryControllerTableViewSectionOrderQuery) {
        return 64;
    }else{
        return 0.00001;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == QueryControllerTableViewSectionOrderQuery) {
        return [self getQueryButton];
    }
    return nil;
}

-(UIView *)getQueryButton{
    
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.queryTableView.width, 64)];
    footView.backgroundColor = [UIColor clearColor];
    UIButton * queryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [queryButton setBackgroundColor:[UIColor colorWithString:@"#03b598"]];
    [queryButton setTitle:@"查询" forState:UIControlStateNormal];
    [queryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queryButton .titleLabel.font = [UIFont boldSystemFontOfSize:18];
    queryButton.layer.cornerRadius = 4;
    queryButton.clipsToBounds = YES;
    [queryButton addTarget:self action:@selector(queryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:queryButton];

    [queryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView.mas_left).mas_offset(10);
        make.right.equalTo(footView.mas_right).mas_offset(-10);
        make.height.equalTo(@(49));
        make.bottom.equalTo(footView.mas_bottom);
    }];
    
    return footView;
}

-(void)queryButtonClick:(UIButton *)queryButton{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
