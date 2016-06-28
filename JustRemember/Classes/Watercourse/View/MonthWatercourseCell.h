//
//  MonthWatercourseCell.h
//  JustRemember
//
//  Created by risngtan on 16/6/1.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthWatercourseCell : UITableViewCell
@property (weak, nonatomic) UIImageView *iconView;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *priceLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
