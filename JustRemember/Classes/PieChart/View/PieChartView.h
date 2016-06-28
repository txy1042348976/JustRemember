//
//  PieChartView.h
//  JustRemember
//
//  Created by risngtan on 16/6/7.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartView : UIView
/***  起始日期*/
@property (nonatomic, strong) UIButton *leftBtn;
/***  终止日期*/
@property (nonatomic, strong) UIButton *rightBtn;
/***  日期*/
@property (nonatomic, strong) UIButton *date;
@end
