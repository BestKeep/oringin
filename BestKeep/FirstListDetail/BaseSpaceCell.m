//
//  BaseSpaceCell.m
//  BESTKEEP
//
//  Created by dcj on 15/10/16.
//  Copyright © 2015年 YISHANG. All rights reserved.
//

#import "BaseSpaceCell.h"

@implementation BaseSpaceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor =[UIColor clearColor];
        _bottomMargin = 10;
        [self initSubView];
    }
    return self;
}

-(void)initSubView{
    self.coustomContentView = [[UIView alloc] init];
    [self.contentView addSubview:self.coustomContentView];
    
    [self.coustomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(-_bottomMargin);
    }];
    
}

-(void)setBottomMargin:(CGFloat)bottomMargin{
    _bottomMargin = bottomMargin;
    [self.coustomContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(-_bottomMargin);
    }];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
