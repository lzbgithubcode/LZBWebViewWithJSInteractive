//
//  LZBSweepView.m
//  LZBWebViewWithJSInteractive
//
//  Created by apple on 16/7/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBSweepView.h"

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

#define sweep_Width  SCREEN_WIDTH -60
#define sweep_Height  SCREEN_HEIGHT *0.6
#define  imageView_Height 200
#define  imageView_Width 200
#define imageView_Margin 20
@interface LZBSweepView()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *descLab;
@end

@implementation LZBSweepView
- (instancetype)initWithFrame:(CGRect)frame
{
   if(self = [super initWithFrame:frame])
   {
       self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
       self.frame = [UIScreen mainScreen].bounds;
       [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dimissSweepView)]];
       [self addSubview:self.containerView];
      [self.containerView addSubview:self.imageView];
      [self.containerView addSubview:self.descLab];
    
   }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.containerView.center = self.center;
    self.imageView.frame = CGRectMake((sweep_Width - imageView_Width ) *0.5, imageView_Margin, imageView_Width, imageView_Height);
    self.descLab.frame = CGRectMake(self.imageView.frame.origin.x, CGRectGetMaxY(self.imageView.frame), sweep_Width - 2 *self.imageView.frame.origin.x, 90);
}

- (void)showInSuperView:(UIView *)parentView
{
   if(parentView == nil)
       parentView = [UIApplication sharedApplication].keyWindow;
    [parentView addSubview:self];
    self.alpha = 0.0;
     __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.alpha = 1.0;
    } completion:^(BOOL finished) {
    weakSelf.containerView.bounds = CGRectMake(0, 0, sweep_Width, sweep_Height);
        [weakSelf shakeToShow:weakSelf.containerView];
    }];
}


- (void)dimissSweepView
{
       __weak __typeof(&*self)weakSelf = self;
    self.alpha =1.0;
    self.containerView.center = CGPointMake(SCREEN_WIDTH *0.5, SCREEN_HEIGHT *0.5);
   [UIView animateWithDuration:0.25 animations:^{
       weakSelf.alpha = 0.0;
       weakSelf.containerView.center = CGPointMake(SCREEN_WIDTH *0.5, SCREEN_HEIGHT + sweep_Height);
   } completion:^(BOOL finished) {
       [weakSelf removeFromSuperview];
   }];
}

//弹出放大-缩小效果
- (void) shakeToShow:(UIView*)aView
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}


#pragma mark- 懒加载
- (UIView *)containerView
{
  if(_containerView == nil)
  {
      _containerView = [UIView new];
      _containerView.backgroundColor = [UIColor whiteColor];
      _containerView.layer.cornerRadius = 3.0;
      _containerView.layer.masksToBounds = YES;
  }
    return _containerView;
}

- (UIImageView *)imageView
{
  if(_imageView == nil)
  {
      _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"developerCode.jpg"]];
      _imageView.contentMode = UIViewContentModeScaleAspectFill;
      _imageView.clipsToBounds = YES;
     
  }
    return _imageView;
}

- (UILabel *)descLab
{
  if(_descLab == nil)
  {
      _descLab = [UILabel new];
      [self.containerView addSubview:_descLab];
      _descLab.textColor = [UIColor redColor];
      _descLab.numberOfLines = 0;
      _descLab.text = @"扫码关注开发者源代码公众账号，更多资源分享,期待您的加入！！！";
  }
    return _descLab;
}

@end
