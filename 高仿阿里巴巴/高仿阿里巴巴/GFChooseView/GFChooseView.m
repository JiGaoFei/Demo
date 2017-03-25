//
//  GFChooseView.m
//  弹出框
//
//  Created by 1暖通商城 on 2017/3/24.
//  Copyright © 2017年 1暖通商城. All rights reserved.
//

#import "GFChooseView.h"
#import "GFtableviewCell.h"
#import "BadgeButton.h"
#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH    [UIScreen mainScreen].bounds.size.height
// 屏幕宽的比例
#define kWidthScale [UIScreen mainScreen].bounds.size.width / 375
// 屏幕高的比例
#define kHeightScale [UIScreen mainScreen].bounds.size.height / 667
@interface GFChooseView ()<UITableViewDelegate,UITableViewDataSource>
// 存放按钮数组
@property (nonatomic,strong) NSMutableArray *titleBtnArray;
/** 选中的按钮*/
@property (nonatomic, weak) UIButton *selectBtn;
@end
static NSString *identifier = @"GFChooseCell";
@implementation GFChooseView
#pragma mark - 懒加载
// 存放按钮btn
- (NSMutableArray *)titleBtnArray
{
    if (!_titleBtnArray) {
        self.titleBtnArray = [[NSMutableArray alloc]init];
        
    }
    return _titleBtnArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //半透明视图
       self.alphaiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _alphaiView.backgroundColor = [UIColor blackColor];
        _alphaiView.alpha = 0.8;
        [self addSubview:_alphaiView];
        //装载商品信息的视图
       self.whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 200*kHeightScale, self.frame.size.width, self.frame.size.height-200*kHeightScale)];
        _whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_whiteView];
        //商品图片
       self.img = [[UIImageView alloc] initWithFrame:CGRectMake(10*kWidthScale, -20*kHeightScale, 100*kWidthScale, 100*kWidthScale)];
        _img.image = [UIImage imageNamed:@"4"];
        _img.backgroundColor = [UIColor yellowColor];
        _img.layer.cornerRadius = 4;
        _img.layer.borderColor = [UIColor whiteColor].CGColor;
        _img.layer.borderWidth = 5;
        [_img.layer setMasksToBounds:YES];
        [_whiteView addSubview:_img];
        
        
        self.cancelBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(_whiteView.frame.size.width-40*kWidthScale, 10*kHeightScale,30*kWidthScale, 30*kWidthScale);
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"close@3x"] forState:0];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_whiteView addSubview:_cancelBtn];

        //商品价格
        
       self.priceLab = [[UILabel alloc] initWithFrame:CGRectMake(_img.frame.origin.x+_img.frame.size.width+20*kWidthScale, 40*kHeightScale, _whiteView.frame.size.width-(_img.frame.origin.x+_img.frame.size.width+80*kWidthScale), 20*kHeightScale)];
        self.priceLab.textColor = [UIColor redColor];
        _priceLab.font = [UIFont systemFontOfSize:14];
        _priceLab.text = @"¥10";
        [_whiteView addSubview:_priceLab];
        //商品库存
        self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(_img.frame.origin.x+_img.frame.size.width+20*kWidthScale, 10*kHeightScale, _whiteView.frame.size.width-(_img.frame.origin.x+_img.frame.size.width+80*kWidthScale), 20*kHeightScale)];
        _nameLab.textColor = [UIColor blackColor];
        _nameLab.font = [UIFont systemFontOfSize:14*kHeightScale];
        _nameLab.text = @"你想要刘亦菲吗?";
        [_whiteView addSubview:_nameLab];
        //用户所选择商品的尺码和颜色
        self.alertLab = [[UILabel alloc] initWithFrame:CGRectMake(_img.frame.origin.x+_img.frame.size.width+20*kWidthScale, _nameLab.frame.origin.y+_nameLab.frame.size.height +25*kHeightScale, _whiteView.frame.size.width-(_img.frame.origin.x+_img.frame.size.width+80 *kWidthScale), 40*kHeightScale)];
        _alertLab.numberOfLines = 2;
        _alertLab.textColor = [UIColor blackColor];
        _alertLab.font = [UIFont systemFontOfSize:14*kHeightScale];
        _alertLab.text = @"请选择相应的规格";
        [_whiteView addSubview:_alertLab];
        //分界线
        self.lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _img.frame.origin.y+_img.frame.size.height+20*kHeightScale, _whiteView.frame.size.width, 0.5)];
        _lineLab.backgroundColor = [UIColor lightGrayColor];
        [_whiteView addSubview:_lineLab];
        

        //确定按钮
        self.confirmBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(0, _whiteView.frame.size.height-50*kHeightScale,_whiteView.frame.size.width, 50*kHeightScale);
        [_confirmBtn setBackgroundColor:  [UIColor colorWithRed:52.0/255 green:162.0/255 blue:252.0/255 alpha:1]];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:0];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:20*kHeightScale];
        [_confirmBtn setTitle:@"确定" forState:0];
        [_confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_whiteView addSubview:_confirmBtn];
        
        [self setUpTitleScrollView];
        [self setUpAllBtnTitle];
        [self setUpTableView];
        

    }
    return self;
}
#pragma mark - 标题滚动视图
- (void)setUpTitleScrollView{
    //创建视图
    UIScrollView *titleSC = [[UIScrollView alloc] init];
    
    
    UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10*kWidthScale, 310*kHeightScale, 10*kWidthScale, 25*kHeightScale)];
    leftImgView.image = [UIImage imageNamed:@"left"];
    [self addSubview:leftImgView];
    
    UIImageView *rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW - 20*kWidthScale, 310*kHeightScale, 10*kWidthScale, 25*kHeightScale)];
    rightImgView.image = [UIImage imageNamed:@"right"];
    [self addSubview:rightImgView];

    titleSC.frame = CGRectMake(35*kWidthScale, 300*kHeightScale,kScreenW - 70*kWidthScale , 44*kHeightScale);
    
    [self addSubview:titleSC];

    self.titleScrollView = titleSC;
}
#pragma mark - 创建所有的按钮标题
- (void)setUpAllBtnTitle{

    NSMutableArray *dataArray = @[@"白色",@"黄色",@"绿色",@"天蓝色",@"灰色"].mutableCopy;
    self.titleBtnArray = dataArray;
    NSInteger count = dataArray.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = 80*kWidthScale;
    CGFloat btnH = 44*kHeightScale;
    
    for (int i = 0; i < count; i++) {
        //创建按钮
        BadgeButton*btn =[[BadgeButton alloc]init];
        [btn showBadgeWithNumber:99];
        //获取下标
        btn.tag = i;
        
        btnX = i * btnW +20*kWidthScale;
        
        btn.frame = CGRectMake(btnX + 10*kWidthScale, btnY, btnW, btnH);
        //设置按钮标题
       
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:dataArray[i] forState:UIControlStateNormal];
        //监听按钮点击事件
        [btn addTarget:self action:@selector(titleclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.titleScrollView addSubview:btn];
        
        //默认选中第一个
        if (i == 0) {
            [self titleclick:btn];
        }
        //将按钮添加到数组
        [self.titleBtnArray addObject:btn];
    }
    //标题滚动
    self.titleScrollView.contentSize = CGSizeMake(count * btnW, 0);
    
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    
}

#pragma mark - tableView
- (void)setUpTableView
{
    UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 346*kHeightScale, kScreenW, 1)];
    lineLab.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineLab];
    
    UITableView *talbeView = [[UITableView alloc]initWithFrame:CGRectMake(0, 360*kHeightScale, kScreenW, 140*kHeightScale) style:UITableViewStylePlain];

    talbeView.delegate = self;
    talbeView.dataSource = self;
    talbeView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [talbeView registerClass:[GFtableviewCell class] forCellReuseIdentifier:identifier];
    [self addSubview:talbeView];
    
    // 创建件数:
    self.goodsNumberLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW- 160 *kHeightScale, kScreenH - 82 *kHeightScale, 80*kWidthScale, 20*kHeightScale)];
    _goodsNumberLab.textColor = [UIColor redColor];
   NSString *str = @"共0件";
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
    _goodsNumberLab.attributedText = textLabelStr;
    
    
    
    
        [self addSubview:_goodsNumberLab];
    
    // 创建价格
    UILabel *totallPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW - 80*kWidthScale, kScreenH - 82 *kHeightScale, 80*kWidthScale, 20*kHeightScale)];
      totallPriceLab.text = @"0";
    totallPriceLab.textColor = [UIColor redColor];
 
    self.totallMoneyLab  = totallPriceLab;
    [self addSubview:totallPriceLab];
}
#pragma mark - 点击确定按钮
- (void)confirmBtnAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(confirmButtonAction)]) {
        [self.delegate confirmButtonAction];
    }
}
#pragma mark - 点击关闭按钮
- (void)cancelBtnAction:(UIButton *)sender
{
  
    if ([self.delegate respondsToSelector:@selector(closeButtonAction)]) {
        [self.delegate closeButtonAction];
    }
   }
#pragma mark - 监听点击
- (void)titleclick:(UIButton *)btn{
    //选中按钮
    [self selectBtn:btn];
    if ([self.delegate respondsToSelector:@selector(clickBtnIndexWithTag:)]) {
        [self.delegate clickBtnIndexWithTag:btn.tag];
    }
    //按钮角标
    NSInteger i = btn.tag;
    NSLog(@"点击的是:%@",self.titleBtnArray[i]);

}
#pragma mark - 选中的按钮
- (void)selectBtn:(UIButton *)btn{
    
        [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //改变现在选中的标题颜色
    [btn setTitleColor:[UIColor colorWithRed:52.0/255 green:162.0/255 blue:252.0/255 alpha:1] forState:UIControlStateNormal];
    
    //选中的按钮居中显示  本质是: 设置偏移量
    CGFloat offsetX = btn.center.x - kScreenW * 0.5;
    
    //向右
    if (offsetX < 0) {
      
    }
    //最大偏移量
    CGFloat MaxOffsetX = self.titleScrollView.contentSize.width - kScreenW;
    
    //向左
    if (offsetX >MaxOffsetX) {
        offsetX = MaxOffsetX;
    }
        _selectBtn = btn;
}
#pragma mark -tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GFtableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
  
    cell.reduceButtonBlock = ^(NSString *str){
       //  NSLog(@"减号点击事件回调出来了");
        //通知代理做事
        if ([self.delegate respondsToSelector:@selector(clickReduceButtonAction:)]) {
            [self.delegate clickReduceButtonAction:str];
        }
    };
    
    
    cell.addButtonBlock = ^(NSString *str){
       //  NSLog(@"加号点击事件回调出来了");
        if ([self.delegate respondsToSelector:@selector(clickAddButtonAction:)]) {
            [self.delegate clickAddButtonAction:str];
        }
    };
        
        
cell.textInputCompleteBlock = ^(NSString *str)
    {
        //NSLog(@"输入完成事件回调出来 ");
        if ([self.delegate respondsToSelector:@selector(clickKeyBordCompleteAction:)]) {
            [self.delegate clickKeyBordCompleteAction:str];
        }
    };
    
    
    
    
    
    cell.textChangeBlock = ^(NSString *str){
       // NSLog(@"文字改变事件回调出来");
        if ([self.delegate respondsToSelector:@selector(textChangeAction:)]) {
            [self.delegate textChangeAction:str];
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45*kHeightScale;
}
@end
