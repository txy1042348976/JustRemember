//
//  PieChartCell.m
//  JustRemember
//
//  Created by risngtan on 16/6/7.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "PieChartCell.h"

@implementation PieChartCell


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"PieChartCellID";
    // 创建cell
    PieChartCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PieChartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *iconImage = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImage];
        self.iconImage = iconImage;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *thePercentageLabel = [[UILabel alloc] init];
        [self.contentView addSubview:thePercentageLabel];
        self.thePercentageLabel = thePercentageLabel;
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        
    }
    return self;
    
}

// 2.在layoutSubviews方法中设置子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat iconSize = self.contentView.frame.size.height*0.46;
    CGFloat iconLeft = self.contentView.frame.size.width*0.06;
    CGFloat titleLeft = self.contentView.frame.size.width*0.08;
    CGFloat titleH = self.contentView.frame.size.height*0.23;
    CGFloat nameLabelW = self.contentView.frame.size.width * 0.21;
    CGFloat thePercentageLabelW = self.contentView.frame.size.width * 0.18;
    
    
    __weak typeof(self) weakSelf = self;
    //icon
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(iconSize);
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(iconLeft);
    }];
    
    //name
    self.nameLabel.font = [UIFont systemFontOfSize:titleH];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(titleH);
        make.left.mas_equalTo(weakSelf.iconImage.mas_right).offset(titleLeft);
        make.centerY.mas_equalTo(weakSelf);
        make.width.mas_equalTo(nameLabelW);
    }];
    
    //百分百
    [self.thePercentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(titleH);
        make.width.mas_equalTo(thePercentageLabelW);
        make.left.mas_equalTo(weakSelf.nameLabel.mas_right).offset(titleLeft);
        make.centerY.mas_equalTo(weakSelf);
        
    }];
    
    //price
//    [self.priceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:titleH]];
//    self.priceLabel.text = @"9,000";
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(titleH);
        make.centerY.mas_equalTo(weakSelf);
        make.right.mas_equalTo(-iconLeft);
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
