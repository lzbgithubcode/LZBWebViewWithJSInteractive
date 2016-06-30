//
//  LZBDataModel.m
//  LZBWebViewWithJSInteractive
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBDataModel.h"

@implementation LZBDataModel
- (instancetype)initWithVC:(UIViewController *)vc withTitle:(NSString *)string
{
  if(self = [super init])
  {
      self.vc = vc;
      self.title = string;
  }
    return self;
}
@end
