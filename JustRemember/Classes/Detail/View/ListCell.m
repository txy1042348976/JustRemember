//
//  ListCell.m
//  JustRemember
//
//  Created by risngtan on 16/6/1.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ListCellID";
    // 创建cell
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        //金额或类别或时间
        UILabel *priceOrcategoryOrdateLabel = [[UILabel alloc] init];
        [self addSubview:priceOrcategoryOrdateLabel];
        self.priceOrcategoryOrdateLabel = priceOrcategoryOrdateLabel;
        
        //金额或类别或时间名
        UILabel *priceOrcategoryOrdateNameLabel = [[UILabel alloc] init];
        [self addSubview:priceOrcategoryOrdateNameLabel];
        self.priceOrcategoryOrdateNameLabel = priceOrcategoryOrdateNameLabel;
        
        
        
        
        
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];

    CGFloat priceOrcategoryOrdateNameLabelLeft = self.bounds.size.width * 0.09;
    CGFloat priceOrcategoryOrdateNameLabelH = self.bounds.size.height * 0.3;
    CGFloat priceOrcategoryOrdateLabelRigth = self.bounds.size.width * 0.06;
    __weak typeof(self) weakSelf = self;

    //金额或类别或时间名
    [self.priceOrcategoryOrdateNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(priceOrcategoryOrdateNameLabelLeft);
//        make.width.mas_equalTo(priceOrcategoryOrdateNameLabelW);
        make.height.mas_equalTo(priceOrcategoryOrdateNameLabelH);
    }];
    
    //金额或类别或时间
    [self.priceOrcategoryOrdateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-priceOrcategoryOrdateLabelRigth);
        make.centerY.mas_equalTo(weakSelf);
        make.height.mas_equalTo(priceOrcategoryOrdateNameLabelH);
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
