//
//  LZBDataModel.h
//  LZBWebViewWithJSInteractive
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LZBDataModel : NSObject


- (instancetype)initWithVC:(UIViewController *)vc withTitle:(NSString *)string;


@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIViewController *vc;
@end
