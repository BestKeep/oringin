//
//  UserInfoViewController.m
//  BESTKEEP
//
//  Created by dcj on 15/9/15.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserCentrerBaseCell.h"


@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray * baseInfoArray;
@property (nonatomic,strong) UITableView * userInfoTableView;


@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_03;
    self.title = @"我的资料";
    self.baseInfoArray = [[NSMutableArray alloc] initWithObjects:@"头像",@"昵称",@"性别",@"电话", nil];
    self.userInfoTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.userInfoTableView.backgroundColor = [UIColor clearColor];
    self.userInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userInfoTableView.delegate = self;
    self.userInfoTableView.dataSource = self;
    [self.view addSubview:self.userInfoTableView];
    [self.userInfoTableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.baseInfoArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCentrerBaseCell * defaultCell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
    if (defaultCell == nil) {
        defaultCell = [[UserCentrerBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaultCell"];
        defaultCell.backgroundColor = [UIColor clearColor];
        defaultCell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        defaultCell.selectionStyle=UITableViewCellSelectionStyleGray;

    }
    [defaultCell layoutUcAccessoryView];
    defaultCell.ucTextLabel.text = [self.baseInfoArray objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        defaultCell.accessoryImage = YES;
        [defaultCell.userImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.photo] placeholderImage:[UIImage imageNamed:@"default_head"]];
    }else if (indexPath.row == 1){
        defaultCell.ucRightTextLabel.text = self.userInfo.name;
    }else if (indexPath.row == 2){
        defaultCell.ucRightTextLabel.text = self.userInfo.pay_bind;
    }else if (indexPath.row == 3){
        defaultCell.ucRightTextLabel.text = self.userInfo.account;
    }

    return defaultCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCentrerBaseCell * selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCell.selected = NO;
}

-(void)updateHeadImage{

}
-(void)updateuserInfo{

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
