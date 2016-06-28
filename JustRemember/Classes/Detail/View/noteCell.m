//
//  noteCell.m
//  JustRemember
//
//  Created by risngtan on 16/6/1.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "noteCell.h"

@implementation noteCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"noteCellID";
    // 创建cell
    noteCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[noteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //备注名称
        UILabel *noteNameLabel = [[UILabel alloc] init];
        [self addSubview:noteNameLabel];
        self.noteNameLabel = noteNameLabel;
        
        //备注
        UILabel *noteLabel = [[UILabel alloc] init];
        [noteLabel setTextColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:1.00]];
        [self addSubview:noteLabel];
        self.noteLabel = noteLabel;

        
    }
    return self;
    
}

- (void)layoutSubviews{
    CGFloat noteNameLabelLeft = self.bounds.size.width * 0.09;
    CGFloat noteNameLabelTop = self.bounds.size.height * 0.21;

    __weak typeof(self) weakSelf = self;
    
    //备注名称
    [self.noteNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(noteNameLabelLeft);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(noteNameLabelTop);
    }];
    //备注
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.noteNameLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(noteNameLabelLeft);
        make.right.mas_equalTo(-noteNameLabelLeft);
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
