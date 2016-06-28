//
//  DateAndNoteView.m
//  JustRemember
//
//  Created by rising on 16/5/26.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "DateAndNoteView.h"

@implementation DateAndNoteView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildView];
    }
    return self;
}

- (void)addChildView{

    CGFloat dateBtnW = self.bounds.size.width * 0.19;
    CGFloat dateBtnLeft = self.bounds.size.width * 0.06;
    CGFloat dateBtnH = self.bounds.size.height * 0.55;
    CGFloat noteBtnW = self.bounds.size.width * 0.25;
    CGFloat noteBtnRight = self.bounds.size.width * 0.22;
    
    
    
    __weak typeof(self) weakSelf = self;
    //日期按钮
    self.dateBtn = [[UIButton alloc] init];
    [self addSubview:self.dateBtn];
    [self.dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.width.mas_equalTo(dateBtnW);
        make.height.mas_equalTo(dateBtnH);
        make.left.mas_equalTo(dateBtnLeft);
    }];
        [self cornerRadius:self.dateBtn];
    [self.dateBtn setTitle:@"选择日期" forState:UIControlStateNormal];
    [self.dateBtn setTitleColor:[UIColor orangeColor]forState:UIControlStateNormal];

    //备注UITextField
    UITextField *noteTextField = [[UITextField alloc] init];
    [self addSubview:noteTextField];
    [noteTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(noteBtnW);
        make.height.mas_equalTo(dateBtnH);
        make.centerY.mas_equalTo(weakSelf);
        make.right.mas_equalTo(-noteBtnRight);
    }];
    

    
    //备注按钮
    self.noteBtn = [[UIButton alloc] init];
    [self addSubview:self.noteBtn];
    [self.noteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(noteBtnW);
        make.height.mas_equalTo(dateBtnH);
        make.centerY.mas_equalTo(weakSelf);
        make.right.mas_equalTo(-noteBtnRight);
    }];
    
    [self cornerRadius:self.noteBtn];
    [self.noteBtn setTitle:@"写备注" forState:UIControlStateNormal];
    [self.noteBtn setTitleColor:[UIColor orangeColor]forState:UIControlStateNormal];
    
    

//    [self cornerRadius:noteTextField];
    
}



- (void)cornerRadius:(UIButton *)Btn{
    CGFloat dateBtnLeft = self.bounds.size.width * 0.05;
    Btn.layer.borderWidth = 0.4;
    Btn.layer.borderColor = [UIColor orangeColor].CGColor;
    Btn.layer.cornerRadius = dateBtnLeft;
    Btn.layer.masksToBounds = YES;
    Btn.layer.shouldRasterize = YES;
    Btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    Btn.titleLabel.font = [UIFont systemFontOfSize:12];
    Btn.titleLabel.textColor = [UIColor whiteColor];
    Btn.titleLabel.textAlignment = NSTextAlignmentCenter;//按钮文字居中
    
}


@end
