//
//  HomeCell.m
//  JustRemember
//
//  Created by rising on 16/5/24.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "HomeCell.h"
@interface HomeCell()

@end
@implementation HomeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HomeCellID";
    // 创建cell
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
            cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *iconView = [[UIImageView alloc] init];
         self.iconView = iconView;
        [self.contentView addSubview:iconView];
       
        
        UILabel *titleLabel = [[UILabel alloc] init];
         self.titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
       
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = [UIColor orangeColor];
        self.priceLabel = priceLabel;
        [self.contentView addSubview:priceLabel];
        
     
        
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

    
    __weak typeof(self) weakSelf = self;
    //icon
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(iconSize);
        make.centerY.mas_equalTo(weakSelf);
        make.left.mas_equalTo(iconLeft);
    }];
    
    //title
    self.titleLabel.font = [UIFont systemFontOfSize:titleH];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(titleH);
        make.left.mas_equalTo(weakSelf.iconView.mas_right).offset(titleLeft);
        make.centerY.mas_equalTo(weakSelf);
    }];
    
    //price
    [self.priceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:titleH]];
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
