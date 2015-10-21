//
//  BKViewController.m
//  BESTKEEP
//
//  Created by 魏鹏 on 15/8/31.
//  Copyright (c) 2015年 YISHANG. All rights reserved.
//

#import "BKViewController.h"

@interface BKViewController ()

@end

@implementation BKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于BESTKEEP";
    self.view.backgroundColor = COLOR_08;
    self.logo_Image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_image.png"]];
    UIImage *logo_image = [UIImage imageNamed:@"logo_image.png"];
    [self.view addSubview:self.logo_Image];
    [self.logo_Image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).mas_offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(logo_image.size.width));
        make.height.equalTo(@(logo_image.size.height));
    }];
    
    self.version_label = [UILabel new];
    self.version_label.textColor = COLOR_09;
    self.version_label.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:self.version_label];
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    NSString *version = [NSString stringWithFormat:@"%@.%@",[infoDict objectForKey:@"CFBundleShortVersionString"],versionNum];
 
    self.version_label.text = [NSString stringWithFormat:@"版本号: %@",version];
    
    [self.version_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logo_Image.mas_bottom).mas_offset(15);
        make.centerX.equalTo(self.view.mas_centerX);
        
    }];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectZero];
    view1.backgroundColor = COLOR_09;
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).mas_offset(15);
        make.right.equalTo(self.view.mas_right).mas_offset(-15);
        make.top.equalTo(self.version_label.mas_bottom).mas_offset(15);
        make.height.equalTo(@(1));
    }];
    self.title_label = [UILabel new];
    self.title_label.text = @"bestkeep简介";
    self.title_label.textColor = COLOR_09;
    self.title_label.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:self.title_label];
    [self.title_label mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(view1.mas_bottom).mas_offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
       
    }];
    
    self.content_label = [UILabel new];
    self.content_label.text = @"[你身边的真人导购师]\n\n颠覆传统——还在抢团购抢优惠抢折扣？不用这么麻烦！开启协同共享消费新模式，你以为在消费，实际在赚钱，不用再剁手！\n\n 去中间化——货比三家不如只取一家！为你精心挑选一切商品，直接对接厂家，省略一切中间环节。随便怎么选，都是最低价的优质商品!\n\n真人导购——不知道自己该买什么？逼死选择困难症！bestkeep最专业的真人导购平台，跟着达人购物吧";
    self.content_label.font = [UIFont systemFontOfSize:12];
    self.content_label.textColor = COLOR_05;
    self.content_label.numberOfLines = 0;
    [self.view addSubview:self.content_label];
    [self.content_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).mas_offset(15);
        make.right.equalTo(self.view.mas_right).mas_offset(-15);
        make.top.equalTo(self.title_label.mas_bottom).mas_offset(20);
        
    }];



    
    


    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
