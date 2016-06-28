//
//  TopView.m
//  JustRemember
//
//  Created by rising on 16/5/25.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "TopView.h"
@implementation TopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //添加子控件
        [self addChildView];
        self.backgroundColor=[UIColor colorWithRed:0.16 green:0.83 blue:0.76 alpha:1.00];
    }
    
    return self;
}

-(void)addChildView{

    CGFloat BtnWaterCourseRight = self.bounds.size.width*(-0.05);
    CGFloat BtnNameLabelH = self.bounds.size.height*0.07;
    CGFloat monthlySpendingH = self.bounds.size.height*0.13;
    CGFloat monthlySpendingTop = self.bounds.size.height*0.48;
    CGFloat incomeMonthlyH = self.bounds.size.height*0.06;
    CGFloat incomeMonthlyLetf = self.bounds.size.width*0.16;
    CGFloat monthlyIncomeBottom = self.bounds.size.height*(-0.05);
    CGFloat LineH = self.bounds.size.height*0.17;
    
    __weak typeof(self) weakSelf = self;
//    //用户按钮
//    self.userBtn = [[UIButton alloc] init];
//    [self.userBtn setBackgroundImage:[UIImage imageNamed:@"home_setting"] forState:UIControlStateNormal];
//    [self addSubview:self.userBtn];
//    [self.userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(BtnH);
//        make.left.mas_equalTo(BtnLeft);
//        make.top.mas_equalTo(BtnTop);
//    }];
//    
//    //用户名
//    self.nameLabel = [[UILabel alloc] init];
//    self.nameLabel.textColor = [UIColor whiteColor];
//    self.nameLabel.text = @"12321321312";
//    self.nameLabel.font = [UIFont systemFontOfSize:BtnH];
//    [self addSubview:self.nameLabel];
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(BtnNameLabelH);
//        make.centerY.mas_equalTo(weakSelf.userBtn);
//        make.centerX.mas_equalTo(weakSelf);
//    }];
//    
//    //提醒按钮
//    self.remindBtn = [[UIButton alloc] init];
//    [self.remindBtn setBackgroundImage:[UIImage imageNamed:@"home_notification"] forState:UIControlStateNormal];
//    [self addSubview:self.remindBtn];
//    [self.remindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(BtnH);
//        make.width.mas_equalTo(BtnH-3);
//        make.top.mas_equalTo(BtnTop);
//        make.right.mas_equalTo(BtnRight);
//    }];
//    
//    //流水按钮
//    self.waterCourseBtn = [[UIButton alloc] init];
//    [self.waterCourseBtn setBackgroundImage:[UIImage imageNamed:@"icon_personal_calender"] forState:UIControlStateNormal];
//    [self addSubview:self.waterCourseBtn];
//    [self.waterCourseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(BtnH);
//        make.top.mas_equalTo(BtnTop);
//        make.right.mas_equalTo(weakSelf.remindBtn.mas_left).offset(BtnWaterCourseRight-10);
//        
//    }];
    
    //月支出金额
    self.monthlySpendingLabel = [[UILabel alloc] init];
    self.monthlySpendingLabel.textColor = [UIColor whiteColor];
    self.monthlySpendingLabel.font = [UIFont systemFontOfSize:monthlySpendingH];
    self.monthlySpendingLabel.text = @"0.00";
    [self addSubview:self.monthlySpendingLabel];
    [self.monthlySpendingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(monthlySpendingH);
        make.top.mas_equalTo(weakSelf).offset(monthlySpendingTop);
        make.centerX.mas_equalTo(weakSelf);
        
    }];
    
    //月支出标题
    self.spendingMonthlyLabel = [[UILabel alloc] init];
    self.spendingMonthlyLabel.textColor = [UIColor whiteColor];
    self.spendingMonthlyLabel.font = [UIFont systemFontOfSize:BtnNameLabelH];
    self.spendingMonthlyLabel.text = @"5月支出";
    [self addSubview:self.spendingMonthlyLabel];
    [self.spendingMonthlyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(BtnNameLabelH);
        make.centerX.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.monthlySpendingLabel.mas_bottom).offset(BtnNameLabelH);
    }];
    
    //月收入标题
    self.incomeMonthlyLabel = [[UILabel alloc] init];
    self.incomeMonthlyLabel.textColor = [UIColor whiteColor];
    self.incomeMonthlyLabel.font = [UIFont systemFontOfSize:incomeMonthlyH];
    self.incomeMonthlyLabel.text = @"5月收入";
    [self addSubview:self.incomeMonthlyLabel];
    [self.incomeMonthlyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(incomeMonthlyH);
        make.bottom.mas_equalTo(weakSelf).offset(BtnWaterCourseRight);
        make.left.mas_equalTo(weakSelf).offset(incomeMonthlyLetf);
        
    }];
    
    //月收入金额
    self.monthlyIncomeLabel = [[UILabel alloc] init];
    self.monthlyIncomeLabel.textColor = [UIColor whiteColor];
    self.monthlyIncomeLabel.font = [UIFont systemFontOfSize:BtnNameLabelH];
    self.monthlyIncomeLabel.text = @"0.00";
    [self addSubview:self.monthlyIncomeLabel];
    [self.monthlyIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(BtnNameLabelH);
        make.centerX.mas_equalTo(weakSelf.incomeMonthlyLabel);
        make.bottom.mas_equalTo(weakSelf.incomeMonthlyLabel.mas_top).offset(monthlyIncomeBottom);
        
    }];
    
    //月结余标题
    self.balanceMonthlyLabel = [[UILabel alloc] init];
    self.balanceMonthlyLabel.textColor = [UIColor whiteColor];
    self.balanceMonthlyLabel.font = [UIFont systemFontOfSize:incomeMonthlyH];
    self.balanceMonthlyLabel.text = @"5月结余";
    [self addSubview:self.balanceMonthlyLabel];
    
    [self.balanceMonthlyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(BtnWaterCourseRight);
        make.height.mas_equalTo(incomeMonthlyH);
        make.right.mas_equalTo(-incomeMonthlyLetf);
    }];

    //月结余金额
    self.monthlyBalanceLabel = [[UILabel alloc] init];
    self.monthlyBalanceLabel.textColor = [UIColor whiteColor];
    self.monthlyBalanceLabel.font = [UIFont systemFontOfSize:BtnNameLabelH];
    self.monthlyBalanceLabel.text = @"0.00";
    [self addSubview:self.monthlyBalanceLabel];
    
    [self.monthlyBalanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(BtnNameLabelH);
        make.centerX.mas_equalTo(weakSelf.balanceMonthlyLabel);
        make.bottom.mas_equalTo(weakSelf.balanceMonthlyLabel.mas_top).offset(monthlyIncomeBottom);
    }];
    
    //线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(LineH);
        make.width.mas_equalTo(1);
        make.centerX.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(-BtnNameLabelH);
    }];
}
@end
