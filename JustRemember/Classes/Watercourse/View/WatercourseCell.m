//
//  WatercourseCell.m
//  JustRemember
//
//  Created by risngtan on 16/5/31.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "WatercourseCell.h"

@implementation WatercourseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"WatercourseCellID";
    // 创建cell
    WatercourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WatercourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat yearLabelF = self.bounds.size.height * 0.30;

        /***  月份 */
        UILabel *monthLabel = [[UILabel alloc] init];
        monthLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:yearLabelF];
        [self.contentView addSubview:monthLabel];
        self.monthLabel = monthLabel;
        
        /***  月收入标题 */
        UILabel *monthIncomeNameLabel = [[UILabel alloc] init];
        monthIncomeNameLabel.font = [UIFont systemFontOfSize:13];
        monthIncomeNameLabel.textColor = [UIColor colorWithRed:0.47 green:0.82 blue:0.75 alpha:1.00];
        [self.contentView addSubview:monthIncomeNameLabel];
        self.monthIncomeNameLabel = monthIncomeNameLabel;
        
        /***  月收入 */
        UILabel *monthIncomePriceLabel = [[UILabel alloc] init];
        monthIncomePriceLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:monthIncomePriceLabel];
        self.monthIncomePriceLabel = monthIncomePriceLabel;
        
        /***  月支出标题 */
        UILabel *monthInoutNameLabel = [[UILabel alloc] init];
        monthInoutNameLabel.font = [UIFont systemFontOfSize:13];
        monthInoutNameLabel.textColor = [UIColor colorWithRed:0.94 green:0.64 blue:0.55 alpha:1.00];
        [self.contentView addSubview:monthInoutNameLabel];
        self.monthInoutNameLabel = monthInoutNameLabel;
        
        /***  月支出 */
        UILabel *monthInoutPriceLabel = [[UILabel alloc] init];
        monthInoutPriceLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:monthInoutPriceLabel];
        self.monthInoutPriceLabel = monthInoutPriceLabel;
        
        /***  月结余标题 */
        UILabel *monthSurplusNameLabel = [[UILabel alloc] init];
        monthSurplusNameLabel.font = [UIFont systemFontOfSize:13];
        monthSurplusNameLabel.textAlignment = NSTextAlignmentRight;

        [self.contentView addSubview:monthSurplusNameLabel];
        self.monthSurplusNameLabel = monthSurplusNameLabel;
        
        /***  月结余 */
        UILabel *monthSurplusPriceLabel = [[UILabel alloc] init];
        monthSurplusPriceLabel.font = [UIFont systemFontOfSize:13];
        monthSurplusPriceLabel.textAlignment = NSTextAlignmentRight;

        [self.contentView addSubview:monthSurplusPriceLabel];
        self.monthSurplusPriceLabel = monthSurplusPriceLabel;
        
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat monthLabelH = self.bounds.size.height * 0.29;
    CGFloat monthLabelLeft = self.bounds.size.width * 0.07;
    CGFloat monthLabelW = self.bounds.size.width * 0.13;
    CGFloat monthIncomeNameLabelLeft = self.bounds.size.width * 0.10;
     CGFloat monthIncomeNameLabelTop = self.bounds.size.height * 0.15;
    CGFloat monthIncomePriceLabelLeft = self.bounds.size.width * 0.03;
    CGFloat monthInoutNameLabelTop = self.bounds.size.height * 0.12;




    
    __weak typeof(self) weakSelf = self;
    //月份
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(monthLabelH);
        make.width.mas_equalTo(monthLabelW);
        make.left.mas_equalTo(monthLabelLeft);
        make.centerY.mas_equalTo(weakSelf);
    }];
    
    //月收入标题
    [self.monthIncomeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(monthLabelH);
        make.left.mas_equalTo(weakSelf.monthLabel.mas_right).offset(monthIncomeNameLabelLeft);
        make.top.mas_equalTo(monthIncomeNameLabelTop);
    }];
    
    //月收入
    [self.monthIncomePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(monthIncomeNameLabelTop);
        make.height.mas_equalTo(monthLabelH);
        make.left.mas_equalTo(weakSelf.monthIncomeNameLabel.mas_right).offset(monthIncomePriceLabelLeft);
    }];
    
    //月支出标题
    [self.monthInoutNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(monthLabelH);
        make.top.mas_equalTo(weakSelf.monthIncomePriceLabel.mas_bottom).offset(monthInoutNameLabelTop);
        make.left.mas_equalTo(weakSelf.monthLabel.mas_right).offset(monthIncomeNameLabelLeft);
        
    }];
    
    //月支出
    [self.monthInoutPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(monthLabelH);
        make.top.mas_equalTo(weakSelf.monthIncomePriceLabel.mas_bottom).offset(monthInoutNameLabelTop);
        make.left.mas_equalTo(weakSelf.monthInoutNameLabel.mas_right).offset(monthIncomePriceLabelLeft);
        
    }];
    
    //月结余
    [self.monthSurplusPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(monthLabelH);
        make.right.mas_equalTo(weakSelf).offset(-monthIncomeNameLabelLeft);
        make.top.mas_equalTo(monthIncomeNameLabelTop);

    }];
    
    
    //月结余标题
    [self.monthSurplusNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.monthSurplusPriceLabel.mas_bottom).offset(monthInoutNameLabelTop);
        make.height.mas_equalTo(monthLabelH);
        make.right.mas_equalTo(weakSelf).offset(-monthIncomeNameLabelLeft);
        
    }];
    

    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
