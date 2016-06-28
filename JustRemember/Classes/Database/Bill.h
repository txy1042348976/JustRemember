//
//  Bill.h
//  JustRemember
//
//  Created by risngtan on 16/6/14.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <Realm/Realm.h>
@class Category;
@interface Bill : RLMObject
/**
 *  账单主键id
 */
@property NSString *billID;
/**
 *  时间
 */
@property NSString *date;
/**
 *  收入支出
 */
@property NSNumber<RLMBool> *isIncome;
/**
 *  金额
 */
@property NSString *money;
/**
 *  备注
 */
@property NSString *remarks;
/**
 *  外键
 */
@property Category *category;

/***修改金额*/
-(void)modifyMoney:(NSString *)money;
/***修改时间*/
-(void)modifyDate:(NSString *)date;
/***修改备注*/
-(void)modifyRemarks:(NSString *)remarks;
/***修改类别*/
-(void)modifyCategory:(Category *)category;
/***修改收支*/
-(void)modifyIsIncome:(NSNumber *)isIncome;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Bill>
RLM_ARRAY_TYPE(Bill)
