//
//  ViewController.m
//  高仿阿里巴巴
//
//  Created by 1暖通商城 on 2017/3/25.
//  Copyright © 2017年 1暖通商城. All rights reserved.
//

#import "ViewController.h"
#import "GFChooseView.h"
#import "YNTUITools.h"
#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH    [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<GFChooseViewDelegate>

// 弹出视图
@property (nonatomic,strong) GFChooseView *chooseView;
@property (nonatomic,assign) NSInteger index;
@end

@implementation ViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 加载底部视图
    [self setUpBottomView];
    
}
#pragma makr - 视图
- (void)setUpBottomView
{
    UIButton *bottomBtn =[YNTUITools createButton:CGRectMake(0, kScreenH - 50, kScreenW, 50) bgColor:[UIColor orangeColor] title:@"加入购物车" titleColor:[UIColor whiteColor] action:@selector(pushViews:) vc:self];
    [self.view addSubview:bottomBtn];
    
    self.chooseView = [[GFChooseView alloc]initWithFrame:CGRectMake(0, kScreenH, kScreenW, kScreenH)];
    _chooseView.delegate = self;
    
    [self.view addSubview:_chooseView];
    
}
- (void)pushViews:(UIButton *)sender
{
    [UIView animateWithDuration: 0.35 animations: ^{
        
        
        
        _chooseView.frame =CGRectMake(0, 0, kScreenW, kScreenH);
    } completion: nil];
    
    
    NSLog(@"我要加入购物车了");
    
}
#pragma mark - 弹出框代理
//点击加号事件
- (void)clickAddButtonAction:(NSString *)str
{
    NSLog(@"代理加号点击事件:%@",str);
    NSArray *arr1 =@[@"10",@"15",@"35",@"35",@"60"];
    NSInteger priceNumber = [arr1[self.index] integerValue];
    NSInteger number = [str integerValue];
    NSInteger totalNumber = number * priceNumber;
    _chooseView.totallMoneyLab.text = [NSString stringWithFormat:@"¥%ld",totalNumber];
    
    [self setToatalNumberColor:_chooseView.goodsNumberLab andStr:[NSString stringWithFormat:@"共%@件",str]];
    
}
//点击减号事件
- (void)clickReduceButtonAction:(NSString *)str
{NSLog(@"代理减号点击事件:%@",str);
    NSArray *arr1 =@[@"10",@"15",@"35",@"35",@"60"];
    NSInteger priceNumber = [arr1[self.index] integerValue];
    NSInteger number = [str integerValue];
    NSInteger totalNumber = number * priceNumber;
    _chooseView.totallMoneyLab.text = [NSString stringWithFormat:@"¥%ld",totalNumber];
    
    [self setToatalNumberColor:_chooseView.goodsNumberLab andStr:[NSString stringWithFormat:@"共%@件",str]];
    
}
// 文字改变事件
- (void)textChangeAction:(NSString *)str
{
    NSLog(@"代理文字正在改变:%@",str);
}
// 键盘完成事件
- (void)clickKeyBordCompleteAction:(NSString *)str
{
    NSLog(@"代理完成后输入的文字是:%@",str);
}
//点击关闭事件
- (void)closeButtonAction
{
    [UIView animateWithDuration: 0.35 animations: ^{
        self.chooseView.frame =CGRectMake(0, kScreenH, kScreenW, kScreenH);
        
    } completion: nil];
    
}
// 点击确定事件
- (void)confirmButtonAction
{
    [UIView animateWithDuration: 0.35 animations: ^{
        self.chooseView.frame =CGRectMake(0, kScreenH, kScreenW, kScreenH);
        
    } completion: nil];
    
}
// 点击规格序号
- (void)clickBtnIndexWithTag:(NSInteger)index
{
    NSArray *arr = @[@"1",@"2",@"3",@"4",@"5"];
    NSArray *arr1 =@[@"¥10",@"¥15",@"¥35",@"¥35",@"¥60"];
    self.chooseView.img.image = [UIImage imageNamed:arr[index]];
    self.chooseView.priceLab.text = arr1[index];
    self.index = index;
    NSLog(@"点击的是:第%ld个",index);
}
#pragma mark - 设置字体颜色
- (void)setToatalNumberColor:(UILabel *)lab andStr:(NSString *)str
{
    
    NSRange Range1 = NSMakeRange([str rangeOfString:@"共"].location, [str rangeOfString:@"共"].length);
    NSRange Range2 = NSMakeRange([str rangeOfString:@"件"].location, [str rangeOfString:@"件"].length);
    NSMutableAttributedString *textLabelStr =
    [[NSMutableAttributedString alloc]
     initWithString:str];
    [textLabelStr
     setAttributes:@{NSForegroundColorAttributeName :
                         [UIColor grayColor], NSFontAttributeName :
                         [UIFont systemFontOfSize:17]} range:Range1];
    
    [textLabelStr setAttributes:@{NSForegroundColorAttributeName :
                                      [UIColor grayColor], NSFontAttributeName :
                                      [UIFont systemFontOfSize:17]} range:Range2];
    lab.attributedText = textLabelStr;
}

@end
