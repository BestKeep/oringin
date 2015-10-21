//
//  BKNavigationController.m
//  BestKeep
//
//  Created by 魏鹏 on 15/8/19.
//  Copyright (c) 2015年 utouu. All rights reserved.
//

#import "BKNavigationController.h"

@interface BKNavigationController ()

@end

@implementation BKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0f green:180/255.0f blue:142/255.0f alpha:1];
    // Do any additional setup after loading the view.
}
-(void)popself
{
    [self popViewControllerAnimated:YES];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(0, 0, 25, 25);
        UILabel *deleteLabel = [[UILabel alloc] initWithFrame:rightButton.frame];
        deleteLabel.font=[UIFont fontWithName:@"iconfont" size:20];
        deleteLabel.textColor = [UIColor whiteColor];
        deleteLabel.text = @"\U0000e623";
        [rightButton addSubview:deleteLabel];
 
//        [rightButton setImage:[UIImage imageNamed:@"navback.png"] forState:UIControlStateNormal];
//        [rightButton setImage:[UIImage imageNamed:@"navback_click.png"] forState:UIControlStateHighlighted];
//        rightButton.contentMode = UIViewContentModeScaleAspectFill;
        [rightButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    }
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
