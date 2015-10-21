//
//  TextCell.h
//  
//
//  Created by UTOUU on 15/10/13.
//
//

#import <UIKit/UIKit.h>

@interface TextCell : UITableViewCell  //详情页底部显示的文字

//- (void)createDetailTextView:(NSMutableArray*)textView;
@property(nonatomic , strong)UITextView* detailView;

@end
