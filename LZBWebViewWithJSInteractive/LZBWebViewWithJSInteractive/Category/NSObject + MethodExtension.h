//
//  NSObject + MethodExtension.h
//  LZBWebViewWithJSInteractive
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MethodExtension)

//增加方法，可以增加多个参数
- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;
@end
