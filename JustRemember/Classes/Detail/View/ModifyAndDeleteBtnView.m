//
//  ModifyAndDeleteBtn.m
//  JustRemember
//
//  Created by risngtan on 16/6/2.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "ModifyAndDeleteBtnView.h"

@implementation ModifyAndDeleteBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildView];
    }
    return self;
}

- (void)addChildView{
    __weak typeof(self) weakSelf = self;

    //按钮
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"addExpenseErrorButton"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.95 green:0.60 blue:0.00 alpha:1.00] forState:UIControlStateNormal];
    [self addSubview:btn];
    self.modifyAndDeleteBtn = btn;
    [self.modifyAndDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
    }];
    
}

@end
