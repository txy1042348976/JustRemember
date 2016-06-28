//
//  SectionHeaderView.m
//  JustRemember
//
//  Created by rising on 16/5/25.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildView];
        self.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];
    }
    return  self;
}

-(void)addChildView{
    CGFloat labelLeftAndRight = self.bounds.size.width * 0.05;
    CGFloat labelH = self.bounds.size.height * 0.33;
    
//    CGFloat priceLabelRight = self.bounds.size.width * 0.04;
//    CGFloat priceLabelH = self.bounds.size.height * 0.33;
//    CGFloat incomeLabelRigth = self.bounds.size.width * 0.01;
    
    __weak typeof(self) weakSelf = self;
    //日期
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.font = [UIFont systemFontOfSize:labelH];
    self.dateLabel.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1.00];
    self.dateLabel.text = @"05月21日";
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelLeftAndRight);
        make.height.mas_equalTo(labelH);
        make.centerY.mas_equalTo(weakSelf);
    }];
    
    
    
    
}
@end
