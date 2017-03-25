//
//  YNTUITools.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/12.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTUITools.h"

@implementation YNTUITools
/** 创建button */
+ (UIButton *)createButton:(CGRect)frame bgColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)titleColor action:(SEL)action vc:(id)vc{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = frame;
    if (bgColor) {
        button.backgroundColor = bgColor;
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    return button;
}
+ (UIButton *)createCustomButton:(CGRect)frame bgColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)titleColor image:(NSString *)imageName action:(SEL)action vc:(id)vc {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    // 取消系统的渲染色
    UIImage *img = [UIImage imageNamed:imageName];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    if (bgColor) {
        button.backgroundColor = bgColor;
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    [button setImage:img forState:UIControlStateNormal];
    [button addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
/** 创建Label */
+ (UILabel *)createLabel:(CGRect)frame text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor font:(CGFloat)size {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    if (size) {
//  label.font = [UIFont  fontWithName:@"Helvetica-Light" size:size];;
        label.font = [UIFont systemFontOfSize:size];
    }
    if (textAlignment) {
        label.textAlignment = textAlignment;
    }
    if (bgColor) {
        label.backgroundColor = bgColor;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    return label;
}
/** 创建TextField */
+ (UITextField *)creatTextField:(CGRect)frame bgColor:(UIColor *)bgColor borderStyle:(UITextBorderStyle)borderStyle placeHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType font:(CGFloat)font secureTextEntry:(BOOL)secureTextEntry clearButtonMode:(UITextFieldViewMode)clearButtonMode {
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    if (font) {
        textField.font = [UIFont  fontWithName:@"Helvetica-Light" size:font];
    }
    if (bgColor) {
        textField.backgroundColor = bgColor;
    }
    if (borderStyle) {
        textField.borderStyle = borderStyle;
    }
    if (placeHolder) {
        textField.placeholder = placeHolder;
    }
    if (keyboardType) {
        textField.keyboardType = keyboardType;
    }
    textField.secureTextEntry = secureTextEntry;
    if (clearButtonMode) {
        textField.clearButtonMode = clearButtonMode;
    }
    return textField;
}
/** 创建imageView */
+ (UIImageView *)createImageView:(CGRect)frame bgColor:(UIColor *)bgcolor imageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    /*
    // 取消系统的渲染色
    UIImage *closeBtnImage = [UIImage imageNamed:@"login-close"];
    closeBtnImage = [closeBtnImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     */

    if (bgcolor) {
        imageView.backgroundColor = bgcolor;
    }
    if (imageName) {
        imageView.image = [UIImage imageNamed:imageName];
    }
    return imageView;
}

/** 返回随机颜色 */
+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
}



@end
