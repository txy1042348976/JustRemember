//
//  Category.m
//  JustRemember
//
//  Created by risngtan on 16/6/14.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "Category.h"

@implementation Category

+ (NSString *)primaryKey {
    return @"name";
}

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
