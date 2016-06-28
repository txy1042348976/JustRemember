//
//  AddCategoryCell.m
//  JustRemember
//
//  Created by risngtan on 16/6/15.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "AddCategoryCell.h"

@implementation AddCategoryCell
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
    
    CGFloat categoryImageSize = screen_width * 0.09;
    __weak typeof(self) weakSelf = self;
    //类别图片
    self.categoryImage = [[UIImageView alloc] init];
    self.categoryImage.backgroundColor = [UIColor clearColor];
    [self addSubview:self.categoryImage];
    [self.categoryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(categoryImageSize);
        make.bottom.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
    }];
    

}


@end
