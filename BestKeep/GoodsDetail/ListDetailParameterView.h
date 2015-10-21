//
//  ListDetailParameterView.h
//  
//
//  Created by UTOUU on 15/9/21.
//
//

#import <UIKit/UIKit.h>

@interface ListDetailParameterView : UITableViewCell // 商品参数

@property (nonatomic , strong) UILabel* titleLabel;

@property (nonatomic , strong) UILabel* line;

//@property (nonatomic , strong) UILabel* sexLabel;
//
//@property (nonatomic , strong) UILabel*  attributeLabel1;
//
//@property (nonatomic , strong) UILabel*  attributeLabel2;
//
//@property (nonatomic , strong) UILabel*  attributeLabel3;


- (void)createDetailLabel:(NSMutableArray*)labelText;


@end
