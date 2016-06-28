//
//  WatercourseHeaderView.m
//  JustRemember
//
//  Created by risngtan on 16/5/31.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "WatercourseHeaderView.h"

@implementation WatercourseHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
     
        [self addChildView];
        self.backgroundColor = [UIColor colorWithRed:0.34 green:0.82 blue:0.76 alpha:1.00];
    }
    return self;
}

- (void)addChildView{
    
    CGFloat yearLabelH = self.bounds.size.height * 0.22;
    CGFloat yearLabelW = self.bounds.size.width * 0.13;
    CGFloat yearLabelLeft = self.bounds.size.width * 0.07;
    CGFloat yearIncomeNameLabelLeft = self.bounds.size.width * 0.10;
    CGFloat yearIncomePriceLabelLeft = self.bounds.size.width * 0.03;
    CGFloat yearLabelF = self.bounds.size.height * 0.20;

    
    __weak typeof(self) weakSelf = self;

    //年
    self.yearLabel = [[UILabel alloc] init];
    [self addSubview:self.yearLabel];
    self.yearLabel.textColor = [UIColor whiteColor];
    self.yearLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:yearLabelF];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.width.mas_equalTo(yearLabelW);
        make.height.mas_equalTo(yearLabelH);
        make.left.mas_equalTo(yearLabelLeft);
    }];
    
    //收入标题
    self.yearIncomeNameLabel = [[UILabel alloc] init];
    [self addSubview:self.yearIncomeNameLabel];
    [self cornerRadius:self.yearIncomeNameLabel];
    [self.yearIncomeNameLabel setText:@"收"];
    self.yearIncomeNameLabel.textColor = [UIColor whiteColor];
    self.yearIncomeNameLabel.font = [UIFont systemFontOfSize:10];
    self.yearIncomeNameLabel.textAlignment = NSTextAlignmentCenter;//对齐方式
    [self.yearIncomeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(yearLabelH);
        make.top.mas_equalTo(yearLabelH);
        make.left.mas_equalTo(weakSelf.yearLabel.mas_right).offset(yearIncomeNameLabelLeft);
    }];
    
    //收入
    self.yearIncomePriceLabel = [[UILabel alloc] init];
    [self addSubview:self.yearIncomePriceLabel];
    self.yearIncomePriceLabel.textColor = [UIColor whiteColor];
    [self.yearIncomePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(yearLabelH);
        make.height.mas_equalTo(yearLabelH);
        make.left.mas_equalTo(weakSelf.yearIncomeNameLabel.mas_right).offset(yearIncomePriceLabelLeft);
    }];
    
    //支出标题
    self.yearInoutNameLabel = [[UILabel alloc] init];
    [self addSubview:self.yearInoutNameLabel];
    [self cornerRadius:self.yearInoutNameLabel];
    [self.yearInoutNameLabel setText:@"支"];
    self.yearInoutNameLabel.font = [UIFont systemFontOfSize:10];
    self.yearInoutNameLabel.textAlignment = NSTextAlignmentCenter;
    self.yearInoutNameLabel.textColor = [UIColor whiteColor];
    [self.yearInoutNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(yearLabelH);
        make.top.mas_equalTo(weakSelf.yearIncomePriceLabel.mas_bottom).offset(yearIncomePriceLabelLeft);
        make.left.mas_equalTo(weakSelf.yearLabel.mas_right).offset(yearIncomeNameLabelLeft);

    }];
    
    //支出
    self.yearInoutPriceLabel = [[UILabel alloc] init];
    [self addSubview:self.yearInoutPriceLabel];
    self.yearInoutPriceLabel.textColor = [UIColor whiteColor];
    [self.yearInoutPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.yearIncomePriceLabel.mas_bottom).offset(yearIncomePriceLabelLeft);
        make.height.mas_equalTo(yearLabelH);
        make.left.mas_equalTo(weakSelf.yearInoutNameLabel.mas_right).offset(yearIncomePriceLabelLeft);
    }];
    
    //结余标题
    self.yearSurplusNameLabel = [[UILabel alloc] init];
    self.yearSurplusNameLabel.textAlignment = NSTextAlignmentRight;
    self.yearSurplusNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.yearSurplusNameLabel];
    [self.yearSurplusNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-yearLabelLeft);
        make.height.mas_equalTo(yearLabelH);
        make.bottom.mas_equalTo(weakSelf).offset(-yearLabelH);
    }];
    
    //结余
    self.yearSurplusPriceLabel = [[UILabel alloc] init];
    self.yearSurplusPriceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.yearSurplusPriceLabel];
    self.yearSurplusPriceLabel.textColor = [UIColor whiteColor];
    [self.yearSurplusPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(yearLabelH);
        make.height.mas_equalTo(yearLabelH);
        make.right.mas_equalTo(-yearLabelLeft);
    }];

}

- (void)cornerRadius:(UILabel *)label{
    CGFloat dateBtnLeft = self.bounds.size.width * 0.008;
    label.layer.borderWidth = 0.5;
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.layer.cornerRadius = dateBtnLeft;
    label.layer.masksToBounds = YES;
    label.layer.shouldRasterize = YES;
    label.layer.rasterizationScale = [UIScreen mainScreen].scale;
}


@end
