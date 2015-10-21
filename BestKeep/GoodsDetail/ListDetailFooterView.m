//
//  ListDetailFooterView.m
//  
//
//  Created by UTOUU on 15/9/21.
//
//

#import "ListDetailFooterView.h"
#import "Masonry.h"




@implementation ListDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor blackColor];
    
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
       // _shareButton.backgroundColor = [UIColor lightGrayColor];
        _shareButton.backgroundColor = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1];
        [self addSubview:_shareButton];
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.backgroundColor = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1];
        [self addSubview:_saveButton];
        self.shareLabel = [self setButtonImage:@"\U0000e617" color:COLOR_05];
        [self.shareButton addSubview:self.shareLabel];
        self.shareLabelText = [[UILabel alloc]initWithFrame:CGRectZero];
        self.shareLabelText.translatesAutoresizingMaskIntoConstraints=NO;
       // self.shareLabelText.backgroundColor = [UIColor redColor];
        self.shareLabelText.text = @"分享";
        self.shareLabelText.font = [UIFont systemFontOfSize:10];
        self.shareLabelText.textColor = [UIColor blackColor];
        [self.shareButton addSubview:self.shareLabelText];
        
        self.saveLabel = [self setButtonImage:@"\U0000e602" color:COLOR_05];
        [self.saveButton addSubview:self.saveLabel];
        self.saveLabelText = [[UILabel alloc]initWithFrame:CGRectZero];
        self.saveLabelText.translatesAutoresizingMaskIntoConstraints =NO;
        self.saveLabelText.font = [UIFont systemFontOfSize:10];
        //self.saveLabelText.backgroundColor = [UIColor redColor];
        self.saveLabelText.text = @"收藏";
         self.saveLabelText.textAlignment = NSTextAlignmentCenter;
        self.saveLabelText.textColor = [UIColor blackColor];
        [self.saveButton addSubview:self.saveLabelText];
        
        _addButton = [BuyCarButton new];
        [self addSubview:_addButton];
        
        
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyButton setBackgroundImage:[UIImage imageNamed:@"buy_image.png"] forState:UIControlStateNormal];
        [_buyButton setTitle:@"预购" forState:UIControlStateNormal];
        _buyButton.backgroundColor = COLOR_13;
        [self addSubview:_buyButton];
        
        [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.width.mas_equalTo(@(SCREEN_WIDTH/5.8));
            make.bottom.mas_equalTo(self.mas_bottom);
            make.top.mas_equalTo(self.mas_top);
        }];
        [self.shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.shareButton.mas_centerX).offset(0);
            make.width.mas_equalTo(@(25));
            make.height.mas_equalTo(@(25));
            make.top.mas_equalTo(self.shareButton.mas_top).offset(10);
        }];
        [self.shareLabelText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shareLabel.mas_left).offset(0);
            make.top.mas_equalTo(self.shareLabel.mas_bottom).offset(0);
            make.right.mas_equalTo(self.shareLabel.mas_right).offset(0);
            
        }];
        [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_shareButton.mas_right).offset(0.1);
            make.width.mas_equalTo(@(SCREEN_WIDTH/5.8));
            make.bottom.mas_equalTo(self.mas_bottom);
            make.top.mas_equalTo(self.mas_top);
        }];
        [self.saveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.saveButton.mas_centerX).offset(0);
            make.width.mas_equalTo(@(25));
            make.height.mas_equalTo(@(25));
            make.top.mas_equalTo(self.saveButton.mas_top).offset(10);
            
        }];
        [self.saveLabelText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.saveLabel.mas_left).offset(0);
            make.right.mas_equalTo(self.saveLabel.mas_right).offset(0);
            make.top.mas_equalTo(self.saveLabel.mas_bottom).offset(0);
        }];
        
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_saveButton.mas_right).offset(0);
            make.width.mas_equalTo(@(SCREEN_WIDTH/3 + 20));
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
        [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_addButton.mas_right).offset(0);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }
    return self;
}

-(UILabel*)setButtonImage:(NSString*)iconText color:(UIColor*)color{
    UILabel *iconLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    iconLabel.translatesAutoresizingMaskIntoConstraints=NO;
    UIFont *iconfont1 = [UIFont fontWithName:@"iconfont" size:20];
    iconLabel.font = iconfont1;
    iconLabel.textAlignment = NSTextAlignmentCenter;
    iconLabel.text = iconText;
    iconLabel.textColor = color;
    return iconLabel;
}

@end
