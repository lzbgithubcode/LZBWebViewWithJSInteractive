//
//  LZBAlterView.m
//  自定义弹框-UIView
//
//  Created by apple on 16/1/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBAlterView.h"

/**颜色转换**/
#define LZBColorChangeRGB(colorchange,alpa)  [UIColor colorWithRed:(CGFloat)(((colorchange &0xff0000)>>16)/255.0) green:(CGFloat)(((colorchange &0xff00)>> 8)/255.0 )blue:(CGFloat)((colorchange & 0xff)/255.0 ) alpha:alpa]

/**文字大小**/
#define LZBAlterFont 16
/**左右间距*/
#define LZBLeftRightMargin 15

/**上下间距**/
#define LZBTopMargin 25
#define LZBBottowMargin 20

#define default_tag 100

/**选择弹框的类型*/
typedef NS_ENUM ( NSInteger , alterViewType)  {
    alterViewTypeImageWordWithBtn = 0, //图片 +按钮 + 文字
    alterViewTypeWordWithBtn = 1,       //文字加按钮
} ;

@interface LZBAlterView ()


/**
 *  蒙版View
 */
@property (nonatomic,weak) UIView *backMaskView;

/**
 *  中间的弹框View
 */
@property (nonatomic,weak) UIView *alterView;

/**
 *  记录弹框类型
 */
@property(nonatomic,assign) alterViewType alterType;

/**
 *  弹框内容的子控件
 */
@property (nonatomic,weak) UIImageView *imageV;
@property (nonatomic,weak) UILabel *textLab;
@property (nonatomic,weak) UIButton *btnOne;
@property (nonatomic,weak) UIButton *btnTwo;
@property (nonatomic,weak) UIButton *btnThree;
@property (nonatomic,weak) UIView *oneLine;
@property (nonatomic,weak) UIView *twoLine;
@property (nonatomic,weak) UIView *threeLine;

#pragma mark-业务处理
@property (nonatomic,copy) alterBlock interblock;

@end

@implementation LZBAlterView
{
    LZBAlterView *_ManageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if(self =[super initWithFrame:frame])
  {
      [self addChildView];
     
  }
    return self;
  
}

/**
 *  增加子控制器
 */
- (void)addChildView
{
   //1.增加蒙版View
    UIView *backView =[[UIView alloc]init];
    backView.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.backMaskView =backView;
    [self addSubview:self.backMaskView];

    
  //2.增加中间的弹框View
    UIView *alterV =[UIView new];
    alterV.backgroundColor =[UIColor whiteColor];
    self.alterView =alterV;
    [self.backMaskView addSubview:alterV];
    
  //3.上面的ImageView
    UIImageView *imaV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"优惠券无效"]];
    self.imageV =imaV;
    [self.alterView addSubview:self.imageV];
    
    
    UILabel *lab2 =[[UILabel alloc]init];
    self.textLab =lab2;
    self.textLab.numberOfLines =0;
    self.textLab.textAlignment =NSTextAlignmentCenter;
    self.textLab.textColor =LZBColorChangeRGB(0x666666, 1);
    self.textLab.lineBreakMode =NSLineBreakByCharWrapping;
    self.textLab.font =[UIFont systemFontOfSize:LZBAlterFont];
    [self.alterView addSubview:self.textLab];
    
    
    
    //分割线
    UIView *line1 =[[UIView alloc]init];
    self.oneLine =line1;
    [self setLineCommon:line1];
    
    
    UIButton *btn1 =[UIButton buttonWithType:UIButtonTypeCustom];
     self.btnOne =btn1;
    self.btnOne.tag =default_tag + 1;
    [self setBtnCommon:btn1];
   
    //分割线
    UIView *line2 =[[UIView alloc]init];
    self.twoLine =line2;
    [self setLineCommon:line2];
    
    UIButton *btn2 =[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnTwo =btn2;
    self.btnTwo.tag =default_tag+2;
    [self setBtnCommon:btn2];
  

    //分割线
    UIView *line3 =[[UIView alloc]init];
    self.threeLine =line3;
    [self setLineCommon:line3];
    
    UIButton *btn3 =[UIButton buttonWithType:UIButtonTypeCustom];
    self.btnThree =btn3;
    self.btnThree.tag =default_tag +3;
    [self setBtnCommon:btn3];
    

    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //获得屏幕的中心
    CGFloat centerX =[UIScreen mainScreen].bounds.size.width * 0.5;
    CGFloat centerY =[UIScreen mainScreen].bounds.size.height * 0.5;
    
    //设置alterView的大小
    CGFloat alterW =[UIScreen mainScreen].bounds.size.width *0.8;
    CGFloat alterH =[UIScreen mainScreen].bounds.size.height *0.3;
    
    //分割线的高度
    CGFloat lineH =1;
    CGFloat btnH =44;
    
    //布局蒙版
    self.backMaskView.frame =[UIScreen mainScreen].bounds;
    
    //布局弹框
    self.alterView.center =CGPointMake(centerX, centerY);
    self.alterView.layer.cornerRadius = 3;
    self.alterView.layer.masksToBounds =YES;
    self.alterView.bounds =CGRectMake(0, 0, alterW, alterH);
//*************************布局弹框内容的子控件***********************************//
    CGSize size =CGSizeMake(alterW - 2*LZBLeftRightMargin, MAXFLOAT);
    CGSize wenziSize = [self.textLab.text  boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:LZBAlterFont]} context:nil].size;
    
    if(self.alterType == alterViewTypeWordWithBtn) //文字+按钮类型
    {
        self.imageV.hidden =YES;
        self.textLab.frame =self.textLab.text ?CGRectMake(LZBLeftRightMargin, LZBTopMargin, wenziSize.width, wenziSize.height):CGRectMake(LZBLeftRightMargin, 0, size.width, LZBTopMargin);
     self.textLab.center =CGPointMake(alterW *0.5,LZBTopMargin  + wenziSize.height *0.5);
    }
    else if(self.alterType == alterViewTypeImageWordWithBtn)//图片+文字+按钮类型
    {
        self.imageV.hidden =NO;
        self.imageV.center =CGPointMake(alterW *0.5, LZBTopMargin+32);
        self.imageV.bounds =CGRectMake(0, 0, 70, 64);
     
        self.textLab.frame =self.textLab.text ? CGRectMake(LZBLeftRightMargin, CGRectGetMaxY(self.imageV.frame)+ LZBBottowMargin * 0.5, wenziSize.width, wenziSize.height):CGRectMake(LZBLeftRightMargin, CGRectGetMaxY(self.imageV.frame), 0, 0);
           self.textLab.center =CGPointMake(alterW *0.5, CGRectGetMaxY(self.imageV.frame) +LZBBottowMargin * 0.5 + wenziSize.height *0.5);
        
    }
    self.oneLine.frame =(self.alterType == alterViewTypeWordWithBtn) ? CGRectMake(0, CGRectGetMaxY(self.textLab.frame)+ LZBBottowMargin, alterW, lineH) : CGRectMake(LZBLeftRightMargin, CGRectGetMaxY(self.textLab.frame)+LZBBottowMargin, alterW - 2*LZBLeftRightMargin,lineH );
    
   
       //设置第一个按钮
       self.btnOne.frame =self.btnOne.titleLabel.text ? CGRectMake(0, CGRectGetMaxY(self.oneLine.frame), alterW, btnH):CGRectMake(0, CGRectGetMaxY(self.oneLine.frame), alterW, 0);
   
    
    self.twoLine.frame =(self.alterType == alterViewTypeWordWithBtn)?CGRectMake(0, CGRectGetMaxY(self.btnOne.frame), alterW, lineH):CGRectMake(LZBLeftRightMargin, CGRectGetMaxY(self.btnOne.frame), alterW-2*LZBLeftRightMargin,lineH *0.5);
   
    //设置第二个按钮
        self.btnTwo.frame =self.btnTwo.titleLabel.text ? CGRectMake(0, CGRectGetMaxY(self.twoLine.frame), alterW, btnH) :CGRectMake(0, CGRectGetMaxY(self.oneLine.frame), alterW, 0);
    
      self.threeLine.frame =(self.alterType == alterViewTypeWordWithBtn)?CGRectMake(0, CGRectGetMaxY(self.btnTwo.frame), alterW, lineH):CGRectMake(LZBLeftRightMargin, CGRectGetMaxY(self.btnTwo.frame), alterW-LZBLeftRightMargin *2,lineH *0.5);
    
    //设置第三个按钮
        self.btnThree.frame =self.btnThree.titleLabel.text ? CGRectMake(0, CGRectGetMaxY(self.threeLine.frame), alterW, btnH) :CGRectMake(0, CGRectGetMaxY(self.threeLine.frame), alterW, 0);
  
    if(self.btnThree.titleLabel.text)
    {
    //最后再次确定高度
    self.alterView.bounds =CGRectMake(0, 0, alterW, CGRectGetMaxY(self.btnThree.frame));
    }
    else if(self.btnTwo.titleLabel.text)
    {
     //最后再次确定高度
        self.alterView.bounds =CGRectMake(0, 0, alterW, CGRectGetMaxY(self.btnTwo.frame));
    }
    else
    {
        //最后再次确定高度
        self.alterView.bounds =CGRectMake(0, 0, alterW, CGRectGetMaxY(self.btnOne.frame));
    }
   

}

#pragma mark- 业务逻辑处理
#pragma mark==============================================================
- (void)Clickbtn:(UIButton *)btn
{
    if(!self.interblock) return;
    btn.enabled =NO;
    self.interblock(self,btn.tag - default_tag);
}
#pragma mark-设置文字+按钮
+ (LZBAlterView *)lzb_alterViewWithText:(NSString *)Text OneTitle:(NSString *)btnOneTitle  TwoTitle:(NSString *)btnTwoTitle ThreeTitle:(NSString *)btnThreeTitle handleBlock:(alterBlock )alterblock
{
  
    LZBAlterView *alterV =[[LZBAlterView alloc]init];
    
    alterV.frame =[UIScreen mainScreen].bounds;
    alterV.interblock = alterblock ? alterblock: nil;
    //文字 + 按钮内容
    alterV.alterType =alterViewTypeWordWithBtn;
    alterV.textLab.text =Text;
    [alterV.btnOne setTitle:btnOneTitle forState:UIControlStateNormal];
    [alterV.btnTwo setTitle:btnTwoTitle forState:UIControlStateNormal];
    [alterV.btnThree setTitle:btnThreeTitle forState:UIControlStateNormal];
    [[UIApplication sharedApplication].keyWindow addSubview:alterV];
    return alterV;
}

#pragma mark-设置图片+文字+按钮
+ (LZBAlterView *)lzb_alterViewWithImage:(NSString *)imageName ErrorText:(NSString *)errorText OneTitle:(NSString *)btnOneTitle  TwoTitle:(NSString *)btnTwoTitle ThreeTitle:(NSString *)btnThreeTitle  handleBlock:(alterBlock)alterblock;
{
    LZBAlterView *alterV =[[LZBAlterView alloc]init];
    alterV.frame =[UIScreen mainScreen].bounds;
    alterV.interblock = alterblock ? alterblock: nil;
    //文字 + 按钮内容类型
    alterV.alterType =alterViewTypeImageWordWithBtn;
    alterV.imageV.image =[UIImage imageNamed:imageName];
    alterV.textLab.text =errorText;
    [alterV.btnOne setTitle:btnOneTitle forState:UIControlStateNormal];
    [alterV.btnTwo setTitle:btnTwoTitle forState:UIControlStateNormal];
    [alterV.btnThree setTitle:btnThreeTitle forState:UIControlStateNormal];
    [[UIApplication sharedApplication].keyWindow addSubview:alterV];
    
    return alterV;
}
#pragma mark-设置按钮文字字体颜色大小
 - (void)lzb_setTextColor:(UIColor *)color BtnTitleColor:(UIColor *)wordColor  TextFont:(UIFont *)textFont BtnTitleFont:(UIFont *)WordFont
{
    if(!color) return;
    self.textLab.textColor =color;
    if(!wordColor) return;
    [self.btnOne setTitleColor:wordColor forState:UIControlStateNormal];
    [self.btnTwo setTitleColor:wordColor forState:UIControlStateNormal];
    [self.btnThree setTitleColor:wordColor forState:UIControlStateNormal];
    
    if(!textFont) return;
       self.textLab.font =textFont;
    if(!WordFont) return;
      self.btnOne.titleLabel.font =WordFont;
      self.btnTwo.titleLabel.font =WordFont;
      self.btnThree.titleLabel.font =WordFont;
    
}

#pragma mark-设置弹框内容公共的属性
#pragma mark==============================================================
/**
 *  设置按钮的公共属性
 */
- (void)setBtnCommon:(UIButton *)btn
{
    btn.titleLabel.textAlignment =NSTextAlignmentCenter;
[btn setTitleColor:LZBColorChangeRGB(0x36d7b7, 1) forState:UIControlStateNormal];
    btn.titleLabel.font =[UIFont systemFontOfSize:LZBAlterFont];
    [btn addTarget:self action:@selector(Clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.alterView addSubview:btn];
   
}
/**
 *  设置分割线的公共属性
 */
- (void)setLineCommon:(UIView*)line
{
     //灰色
    line.backgroundColor =[UIColor colorWithWhite:0.667 alpha:0.2];
    [self.alterView addSubview:line];
}

- (void)removeAlterView
{
    [self removeFromSuperview];
}



@end
