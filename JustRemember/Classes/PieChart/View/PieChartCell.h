//
//  PieChartCell.h
//  JustRemember
//
//  Created by risngtan on 16/6/7.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartCell : UITableViewCell
/***  图*/
@property (nonatomic, strong) UIImageView *iconImage;
/***  名称 */
@property (nonatomic, strong) UILabel *nameLabel;
/***  百分百*/
@property (nonatomic, strong) UILabel *thePercentageLabel;
/***  金额*/
@property (nonatomic, strong) UILabel *priceLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
