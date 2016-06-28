//
//  WatercourseHeaderView.h
//  JustRemember
//
//  Created by risngtan on 16/5/31.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatercourseHeaderView : UIView
/***  年 */
@property (nonatomic, strong) UILabel *yearLabel;
/***  收入标题 */
@property (nonatomic, strong) UILabel *yearIncomeNameLabel;
/***  收入 */
@property (nonatomic, strong) UILabel *yearIncomePriceLabel;
/***  支出标题 */
@property (nonatomic, strong) UILabel *yearInoutNameLabel;
/***  支出 */
@property (nonatomic, strong) UILabel *yearInoutPriceLabel;
/***  结余标题 */
@property (nonatomic, strong) UILabel *yearSurplusNameLabel;
/***  结余 */
@property (nonatomic, strong) UILabel *yearSurplusPriceLabel;


@end
