//
//  HomeCell.h
//  JustRemember
//
//  Created by rising on 16/5/24.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell
@property (weak, nonatomic) UIImageView *iconView;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *priceLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
