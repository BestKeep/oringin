//
//  UTMessageView.h
//  MobileUU
//
//  Created by dcj on 15/7/29.
//  Copyright (c) 2015年 Shanghai Pecker Network Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessageViewReloadDataDelegate <NSObject>

-(void)reloadData;

@end

@interface UTMessageView : UIView

/**
 *  加载失败显示信息
 */
@property (nonatomic, copy) NSString *text;
/**
 *  展示imageView默认隐藏 用logoLabel展示
 */
@property (nonatomic, strong) UIImageView *logoImgView;
/**
 *  展示字体库label
 */
@property (nonatomic,strong) UILabel * LogoLable;
/**
 *  加载失败信息展示label
 */
@property (nonatomic, strong) UILabel *msLabel;
/**
 *  通过字体库 设置加载失败logo
 */
@property (nonatomic,copy) NSString * logoLableText;

/**
 *  重试 或者go button
 */
@property (nonatomic,strong) UIButton * retryButton;

/**
 *  从新刷新block 或者去某个页面
 */
@property (nonatomic, copy) void(^retryBlock)();
/**
 *  <#Description#>
 *
 *  @param view     <#view description#>
 *  @param text     <#text description#>
 *  @param animated <#animated description#>
 *
 *  @return <#return value description#>
 */
//
//+ (UTMessageView *)showMSGAddedTo:(UIView *)view
//                             text:(NSString*)text
//                         animated:(BOOL)animated
//                   reloadDelegate:(id<MessageViewReloadDataDelegate>)reLoadDelegate;
///**
// *  显示messageview
// *
// *  @param view     显示在某个view
// *  @param text     显示信息
// *  @param xoffset  messageView偏移
// *  @param yoffset  向下偏移
// *  @param animated 是否需要动画
// *
// *  @return 返回这个messageView
// */
//+ (UTMessageView *)showMSGAddedTo:(UIView *)view
//                             text:(NSString*)text
//                          xOffset:(float)xoffset
//                          yOffset:(float)yoffset
//                         animated:(BOOL)animated
//                   reloadDelegate:(id<MessageViewReloadDataDelegate>)reLoadDelegate;
//
///**
// *  隐藏messageView
// *
// *  @param view     messageView所在view
// *  @param animated 是否动画
// */
//+ (void)hideMSGForView:(UIView *)view
//              animated:(BOOL)animated;
//
//
///**
// *  加载失败messageVIew
// *
// *  @param view     <#view description#>
// *  @param animated <#animated description#>
// *
// *  @return <#return value description#>
// */
//+(UTMessageView *)showLoadFaildMSGAddedTo:(UIView *)view
//                                 animated:(BOOL)animated
//                           reloadDelegate:(id<MessageViewReloadDataDelegate>)reLoadDelegate;
//
//
//
///**
// *  网络失去连接messageVIew
// *
// *  @param view      <#view description#>
// *  @param emptyText <#emptyText description#>
// *  @param animated  <#animated description#>
// *
// *  @return <#return value description#>
// */
//+ (UTMessageView *)showNoConnectMsgAddedTo:(UIView *)view
//                                  withText:(NSString*)emptyText
//                                  animated:(BOOL)animated
//                            reloadDelegate:(id<MessageViewReloadDataDelegate>)reLoadDelegate;


+ (UTMessageView *)showEmptyMsgViewTo:(UIView *)view
                        logoLabelText:(NSString *)logoLabelTest
                            emptyText:(NSString *)emptyText
                          buttonTitle:(NSString *)buttonTitle
                          animationed:(BOOL)animated;



@end
