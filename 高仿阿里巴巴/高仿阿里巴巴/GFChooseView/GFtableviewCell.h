//
//  GFtableviewCell.h
//  弹出框
//
//  Created by 1暖通商城 on 2017/3/25.
//  Copyright © 2017年 1暖通商城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFtableviewCell : UITableViewCell

// 规格lab
@property (nonatomic,strong)UILabel *sizeLab;
// 加按钮
@property (nonatomic ,strong)UIButton *addBtn;
// 减按钮
@property (nonatomic,strong) UIButton *reduceBtn;
//数量lab
@property (nonatomic,strong) UITextField *numberTextField;
// 点击加号按钮回调
@property (nonatomic,copy) void(^addButtonBlock)(NSString *str);
// 点击减号回调
@property (nonatomic,copy) void(^reduceButtonBlock)(NSString *str);
// 监听文字改变时候的回调
@property (nonatomic,copy) void(^textChangeBlock)(NSString *str);
// 文字输入点击完成时候的回调
@property (nonatomic,copy) void(^textInputCompleteBlock)(NSString *str);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
