//
//  ListDetailParameterView.m
//  
//
//  Created by UTOUU on 15/9/21.
//
//

#import "ListDetailParameterView.h"
#import "Masonry.h"

@implementation ListDetailParameterView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH,0.1);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createDetailLabel:(NSMutableArray*)labelText{
    if (labelText.count != 0) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.text = @"商品参数";
        _titleLabel.frame = CGRectMake(10, 5, 100, 45);
        [self addSubview:_titleLabel];
        
        _line = [UILabel new];
        _line.backgroundColor = [UIColor grayColor];
        _line.alpha = 0.5;
        _line.frame = CGRectMake(10, 50, SCREEN_WIDTH - 10, 0.5);
        [self addSubview:_line];
        
        for (int i = 0; i < labelText.count; i ++) {
            UILabel* label = [UILabel new];
            label.textColor = [UIColor grayColor];
            label.text = [NSString stringWithFormat:@"%@",labelText[i]];
            label.font = [UIFont systemFontOfSize:14.0];
            label.frame = CGRectMake(10, 50 + i * 25, SCREEN_WIDTH - 20, 30);
            [self addSubview:label];
        }
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, labelText.count * 25 + 50);
    }else{
        
    }
}
@end
