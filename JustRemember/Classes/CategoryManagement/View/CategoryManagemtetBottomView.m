//
//  CategoryManagemtetBottomView.m
//  JustRemember
//
//  Created by risngtan on 16/6/22.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "CategoryManagemtetBottomView.h"

@implementation CategoryManagemtetBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self cornerRadius:self];
        self.addBtn = [[UIButton alloc] init];
        [self.addBtn setImage:[UIImage imageNamed:@"icon_personal_category_add"] forState:UIControlStateNormal];
        [self addSubview:self.addBtn];
        [self addChildView];
        self.backgroundColor = [UIColor colorWithRed:0.122 green:0.808 blue:0.710 alpha:1.000];
    }
    return self;
}

- (void)addChildView{
    
    __weak typeof(self) weakSelf = self;
    
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(weakSelf.bounds.size.width);
        make.height.mas_offset(weakSelf.bounds.size.height);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    
}
- (void)cornerRadius:(UIView *)view{

    view.layer.cornerRadius = self.bounds.size.width/2.0;
//    btn.layer.maskToBounds = width/2.0
    view.layer.masksToBounds = YES;
    view.layer.shouldRasterize = YES;
//    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
}
@end
