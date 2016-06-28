//
//  AddBillInputCompleteView.h
//  JustRemember
//
//  Created by rising on 16/5/25.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBillInputCompleteView : UIView
/**
 *  类别图片
 */
@property (nonatomic , strong) UIImageView *categoryImage;
/**
 *  类别名称
 */
@property (nonatomic , strong) UILabel *categoryName;
/**
 *  金额
 */
@property (nonatomic , strong) UILabel *price;


@end
