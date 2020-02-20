//
//  BTAlertView.h
//  BiT
//
//  Created by dingqiankun on 2018/5/30.
//  Copyright © 2018年 LEI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QKAlertView : UIView

@property (nonatomic,strong) UIColor *titleColor;    //设置 alertView Title颜色

@property (nonatomic,strong) UIFont *titleFont;    //设置 alertView Title字体

@property (nonatomic,strong) UIColor *messageLblColor;    //设置alertView  中间message 字体颜色 ---> alertView默认纯文本有效

@property (nonatomic,strong) UIFont *messageLblFont;    //设置alertView  中间message 字体大小 ---> alertView默认纯文本有效

@property (nonatomic,strong) UIColor *messageTxtColor;    //设置alertView  中间message 字体颜色 ---> alertView UITextField样式有效

@property (nonatomic,strong) UIFont *messageTxtFont;    //设置alertView  中间message 字体大小 ---> alertView UITextField样式有效

@property (nonatomic,assign) BOOL secureTextEntry;    //设置alertView  密码类型文本框 ---> alertView UITextField样式有效

@property (nonatomic,assign) BOOL tapMaskLayerDissmiss;   //单击遮罩层关闭弹窗  默认为NO:不关闭; YES:关闭



/**
 系统默认状态下纯文本的alertView

 @param title 标题
 @param message 信息内容
 @param otherButtonTitles 按钮标题
 @return alertView
 */
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
       buttonTitles:(NSString *)otherButtonTitles,... NS_REQUIRES_NIL_TERMINATION;


/**
 UITextField 样式的Alert

 @param title 标题
 @param placeholder 占位符
 @param otherButtonTitles 按钮标题
 @return alertView
 */
- (id)initWithTitle:(NSString *)title
            placeholder:(NSString *)placeholder
       buttonTitles:(NSString *)otherButtonTitles,... NS_REQUIRES_NIL_TERMINATION;


/**
 自定义视图AlertView

 @param title 标题
 @param customView 自定义的视图
 @param otherButtonTitles 按钮标题
 @return alertView
 */
- (id)initWithTitle:(NSString *)title
        customView:(UIView *)customView
       buttonTitles:(NSString *)otherButtonTitles,... NS_REQUIRES_NIL_TERMINATION;

/**
    自定义视图无标题
    @param customView 自定义的视图
    @param otherButtonTitles 按钮标题
    @return alertView
 */
- (id)initWithCustomView:(UIView *)customView
            buttonTitles:(NSString *)otherButtonTitles,... NS_REQUIRES_NIL_TERMINATION;

/**
 显示 alertView

 @param completeBlock 回调
 */
-(void)showWithCompletion:(void (^)(NSInteger index, NSString *msg))completeBlock;

/**
 *  关闭视图
 */
-(void)closeView;


/***************************  以下自定义按钮属性  ************************************/

/**
 设置按钮颜色   按先后顺序依次显示

 @param colors 颜色值
 */
- (void)setOtherButtonTitleColors:(UIColor *)colors,...NS_REQUIRES_NIL_TERMINATION;

/**
 设置按钮字体   按先后顺序依次显示

 @param fonts 字体值
 */
- (void)setOtherButtonTitleFonts:(UIFont *)fonts,...NS_REQUIRES_NIL_TERMINATION;


@end
