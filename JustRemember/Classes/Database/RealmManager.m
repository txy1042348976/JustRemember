//
//  RealmManager.m
//  JustRemember
//
//  Created by risngtan on 16/6/14.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "RealmManager.h"

#define WEAKSELF __weak typeof(self) weakSelf = self;
static dispatch_once_t onceToken;
@implementation RealmManager
+ (RealmManager *)sharedManager
{
    static RealmManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (RLMResults<Bill *> *)getArrayOfBill
{
    RLMResults<Bill *> *bills = [Bill allObjects];
    return bills;
}

- (RLMResults *)getArrayOfCategory
{
    RLMResults *categorys = [Category allObjects];
    return categorys;
}

-(NSString *)retUUIDString{
    return [[NSUUID UUID] UUIDString];
}



- (void)insertWithBill:(Bill *)bill{
    RLMRealm *realm = RLMRealm.defaultRealm;
    WEAKSELF
    [realm transactionWithBlock:^{
        bill.billID = [weakSelf retUUIDString];
        [Bill createInDefaultRealmWithValue:bill];
    }];
    
}




- (RLMResults *)QueryAndBillDate:(NSString *)date{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date BEGINSWITH %@",date];
    RLMResults *results = [Bill objectsWithPredicate:predicate];
    return results;

}

- (RLMResults *)QueryAndBillDate:(NSString *)date WithIncome:(NSNumber *)income{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date beginswith[c] %@ and isIncome == %@", date, income];
    RLMResults *results = [Bill objectsWithPredicate:predicate];
    return results;
}


- (NSDictionary *)queryTimeData:(RLMResults *)result{
    
    NSMutableArray *ar = [NSMutableArray array];
    NSArray *results = (NSArray *)result;
    for (Bill *account in results){
        [ar addObject:account.date];
        
    }
    NSMutableDictionary *resultsDic = [NSMutableDictionary dictionary];
    for (NSString *dateStr in ar) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date == %@",dateStr];
        RLMResults *cellResults =[result objectsWithPredicate:predicate];
        [resultsDic setObject:cellResults forKey:[(Bill *)cellResults[0] date]];
    }
    return resultsDic;
    
}


- (void)deleteBill:(Bill *)bill{
    if (!bill) {
        return;
    }
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm beginWriteTransaction];
    [realm deleteObject:bill];
    [realm commitWriteTransaction];
}
- (void)deleteCategory:(Category *)category{
    if (!category) {
        return;
    }
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm beginWriteTransaction];
    [realm deleteObject:category];
    [realm commitWriteTransaction];
}



- (NSDictionary *)queryMonthData:(RLMResults *)result{
    
    NSMutableArray *ar = [NSMutableArray array];
    NSArray *results = (NSArray *)result;
    for (Bill *account in results){
        NSString *date = [account.date substringToIndex:7];
        [ar addObject:date];
        
    }
    NSMutableArray *uniqueDates = [NSMutableArray array];
    for (NSInteger i=0; i<ar.count; i++) {
        if (![uniqueDates containsObject:ar[i]]) {
            [uniqueDates addObject:ar[i]];
        }
    }
    NSMutableDictionary *resultsDic = [NSMutableDictionary dictionary];
    for (NSString *dateStr in uniqueDates) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date BEGINSWITH %@",dateStr];
        RLMResults *cellResults =[result objectsWithPredicate:predicate];
        [resultsDic setObject:cellResults forKey:[(Bill *)cellResults[0] date]];
    }


    return resultsDic;
    
}


- (void)deleteCategoryAndBill:(Category *)category{
    RLMRealm *realm = RLMRealm.defaultRealm;
    RLMResults *results = [Bill allObjects];
    for (Bill *bill in results) {
        if (bill.category.name == category.name) {
            [realm beginWriteTransaction];
            [realm deleteObject:category];
            [realm deleteObject:bill];
            [realm commitWriteTransaction];
        }
    }
}



- (void)insertWithCategory:(Category *)category{
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm transactionWithBlock:^{
        [Category createInDefaultRealmWithValue:category];
        
    }];
}

- (NSInteger)numberOfCategoyrCout{
    return [[Category allObjects] count];
}

- (RLMResults *)QueryAndCategory:(NSNumber *)income{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"income == %@",income];
    RLMResults *results = [Category objectsWithPredicate:predicate];
    return results;
}

- (Category *)QueryAndCategoryIndex:(NSInteger )index{
    RLMResults *results = [Category allObjects];

    Category *ca = results[index];
    return ca;
}
- (Category *)QueryAndCategoryIndex:(NSInteger )index Withincome:(NSNumber *)income{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"income == %@",income];
    RLMResults *results = [Category objectsWithPredicate:predicate];
    Category *ca = results[index];
    return ca;
}



@end
