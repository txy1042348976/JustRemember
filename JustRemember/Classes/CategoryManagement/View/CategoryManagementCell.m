//
//  CategoryManagementCell.m
//  JustRemember
//
//  Created by risngtan on 16/6/21.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "CategoryManagementCell.h"

@implementation CategoryManagementCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        [self addChildView];
        
    }
    
    return self;
}

- (void)addChildView{
    
    CGFloat categoryImageSize = self.bounds.size.width * 0.47;
    CGFloat categoryImageTop = self.bounds.size.height * 0.30;
    CGFloat categroyNameTop = self.bounds.size.height * 0.11;
    CGFloat categroyNameH = self.bounds.size.height * 0.17;
    
    
    __weak typeof(self) weakSelf = self;
    //类别图片
    self.categoryImage = [[UIImageView alloc] init];
    self.categoryImage.backgroundColor = [UIColor clearColor];
    [self addSubview:self.categoryImage];
    [self.categoryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(categoryImageSize);
        make.top.mas_equalTo(categoryImageTop);
        make.centerX.mas_equalTo(weakSelf);
    }];
    
    //类别名
    self.categroyName = [[UILabel alloc] init];
    self.categroyName.textAlignment = NSTextAlignmentCenter;
    self.categroyName.font = [UIFont systemFontOfSize:categroyNameH];
    self.categroyName.backgroundColor = [UIColor clearColor];
    [self addSubview:self.categroyName];
    [self.categroyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(categroyNameH);
        make.top.mas_equalTo(weakSelf.categoryImage.mas_bottom).offset(categroyNameTop);
        make.centerX.mas_equalTo(weakSelf);
    }];
}

@end
