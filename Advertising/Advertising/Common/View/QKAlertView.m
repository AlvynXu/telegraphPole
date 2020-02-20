//
//  BTAlertView.m
//  BiT
//
//  Created by dingqiankun on 2018/5/30.
//  Copyright © 2018年 LEI. All rights reserved.
//

#import "QKAlertView.h"

typedef NS_ENUM(NSInteger, BTAlertViewStyle)
{
    BTAlertViewStyleDefault = 0,
    BTAlertViewStyleText,
    BTAlertViewStyleCustom,
    BTAlertViewStyleAllCustom,
};

/**************************** alertView  默认属性 ******************************/

#define alertSpecLineColor kHexColor(0xC3C7CD)       //线条颜色

#define alertTitleColor  kHexColor(0x1D2C56)        //标题颜色

#define alertTitleFont  kBoldFont(18)   //标题字体大小

#define alertBtnFont kBoldFont(16)    //按钮字体大小

#define alertSureBtnColor kMainColor   //确定按钮标题颜色

#define alertCancelBtnColor kHexColor(0xA5AFBD)   //取消按钮标题颜色

#define alertContentColor kHexColor(0x1D2C56)       //内容字体颜色

#define alertContentLblFont kSysFont(12)       // 内容字体大小  枚举：BTAlertViewStyleDefault

#define alertContentTextFont kSysFont(16)       // 内容字体大小  枚举：BTAlertViewStyleText

#define alertMaskColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]    //遮罩颜色


@interface QKAlertView ()

@property (nonatomic,assign) BTAlertViewStyle alertStyle;

/**************************** 私有视图 ******************************/

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UILabel *titleLbl;  //标题

@property (nonatomic,strong) UILabel *messageLbl;  //消息

@property (nonatomic,strong) UITextField *inputTxt;  //输入框

@property (nonatomic,strong) UIView *customView;   //自定义视图

@property (nonatomic,strong) UIView *horizontalLine;   //横线条


/*****************************内部数据*****************************/

@property (nonatomic,strong) NSMutableArray *buttonArray;

@property (nonatomic,copy) void (^alertViewCompleteBlock)(NSInteger index, NSString *msg);

@property (nonatomic,assign) CGFloat contentAllWidth;

@property (nonatomic,assign) CGFloat centerAllWidth;

@property (nonatomic,assign) BOOL show;  //判断当前alertView 是否是显示状态


/*****************************外部信息保存*****************************/

@property (nonatomic, copy) NSString *titleStr;   //标题

@property (nonatomic, copy) NSString *contentStr;  //内容

@end

@implementation QKAlertView

static NSInteger btnTag = 200;


- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
       buttonTitles:(NSString *)otherButtonTitles,... NS_REQUIRES_NIL_TERMINATION
{
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.backgroundColor = alertMaskColor;
    if(self){
        self.titleStr = title;
        self.contentStr = message;
        _alertStyle = BTAlertViewStyleDefault;
        va_list args;
        va_start(args, otherButtonTitles);
        _buttonArray = [[NSMutableArray alloc] initWithCapacity:10];
        for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*)){
            [_buttonArray addObject:str];
        }
        va_end(args);
        [self setup];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
        placeholder:(NSString *)placeholder
       buttonTitles:(NSString *)otherButtonTitles,... NS_REQUIRES_NIL_TERMINATION
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.backgroundColor = alertMaskColor;
    if(self){
        self.contentStr = placeholder;
        self.titleStr = title;
        _alertStyle = BTAlertViewStyleText;
        
        va_list args;
        va_start(args, otherButtonTitles);
        _buttonArray = [[NSMutableArray alloc] initWithCapacity:10];
        for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*)){
            [_buttonArray addObject:str];
        }
        va_end(args);

        [self setup];
    }
    
    
    return self;
}

- (id)initWithTitle:(NSString *)title
         customView:(UIView *)customView
       buttonTitles:(NSString *)otherButtonTitles,... NS_REQUIRES_NIL_TERMINATION
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.backgroundColor = alertMaskColor;
    if(self){
        self.titleStr = title;
        self.customView = customView;
        _alertStyle = BTAlertViewStyleCustom;
        va_list args;
        va_start(args, otherButtonTitles);
        _buttonArray = [[NSMutableArray alloc] initWithCapacity:10];
        for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*)){
            [_buttonArray addObject:str];
        }
        va_end(args);
        [self setup];
    }
    return self;
}

- (id)initWithCustomView:(UIView *)customView
            buttonTitles:(NSString *)otherButtonTitles,... NS_REQUIRES_NIL_TERMINATION
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.backgroundColor = alertMaskColor;
    if(self){
        self.customView = customView;
        _alertStyle = BTAlertViewStyleAllCustom;
        va_list args;
        va_start(args, otherButtonTitles);
        _buttonArray = [[NSMutableArray alloc] initWithCapacity:10];
        for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*)){
            [_buttonArray addObject:str];
        }
        va_end(args);
        [self setup];
    }
    return self;
}

/**
 初始化
 */
- (void)setup
{
    CGFloat contentViewWidth = kScreenWidth * 311 / 375;    //弹窗宽度
    self.contentAllWidth = contentViewWidth;
    CGFloat centerWidth = (contentViewWidth - 16 * 2);      //中间内容宽度
    self.centerAllWidth = centerWidth;
    
    CGFloat topMargin = 16.f;        //顶部间距
    UIView * tempView = nil;
    CGFloat btnHeight = 47.0f; // 高度固定等于47
    CGFloat btnPadding = 0.5f;    //按钮间的间距
    CGFloat inputTextHeight = 44.f;  //文本输入框的高度
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handTapAction)];
    [self addGestureRecognizer:tapGesture];
    
    
    self.contentView = [[UIView alloc] init];
    self.contentView.layer.cornerRadius = 10.f;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(contentViewWidth));
    }];
    
    //添加头部标题
    self.titleLbl = [[UILabel alloc] init];
    self.titleLbl.text = self.titleStr;
    self.titleLbl.font = [UIFont boldSystemFontOfSize:18];
    self.titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLbl];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(@(topMargin));
//        make.height.equalTo(@(titleLblHeight));
        make.width.equalTo(self.contentView.mas_width);
    }];
    
    //添加中间视图
    switch (_alertStyle) {
            case BTAlertViewStyleDefault:
            {
                self.messageLbl = [[UILabel alloc] init];
                self.messageLbl.numberOfLines = 0;
                self.messageLbl.text = self.contentStr;
                self.messageLbl.font = alertContentLblFont;
                self.messageLbl.textColor = alertContentColor;
                [self.contentView addSubview:self.messageLbl];
                [self.messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.contentView.mas_centerX);
                    make.top.equalTo(self.titleLbl.mas_bottom).offset(23);
                    make.width.equalTo(@(centerWidth));
                }];
                self.horizontalLine = [[UIView alloc] init];
                self.horizontalLine.backgroundColor = alertSpecLineColor;
                [self.contentView addSubview:self.horizontalLine];
                [self.horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@0);
                    make.right.equalTo(self.contentView.mas_right);
                    make.height.equalTo(@(btnPadding));
                    make.top.equalTo(self.messageLbl.mas_bottom).offset(24);
                }];
                
                [self adjustTheLabelTextAlignment];
            }
            
            break;
            
            case BTAlertViewStyleText:
            {
                self.inputTxt = [[UITextField alloc] init];
                self.inputTxt.font = alertContentTextFont;
                self.inputTxt.textColor = alertContentColor;
                self.inputTxt.layer.borderColor = kHexColor(0xC3C7CD).CGColor;
                self.inputTxt.layer.borderWidth = 1.f;
                self.inputTxt.layer.cornerRadius = 4.f;
                self.inputTxt.placeholder = self.contentStr;
                self.inputTxt.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 0)];
                self.inputTxt.leftViewMode = UITextFieldViewModeAlways;
                [self.contentView addSubview:self.inputTxt];
                [self.inputTxt mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.mas_centerX);
                    make.width.equalTo(@(centerWidth));
                    make.top.equalTo(self.titleLbl.mas_bottom).offset(23);
                    make.height.equalTo(@(inputTextHeight));
                }];
                
                self.horizontalLine = [[UIView alloc] init];
                self.horizontalLine.backgroundColor = alertSpecLineColor;
                [self.contentView addSubview:self.horizontalLine];
                [self.horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@0);
                    make.right.equalTo(self.contentView.mas_right);
                    make.height.equalTo(@(btnPadding));
                    make.top.equalTo(self.inputTxt.mas_bottom).offset(24);
                }];
            }
            
            break;
            
            case BTAlertViewStyleCustom:
            {
                [self.contentView addSubview:self.customView];
                [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.mas_centerX);
                    make.width.equalTo(@(centerWidth));
                    make.top.equalTo(self.titleLbl.mas_bottom).offset(23);
                }];
                
                self.horizontalLine = [[UIView alloc] init];
                self.horizontalLine.backgroundColor = alertSpecLineColor;
                [self.contentView addSubview:self.horizontalLine];
                [self.horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@0);
                    make.right.equalTo(self.contentView.mas_right);
                    make.height.equalTo(@(btnPadding));
                    make.top.equalTo(self.customView.mas_bottom).offset(24);
                }];
            }
            break;
            case BTAlertViewStyleAllCustom:
            {
                [self.contentView addSubview:self.customView];
                [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.mas_centerX);
                    make.width.equalTo(@(contentViewWidth));
                    make.top.equalTo(self.contentView);
                }];
                
                self.horizontalLine = [[UIView alloc] init];
                self.horizontalLine.backgroundColor = alertSpecLineColor;
                [self.contentView addSubview:self.horizontalLine];
                [self.horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@0);
                    make.right.equalTo(self.contentView.mas_right);
                    make.height.equalTo(@(btnPadding));
                    make.top.equalTo(self.customView.mas_bottom).offset(0);
                }];
            }
            break;
            
        default:
            break;
    }
    
    //添加底部按钮
    for (int i = 0; i < _buttonArray.count; i++){
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = btnTag + i;
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(handBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [btn setTitle:[_buttonArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:alertSureBtnColor forState:UIControlStateNormal];
        btn.titleLabel.font = alertBtnFont;
        if(i==0){
            if(_buttonArray.count > 1)    //多个按钮时   默认第一个按钮用取消类型
            {
                [btn setTitleColor:alertCancelBtnColor forState:UIControlStateNormal];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView);
                    make.height.equalTo(@(btnHeight));
                    make.top.equalTo(self.horizontalLine.mas_bottom);
                    make.bottom.equalTo(self.contentView.mas_bottom);
                }];
            }else{     //当按钮只有一个的时候
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView);
                    make.height.equalTo(@(btnHeight));
                    make.right.equalTo(self.contentView.mas_right);
                    make.top.equalTo(self.horizontalLine.mas_bottom);
                    make.bottom.equalTo(self.contentView.mas_bottom);
                }];
            }
            
        }else if (i == _buttonArray.count -1){
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tempView.mas_right).offset(btnPadding);
                make.right.equalTo(self.contentView.mas_right);
                make.height.equalTo(@(btnHeight));
                make.width.equalTo(tempView);
                make.top.equalTo(self.horizontalLine.mas_bottom);
                make.bottom.equalTo(self.contentView.mas_bottom);
            }];
        }else{
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(btnHeight));
                make.top.equalTo(self.horizontalLine.mas_bottom);
                make.bottom.equalTo(self.contentView.mas_bottom);
                make.left.equalTo(tempView.mas_right).offset(btnPadding);
                make.centerY.equalTo(tempView);
                make.width.equalTo(tempView);
            }];
        }

        if(i > 0)
        {
            UIView *verticalLine = [[UIView alloc] init];
            verticalLine.backgroundColor = alertSpecLineColor;
            [self.contentView addSubview:verticalLine];
            [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tempView.mas_right);
                make.width.equalTo(@(btnPadding));
                make.top.equalTo(self.horizontalLine.mas_bottom);
                make.height.equalTo(tempView);
            }];
        }
        tempView = btn;

    }
}

/**
 按钮单击事件

 @param btn 按钮对象
 */
- (void)handBtnAction:(UIButton *)btn
{
    [self closeView];
    if(_alertViewCompleteBlock){
        NSString *msg;
        if(_alertStyle == BTAlertViewStyleDefault)
        {
            msg = self.messageLbl.text;
        }else if(_alertStyle == BTAlertViewStyleText){
            msg = self.inputTxt.text;
        }else{
            msg = nil;
        }
        
        _alertViewCompleteBlock(btn.tag - btnTag, msg);
    }
}

/**
 *  显示弹出框
 */
-(void)showWithCompletion:(void (^)(NSInteger index, NSString *msg))completeBlock;
{
    if (self.show && self.superview) {
        return;
    }else{
        self.show = YES;
    }
    _alertViewCompleteBlock = completeBlock;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showInView:keyWindow completion:completeBlock];
}

/**
 显示所在的视图

 @param superView 所在的父视图
 @param completeBlock 回调
 */
-(void)showInView:(UIView *)superView completion:(void (^)(NSInteger index, NSString *msg))completeBlock{
    [superView addSubview:self];
    self.contentView.alpha = 0;
    self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3f animations:^{
        self.contentView.alpha = 1.0;
        self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

/**
 *  关闭视图
 */
-(void)closeView
{
    self.show = NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.contentView.alpha = 0;
        self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark ----------  属性自定义设置

//设置 alertView Title颜色
- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.titleLbl.textColor = titleColor;
}

//设置 alertView Font颜色
- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.titleLbl.font = titleFont;
}

//设置alertView  中间message 字体大小 ---> alertView默认纯文本有效
- (void)setMessageLblFont:(UIFont *)messageLblFont
{
    if(_alertStyle == UIAlertViewStyleDefault)
    {
        self.messageLbl.font = messageLblFont;
    }
}

- (void)setMessageLblColor:(UIColor *)messageLblColor
{
    if(_alertStyle == BTAlertViewStyleDefault)
    {
        self.messageLbl.textColor = messageLblColor;
    }
}

//设置alertView  中间message 字体颜色 ---> alertView UITextField样式有效
- (void)setMessageTxtColor:(UIColor *)messageTxtColor
{
    _messageTxtColor = messageTxtColor;
    if(_alertStyle == BTAlertViewStyleText)
    {
        self.inputTxt.textColor = messageTxtColor;
    }
}


//设置alertView  中间message 字体大小 ---> alertView UITextField样式有效
- (void)setMessageTxtFont:(UIFont *)messageTxtFont
{
    _messageTxtFont = messageTxtFont;
    if(_alertStyle == BTAlertViewStyleText)
    {
        self.inputTxt.font = messageTxtFont;
    }
    
}

//设置alertView  密码类型文本框 ---> alertView UITextField样式有效
- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    if(_alertStyle == BTAlertViewStyleText)
    {
        self.inputTxt.secureTextEntry = secureTextEntry;
    }
}

//设置按钮字体颜色
- (void)setOtherButtonTitleColors:(UIColor *)colors,...NS_REQUIRES_NIL_TERMINATION{
    va_list args;
    va_start(args, colors);
    int i = 0;
    for (UIColor *color = colors; color != nil; color = va_arg(args,UIColor*)){
        if(i < _buttonArray.count){
            UIButton *btn = _buttonArray[i];
            [btn setTitleColor:color forState:UIControlStateNormal];
        }
        i++;
    }
    va_end(args);
}

/**
 调整文本对齐方式
 */
- (void)adjustTheLabelTextAlignment
{
    if(_alertStyle == BTAlertViewStyleDefault){
        if([self getSizeWithStr:self.messageLbl.text].width > self.centerAllWidth ){
            self.messageLbl.textAlignment = NSTextAlignmentLeft;
        }else{
            self.messageLbl.textAlignment = NSTextAlignmentCenter;
        }
    }
}

//设置按钮字体大小
- (void)setOtherButtonTitleFonts:(UIFont *)fonts,...NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, fonts);
    int i = 0;
    for (UIFont *font = fonts; font != nil; font = va_arg(args,UIFont*)){
        if(i < _buttonArray.count){
            UIButton *btn = _buttonArray[i];
            btn.titleLabel.font = font;
        }
        i++;
    }
    va_end(args);
}

-(CGSize)getSizeWithStr:(NSString *)str
{
    NSNumber *fontNum;
    UIFont *font;
    if(self.messageLblFont){
        UIFontDescriptor *lblFont = self.messageLblFont.fontDescriptor;
        //获取字号
         fontNum = [lblFont objectForKey:@"NSFontSizeAttribute"];
         font = self.messageLblFont;
    }else{
        UIFontDescriptor *lblFont = alertContentLblFont.fontDescriptor;
        //获取字号
        fontNum = [lblFont objectForKey:@"NSFontSizeAttribute"];
        font = alertContentLblFont;
    }
    
    return [str boundingRectWithSize:CGSizeMake(MAXFLOAT, fontNum.floatValue) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
}

/**
 关闭弹窗
 */
- (void)handTapAction
{
    //判断遮罩层是否可以关闭
    if(self.tapMaskLayerDissmiss){
        [self closeView];
    }
}





@end
