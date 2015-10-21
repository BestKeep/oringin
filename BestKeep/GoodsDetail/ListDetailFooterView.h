//
//  ListDetailFooterView.h
//  
//
//  Created by UTOUU on 15/9/21.
//
//

#import <UIKit/UIKit.h>
#import "BuyCarButton.h"

@interface ListDetailFooterView : UIView

@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) BuyCarButton *addButton;

@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic,strong) UILabel * shareLabel;
@property (nonatomic,strong) UILabel * shareLabelText;

@property (nonatomic, strong) UILabel * saveLabel;
@property (nonatomic, strong) UILabel * saveLabelText;
-(UILabel*)setButtonImage:(NSString*)iconText color:(UIColor*)color;


@end
