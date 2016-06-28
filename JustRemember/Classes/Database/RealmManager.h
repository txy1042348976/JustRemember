//
//  RealmManager.h
//  JustRemember
//
//  Created by risngtan on 16/6/14.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bill.h"
#import "Category.h"
@interface RealmManager : NSObject
/**
 *  单例
 */
+ (RealmManager *)sharedManager;
/**
 *  生成UUID
 */
-(NSString *)retUUIDString;
/**
 *  增加一条数据
 */
- (void)insertWithBill:(Bill *)bill;
/**
 *  删除一条数据
 */
- (void)deleteBill:(Bill *)bill;
/**
 *  删除一条数据
 */
- (void)deleteCategory:(Category *)category;

- (void)deleteCategoryAndBill:(Category *)category;
/**
 
 *  根据时间查询账单
 */
- (RLMResults *)QueryAndBillDate:(NSString *)date;
- (NSDictionary *)queryTimeData:(RLMResults *)result;
- (NSDictionary *)queryMonthData:(RLMResults *)result;

/**
 *  查询所有类别
 */
- (RLMResults *)getArrayOfCategory;
/**
 *  增加类别
 */
- (void)insertWithCategory:(Category *)category;
/**
 *  根据时间和收支类别查询Bill
 */
- (RLMResults *)QueryAndBillDate:(NSString *)date WithIncome:(NSNumber *)income;
/**
 *  根据位置和收支类别查询类别
 */
- (Category *)QueryAndCategoryIndex:(NSInteger )index Withincome:(NSNumber *)income;
/**
 *  类别数目
 */
- (NSInteger)numberOfCategoyrCout;
/**
 *  类别收支
 */
- (RLMResults *)QueryAndCategory:(NSNumber *)income;
@end
