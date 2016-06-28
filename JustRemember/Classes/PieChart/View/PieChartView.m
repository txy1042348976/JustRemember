//
//  PieChartView.m
//  JustRemember
//
//  Created by risngtan on 16/6/7.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "PieChartView.h"

@implementation PieChartView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildView];
        self.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    }
    return self;
}

- (void)addChildView{
    
    CGFloat dateW = screen_width * 0.2;
    CGFloat dateH = self.bounds.size.height * 0.37;
    CGFloat BtnRight = screen_width * 0.05;
    CGFloat BtnLeft = screen_width * 0.06;
    CGFloat btnW = screen_width * 0.025;
    __weak typeof(self) weakSelf = self;

    self.date = [[UIButton alloc] init];
    [self.date setTitle:@"2016-06" forState:UIControlStateNormal];
    self.date.titleLabel.font = [UIFont systemFontOfSize: dateH];
    [self.date setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self addSubview:self.date];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(dateW);
        make.height.mas_equalTo(dateH);
        make.center.mas_equalTo(weakSelf);
    }];
    
    self.leftBtn = [[UIButton alloc] init];
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_book_chart_arrow_left.png"] forState:UIControlStateNormal];
    [self addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.date.mas_left).offset(-BtnRight);
        make.centerY.mas_equalTo(weakSelf);
        make.width.mas_equalTo(btnW);
        make.height.mas_equalTo(dateH);
    }];
    
    self.rightBtn = [[UIButton alloc] init];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_book_chart_arrow_right.png"] forState:UIControlStateNormal];
    [self addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.date.mas_right).offset(BtnLeft);
        make.centerY.mas_equalTo(weakSelf);
        make.width.mas_equalTo(btnW);
        make.height.mas_equalTo(dateH);
    }];
    

}

@end
