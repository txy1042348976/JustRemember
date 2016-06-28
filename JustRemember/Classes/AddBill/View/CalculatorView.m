//
//  CalculatorView.m
//  JustRemember
//
//  Created by risngtan on 16/5/30.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "CalculatorView.h"
#import "AddBillInputCompleteView.h"

@interface CalculatorView()



@end
@implementation CalculatorView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addChildView];
        self.backgroundColor = [UIColor colorWithRed:0.10 green:0.11 blue:0.11 alpha:1.00];
    }
    return self;
}

- (void)addChildView{
    CGFloat CalculatorBtnH = self.bounds.size.height * 0.25;
    CGFloat CalculatorBtnW = self.bounds.size.width * 0.25;
    __weak typeof(self) weakSelf = self;

    //加
    self.jia = [[UIButton alloc] init];
    self.jia.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.jia setTitleColor:[UIColor colorWithRed:0.97 green:0.78 blue:0.49 alpha:1.00] forState:UIControlStateNormal];
    [self.jia setTitle:@"+" forState:UIControlStateNormal];
    [self addSubview:self.jia];
    [self.jia mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(CalculatorBtnH + 1);
        make.left.mas_equalTo(weakSelf).offset(CalculatorBtnW * 3 + 3);
        
    }];
    
    //减法
    self.jian = [[UIButton alloc] init];
    self.jian.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.jian setTitleColor:[UIColor colorWithRed:0.97 green:0.78 blue:0.49 alpha:1.00] forState:UIControlStateNormal];
    [self.jian setTitle:@"-" forState:UIControlStateNormal];

    [self addSubview:self.jian];
    [self.jian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(CalculatorBtnH * 2 + 2);
        make.left.mas_equalTo(weakSelf).offset(CalculatorBtnW * 3 + 3);
    }];
    
    // =
    self.equal = [[UIButton alloc] init];
    self.equal.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.equal setTitleColor:[UIColor colorWithRed:0.97 green:0.78 blue:0.49 alpha:1.00] forState:UIControlStateNormal];
    [self.equal setTitle:@"=" forState:UIControlStateNormal];
    [self addSubview:self.equal];
    [self.equal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(CalculatorBtnH * 3 + 3);
        make.left.mas_equalTo(weakSelf).offset(CalculatorBtnW * 2 + 2);
    }];
    

    
    
    //.
    self.point = [[UIButton alloc] init];
    self.point.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.point setTitle:@"." forState:UIControlStateNormal];
    [self addSubview:self.point];
    [self.point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(CalculatorBtnH * 3 + 3);
        make.left.mas_equalTo(weakSelf).offset(0);
        
    }];
    
    // 0
    self.touch0 = [[UIButton alloc] init];
    self.touch0.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.touch0 setTitle:@"0" forState:UIControlStateNormal];
    [self addSubview:self.touch0];
    [self.touch0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(CalculatorBtnH * 3 + 3);
        make.left.mas_equalTo(weakSelf).offset(CalculatorBtnW + 1);
        
    }];
    
    //1
    self.touch1 = [[UIButton alloc] init];
    self.touch1.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.touch1 setTitle:@"1" forState:UIControlStateNormal];
    [self addSubview:self.touch1];
    [self.touch1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(CalculatorBtnH * 2 + 2);
        make.left.mas_equalTo(weakSelf).offset(0);
        
    }];
    
    // 2
    self.touch2 = [[UIButton alloc] init];
    self.touch2.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.touch2 setTitle:@"2" forState:UIControlStateNormal];
    [self addSubview:self.touch2];
    [self.touch2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(CalculatorBtnH * 2 + 2);
        make.left.mas_equalTo(weakSelf).offset(CalculatorBtnW + 1);
    }];
    
    // 3
    self.touch3 = [[UIButton alloc] init];
    self.touch3.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.touch3 setTitle:@"3" forState:UIControlStateNormal];
    [self addSubview:self.touch3];
    [self.touch3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(CalculatorBtnH * 2 + 2);
        make.left.mas_equalTo(weakSelf).offset(CalculatorBtnW * 2 + 2);
        
    }];
    
    // 4
    self.touch4 = [[UIButton alloc] init];
    self.touch4.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.touch4 setTitle:@"4" forState:UIControlStateNormal];
    [self addSubview:self.touch4];
    [self.touch4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(CalculatorBtnH + 1);
        make.left.mas_equalTo(weakSelf).offset(0);
        
    }];
    
    // 5
    self.touch5 = [[UIButton alloc] init];
    self.touch5.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.touch5 setTitle:@"5" forState:UIControlStateNormal];

    [self addSubview:self.touch5];
    [self.touch5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(CalculatorBtnH + 1);
        make.left.mas_equalTo(weakSelf).offset(CalculatorBtnW + 1);
    }];
    
    // 6
    self.touch6 = [[UIButton alloc] init];
    self.touch6.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.touch6 setTitle:@"6" forState:UIControlStateNormal];
    [self addSubview:self.touch6];
    [self.touch6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(CalculatorBtnH + 1);
        make.left.mas_equalTo(weakSelf).offset(CalculatorBtnW * 2 + 2);
    }];
    
    // 7
    self.touch7 = [[UIButton alloc] init];
    self.touch7.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.touch7 setTitle:@"7" forState:UIControlStateNormal];
    [self addSubview:self.touch7];
    [self.touch7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(0);
        make.left.mas_equalTo(weakSelf).offset(0);
        
    }];
    
    // 8
    self.touch8 = [[UIButton alloc] init];
    self.touch8.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.touch8 setTitle:@"8" forState:UIControlStateNormal];
    [self addSubview:self.touch8];
    [self.touch8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(0);
        make.left.mas_equalTo(weakSelf).offset(CalculatorBtnW + 1);
    }];
    
    // 9
    self.touch9 = [[UIButton alloc] init];
    self.touch9.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.touch9 setTitle:@"9" forState:UIControlStateNormal];
    [self addSubview:self.touch9];
    [self.touch9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(0);
        make.left.mas_equalTo(weakSelf).offset(CalculatorBtnW * 2 + 2);
    }];
    
    //clear
    self.clear = [[UIButton alloc] init];
    self.clear.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.clear setTitle:@"C" forState:UIControlStateNormal];
    [self.clear setTitleColor:[UIColor colorWithRed:0.97 green:0.78 blue:0.49 alpha:1.00] forState:UIControlStateNormal];
    [self addSubview:self.clear];
    [self.clear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(0);
        make.left.mas_equalTo(weakSelf).offset(CalculatorBtnW * 3 + 3);
    }];
    
    //ok
    self.okBtn = [[UIButton alloc] init];
    self.okBtn.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    [self.okBtn setTitle:@"OK" forState:UIControlStateNormal];
    [self.okBtn setTitleColor:[UIColor colorWithRed:0.97 green:0.78 blue:0.49 alpha:1.00] forState:UIControlStateNormal];
    [self addSubview:self.okBtn];
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CalculatorBtnH);
        make.width.mas_equalTo(CalculatorBtnW);
        make.top.mas_equalTo(weakSelf).offset(CalculatorBtnH * 3 + 3);
        make.left.mas_equalTo(weakSelf).offset(CalculatorBtnW * 3 + 3);
    }];
    
     
}





@end
