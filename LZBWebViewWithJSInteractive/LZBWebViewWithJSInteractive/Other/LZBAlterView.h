//
//  LZBAlterView.h
//  自定义弹框-UIView
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZBAlterView;
/**
 *  三个按钮弹框的点击按钮的tag值
 */
typedef void(^alterBlock)(LZBAlterView *alterView, NSInteger btntag);




@interface LZBAlterView : UIView


/**
 *  自定义弹框文字 + 三个按钮（个数可选）
 *
 *  @param Text          标题文字
 *  @param btnOneTitle   第一个按钮的显示内容，可以为nil
 *  @param btnTwoTitle   第二个按钮的显示内容, 可以为nil
 *  @param btnThreeTitle 第三个按钮的显示内容, 可以为nil
 *  @param myblock       通过判断点击的tag值，block里面处理按钮的点击事件
 */
+ (LZBAlterView *)lzb_alterViewWithText:(NSString *)Text OneTitle:(NSString *)btnOneTitle  TwoTitle:(NSString *)btnTwoTitle ThreeTitle:(NSString *)btnThreeTitle handleBlock:(alterBlock )alterblock;




/**
 *   自定义弹框图片 + 文字 +三个按钮（个数可选）
 *
 *  @param imageName     图片名称
 *  @param errorText     文字提醒
 *  @param btnOneTitle   第一个按钮的显示内容, 可以为nil
 *  @param btnTwoTitle   第二个按钮的显示内容, 可以为nil
 *  @param btnThreeTitle 第三个按钮的显示内容, 可以为nil
 *  @param alterblock    通过判断点击的tag值，block里面处理按钮的点击事件
 */
+ (LZBAlterView *)lzb_alterViewWithImage:(NSString *)imageName ErrorText:(NSString *)errorText OneTitle:(NSString *)btnOneTitle  TwoTitle:(NSString *)btnTwoTitle ThreeTitle:(NSString *)btnThreeTitle  handleBlock:(alterBlock)alterblock;




/**
 *  设置正文和按钮的文字颜色和大小
 *
 *  @param color     正文颜色
 *  @param wordColor 按钮文字颜色
 *  @param textFont  正文字体大小
 *  @param WordFont  按钮文字大小
 */
- (void)lzb_setTextColor:(UIColor *)color BtnTitleColor:(UIColor *)wordColor  TextFont:(UIFont *)textFont BtnTitleFont:(UIFont *)WordFont;

/**
 *  移除弹框
 */
- (void)removeAlterView;

@end
