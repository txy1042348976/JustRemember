//
//  ListCell.h
//  JustRemember
//
//  Created by risngtan on 16/6/1.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell
/***  金额或者类别或者时间*/
@property (nonatomic, strong) UILabel *priceOrcategoryOrdateLabel;
/***  金额或者类别或者时间名*/
@property (nonatomic, strong) UILabel *priceOrcategoryOrdateNameLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
