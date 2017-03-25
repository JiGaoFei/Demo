//
//  YNTUITools.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/12.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YNTUITools : NSObject
/** 创建button */
+ (UIButton *)createButton:(CGRect)frame bgColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)titleColor action:(SEL)action vc:(id)vc;
+ (UIButton *)createCustomButton:(CGRect)frame bgColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)titleColor image:(NSString *)imageName action:(SEL)action vc:(id)vc;
/** 创建Label */
+ (UILabel *)createLabel:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor font:(CGFloat)size ;
/** 创建TextField */
+ (UITextField *)creatTextField:(CGRect)frame bgColor:(UIColor *)bgColor borderStyle:(UITextBorderStyle)borderStyle placeHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType font:(CGFloat)font secureTextEntry:(BOOL)secureTextEntry clearButtonMode:(UITextFieldViewMode)clearButtonMode;
/** 创建imageView */
+ (UIImageView *)createImageView:(CGRect)frame bgColor:(UIColor *)bgcolor imageName:(NSString *)imageName;

/** 返回随机颜色 */
+ (UIColor *)randomColor;


@end
