//
//  noteCell.h
//  JustRemember
//
//  Created by risngtan on 16/6/1.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface noteCell : UITableViewCell
/***  备注名称*/
@property (nonatomic, strong) UILabel *noteNameLabel;
/***  备注*/
@property (nonatomic, strong) UILabel *noteLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
