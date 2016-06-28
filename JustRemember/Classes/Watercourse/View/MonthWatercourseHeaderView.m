//
//  MonthWatercourseHeaderView.m
//  JustRemember
//
//  Created by risngtan on 16/6/1.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "MonthWatercourseHeaderView.h"
@interface MonthWatercourseHeaderView ()



@end

@implementation MonthWatercourseHeaderView

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
    
    __weak typeof(self) weakSelf = self;
    //日期
    self.monthLabel = [[UILabel alloc] init];
    self.monthLabel.font = [UIFont systemFontOfSize:labelH];
    self.monthLabel.textColor = [UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1.00];
    [self addSubview:self.monthLabel];
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelLeftAndRight);
        make.height.mas_equalTo(labelH);
        make.centerY.mas_equalTo(weakSelf);
    }];
    
    
    
    
    

    
}

@end
