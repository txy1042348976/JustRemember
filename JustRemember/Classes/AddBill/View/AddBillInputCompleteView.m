//
//  AddBillInputCompleteView.m
//  JustRemember
//
//  Created by rising on 16/5/25.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "AddBillInputCompleteView.h"
#import "CalculatorView.h"
@implementation AddBillInputCompleteView


- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {

        [self addChildView];

        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addChildView{
    
    CGFloat categoryImageLeft = screen_width * 0.05;
    CGFloat categoryImageSize = screen_width * 0.09;
    CGFloat categoryNameLeft = screen_width * 0.03;
    CGFloat priceRight = screen_width * 0.08;
    CGFloat categoryNameH = self.bounds.size.height * 0.29;
    CGFloat priceH = self.bounds.size.height * 0.42;
    CGFloat priceW = screen_width * 0.33;
    
    __weak typeof(self) weakSelf = self;
    //类别图标
    self.categoryImage = [[UIImageView alloc]init];
    [self addSubview:self.categoryImage];
    [self.categoryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(categoryImageLeft);
        make.size.mas_equalTo(categoryImageSize);
        make.centerY.mas_equalTo(weakSelf);
    }];
    
    //类别名称
    self.categoryName = [[UILabel alloc] init];
    self.categoryName.font = [UIFont systemFontOfSize:categoryNameH];
    [self addSubview:self.categoryName];
    [self.categoryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.categoryImage.mas_right).offset(categoryNameLeft);
        make.height.mas_equalTo(categoryNameH);
        make.centerY.mas_equalTo(weakSelf);
    }];
    
    //金额
    self.price = [[UILabel alloc] init];
    self.price.font = [UIFont systemFontOfSize:priceH];
    self.price.numberOfLines =1;
    self.price.adjustsFontSizeToFitWidth =YES;
    self.price.textAlignment = NSTextAlignmentRight;
    [self.price setText:@"0.00"];
    [self addSubview:self.price];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(priceH);
        make.right.mas_equalTo(-priceRight);
        make.centerY.mas_equalTo(weakSelf);
        make.width.mas_equalTo(priceW);
    }];
    
    //分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.93 alpha:1.00];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(screen_width);
        make.height.mas_equalTo(1);
    }];
    
}


@end
