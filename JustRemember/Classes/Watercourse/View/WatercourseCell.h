//
//  WatercourseCell.h
//  JustRemember
//
//  Created by risngtan on 16/5/31.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatercourseCell : UITableViewCell
/***  月份 */
@property (nonatomic, strong) UILabel *monthLabel;
/***  月收入标题 */
@property (nonatomic, strong) UILabel *monthIncomeNameLabel;
/***  月收入 */
@property (nonatomic, strong) UILabel *monthIncomePriceLabel;
/***  月支出标题 */
@property (nonatomic, strong) UILabel *monthInoutNameLabel;
/***  月支出 */
@property (nonatomic, strong) UILabel *monthInoutPriceLabel;
/***  月结余标题 */
@property (nonatomic, strong) UILabel *monthSurplusNameLabel;
/***  月结余 */
@property (nonatomic, strong) UILabel *monthSurplusPriceLabel;




+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
