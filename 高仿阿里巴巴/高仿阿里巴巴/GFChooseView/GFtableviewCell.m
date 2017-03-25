//
//  GFtableviewCell.m
//  弹出框
//
//  Created by 1暖通商城 on 2017/3/25.
//  Copyright © 2017年 1暖通商城. All rights reserved.
//

#import "GFtableviewCell.h"
#import "YNTUITools.h"
// 屏幕宽的比例
#define kWidthScale [UIScreen mainScreen].bounds.size.width / 375
// 屏幕高的比例
#define kHeightScale [UIScreen mainScreen].bounds.size.height / 667
#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH    [UIScreen mainScreen].bounds.size.height

@implementation GFtableviewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加子视图
        [self setUpChildrenViews];
    }
    return self;
}
#pragma mark- 创建视图
- (void)setUpChildrenViews
{
    // 规格型号
    self.sizeLab = [YNTUITools createLabel:CGRectMake(10 *kWidthScale, 15*kHeightScale,kScreenW - 10*kWidthScale , 16 *kHeightScale) text:@"M码" textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] bgColor:nil font:16*kHeightScale];
    [self.contentView addSubview:self.sizeLab];
    
    
    // 创建加减背景
    UIImageView *addImgView = [YNTUITools createImageView:CGRectMake(kScreenW - 136*kWidthScale, 15 *kHeightScale, 110*kWidthScale, 22*kHeightScale) bgColor:nil imageName:@"number_bar"];
    addImgView.userInteractionEnabled = YES;
    [self.contentView addSubview:addImgView];
    
    
    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(kScreenW - 47*kWidthScale, 15 *kHeightScale, 22 *kWidthScale,22*kWidthScale);

    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addBtn];
    // 数量显示
    self.numberTextField  = [YNTUITools creatTextField:CGRectMake(kScreenW-118*kWidthScale, 15*kHeightScale, 66*kWidthScale, 22*kHeightScale) bgColor:nil borderStyle:UITextBorderStyleNone placeHolder:nil keyboardType:UIKeyboardTypeNumberPad font:14*kHeightScale secureTextEntry:NO clearButtonMode:UITextFieldViewModeWhileEditing];
    _numberTextField.textAlignment =NSTextAlignmentCenter;
    _numberTextField.text = @"0";
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.numberTextField];
    
    // 设置辅助视图
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, kScreenW,30)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenW - 60, 7,50, 20)];
    [button addTarget:self action:@selector(confrimBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"完成"forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [bar addSubview:button];
    _numberTextField.inputAccessoryView = bar;
    [self.contentView addSubview:_numberTextField];
    
    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame =  CGRectMake(kScreenW - 136*kWidthScale, 15*kHeightScale,22*kWidthScale,22*kHeightScale);
    [cutBtn setImage:[UIImage imageNamed:@"添加左减"] forState:UIControlStateNormal];
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView  addSubview:cutBtn];
    

}

#pragma mark - 加减按钮的点击事件
- (void)addBtnClick:(UIButton *)sender
{
    NSLog(@"点击的是加");
   
    NSInteger number = [self.numberTextField.text integerValue];
    number +=1;
    self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)number];
    if (self.addButtonBlock) {
        self.addButtonBlock(self.numberTextField.text);
    }

}
- (void)cutBtnClick:(UIButton *)sender
{
    NSLog(@"点击的是减");
       NSInteger number = [self.numberTextField.text integerValue];
    number -=1;
   
    if ([self.numberTextField.text isEqualToString:@"0"]) {
        self.numberTextField.text = @"0";
        
    }else{
         self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)number];
    }

    if (self.reduceButtonBlock) {
        self.reduceButtonBlock(self.numberTextField.text);
    }


}
#pragma mark - 实时监听文字的输入
- (void)textChange:(NSNotification *)info
{
    NSLog(@"输入的是:%@",self.numberTextField.text);
    if (self.textChangeBlock) {
        self.textChangeBlock(self.numberTextField.text);
    }
}
#pragma mark - 完成按钮的点击事件
- (void)confrimBtnAction:(UIButton *)sender
{
    NSLog(@"点击的是键盘上的完成");
    [self.contentView endEditing:YES];
    if (self.textInputCompleteBlock) {
        self.textInputCompleteBlock(self.numberTextField.text);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
