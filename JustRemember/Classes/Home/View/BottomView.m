//
//  BottomView.m
//  JustRemember
//
//  Created by rising on 16/5/25.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return  self;
}

-(void)addChildView{
    CGFloat pieAndSetSize = self.bounds.size.height*0.36;
    CGFloat BtnLeft = self.bounds.size.width*0.06;
    CGFloat addBtnH = self.bounds.size.height*0.56;
    CGFloat addBtnW = self.bounds.size.width*0.16;

    __weak typeof(self) weakSelf = self;
    //饼图按钮
    self.pieChartBtn = [[UIButton alloc] init];
    [self.pieChartBtn setBackgroundImage:[UIImage imageNamed:@"btn_ statistics"] forState:UIControlStateNormal];
    [self addSubview:self.pieChartBtn];
    [self.pieChartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(pieAndSetSize);
        make.left.mas_equalTo(BtnLeft);
//        make.bottom.mas_equalTo(-Btnbottom);
        make.centerY.mas_equalTo(weakSelf);

    }];
    
    //添加账目
    self.addBillBtn = [[UIButton alloc] init];
    [self.addBillBtn setBackgroundImage:[UIImage imageNamed:@"btn_add_personal_expense"] forState:UIControlStateNormal];
    [self addSubview:self.addBillBtn];
    [self.addBillBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(addBtnH);
        make.width.mas_equalTo(addBtnW);
        make.centerY.mas_equalTo(weakSelf);
        make.centerX.mas_equalTo(weakSelf);
    }];
    
    
    //设置
    self.settingBtn = [[UIButton alloc] init];
    [self.settingBtn setBackgroundImage:[UIImage imageNamed:@"home_more_buttton"] forState:UIControlStateNormal];
    [self addSubview:self.settingBtn];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(pieAndSetSize-5);
        make.right.mas_equalTo(-BtnLeft);
        make.centerY.mas_equalTo(weakSelf);
    }];
    
    //分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.96 alpha:1.00];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(screen_width);
    }];
    
}

@end
