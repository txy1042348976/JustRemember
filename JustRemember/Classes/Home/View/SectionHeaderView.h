//
//  SectionHeaderView.h
//  JustRemember
//
//  Created by rising on 16/5/25.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionHeaderView : UIView
/***  日期*/
@property (nonatomic , strong) UILabel *dateLabel;
/***  金额*/
@property (nonatomic , strong) UILabel *priceLabel;
/***  收支*/
@property (nonatomic, strong) UILabel *incomeLabel;
@end
