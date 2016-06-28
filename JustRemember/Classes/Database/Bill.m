//
//  Bill.m
//  JustRemember
//
//  Created by risngtan on 16/6/14.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "Bill.h"




@implementation Bill
+ (NSString *)primaryKey {
    return @"billID";
}

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    retu(nonatomic) rn @[];
//}

-(void)modifyMoney:(NSString *)money{
    if ([money isEqualToString:self.money]) {
        return;
    }
    RLMRealm *realm = RLMRealm.defaultRealm;
    Bill *myPuppy = [[Bill objectsWhere:@"billID == %@",self.billID] firstObject];
    [realm transactionWithBlock:^{
        myPuppy.money = money;
    }];

}

-(void)modifyDate:(NSString *)date{
    if ([date isEqualToString:self.date]) {
        return;
    }
    RLMRealm *realm = RLMRealm.defaultRealm;
    Bill *myPuppy = [[Bill objectsWhere:@"billID == %@",self.billID] firstObject];
    [realm transactionWithBlock:^{
        myPuppy.date = date;
    }];
}

-(void)modifyRemarks:(NSString *)remarks{
    if ([remarks isEqualToString:self.remarks]) {
        return;
    }
    RLMRealm *realm = RLMRealm.defaultRealm;
    Bill *myPuppy = [[Bill objectsWhere:@"billID == %@",self.billID] firstObject];
    [realm transactionWithBlock:^{
        myPuppy.remarks = remarks;
    }];
}
-(void)modifyCategory:(Category *)category{
    if (category == self.category) {
        return;
    }
    RLMRealm *realm = RLMRealm.defaultRealm;
    Bill *myPuppy = [[Bill objectsWhere:@"billID == %@",self.billID] firstObject];
    [realm transactionWithBlock:^{
        myPuppy.category = category;
    }];
}

-(void)modifyIsIncome:(NSNumber *)isIncome{
    if ([isIncome isEqual:self.isIncome]) {
        return;
    }
    RLMRealm *realm = RLMRealm.defaultRealm;
    Bill *myPuppy = [[Bill objectsWhere:@"billID == %@",self.billID] firstObject];
    [realm transactionWithBlock:^{
        myPuppy.isIncome = isIncome;
    }];
}

@end
