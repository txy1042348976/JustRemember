//
//  TopView.h
//  JustRemember
//
//  Created by rising on 16/5/25.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopView : UIView
/**
 *  用户头像按钮
 */
@property (nonatomic, strong) UIButton *userBtn;
/**
 *  用户名
 */
@property (nonatomic, strong) UILabel *nameLabel;
/**
 *  流水按钮
 */
@property (nonatomic, strong) UIButton *waterCourseBtn;
/**
 *  提醒按钮
 */
@property (nonatomic, strong) UIButton *remindBtn;
/**
 *  月支出金额
 */
@property (nonatomic, strong) UILabel *monthlySpendingLabel;
/**
 *  月支出标题
 */
@property (nonatomic, strong) UILabel *spendingMonthlyLabel;
/**
 *  月收入金额
 */
@property (nonatomic, strong) UILabel *monthlyIncomeLabel;
/**
 *  月收入标题
 */
@property (nonatomic, strong) UILabel *incomeMonthlyLabel;
/**
 *  月结余金额
 */
@property (nonatomic, strong) UILabel *monthlyBalanceLabel;
/**
 *  月结余标题
 */
@property (nonatomic, strong) UILabel *balanceMonthlyLabel;
@end
