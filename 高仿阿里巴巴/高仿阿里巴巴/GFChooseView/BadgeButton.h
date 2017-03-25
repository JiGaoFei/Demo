//
//  BadgeButton.h
//  弹出框
//
//  Created by 1暖通商城 on 2017/3/25.
//  Copyright © 2017年 1暖通商城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeButton : UIButton
/** 显示按钮角标的label */ @property (nonatomic,strong) UILabel *badgeLabel;
- (void)showBadgeWithNumber:(NSInteger)badgeNumber;
@end
