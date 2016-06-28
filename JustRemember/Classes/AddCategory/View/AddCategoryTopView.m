//
//  AddCategoryTopView.m
//  JustRemember
//
//  Created by risngtan on 16/6/15.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "AddCategoryTopView.h"

@implementation AddCategoryTopView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self){
        [self addChildView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addChildView{

    CGFloat categoryImageSize = screen_width * 0.09;
    CGFloat left = screen_width * 0.06;

    
    
    __weak typeof(self) weakSelf = self;
    self.categoryImage = [[UIImageView alloc] init];
    [self addSubview:self.categoryImage];
    
    [self.categoryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(categoryImageSize);
        make.left.mas_equalTo(left);
        make.centerY.mas_equalTo(weakSelf);
    }];
    

    self.categoryName = [[UITextField alloc] init];
    self.categoryName.placeholder = @"输入类别名";
    self.categoryName.adjustsFontSizeToFitWidth =YES;
    self.categoryName.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.categoryName];
    
    [self.categoryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.categoryImage.mas_right).offset(1);
        make.right.mas_equalTo(weakSelf).offset(-left);
    }];
    
    //分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:0.79 green:0.79 blue:0.79 alpha:1.00];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(screen_width);
        make.height.mas_equalTo(1);
    }];
}


@end
