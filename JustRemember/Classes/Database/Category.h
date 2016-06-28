//
//  Category.h
//  JustRemember
//
//  Created by risngtan on 16/6/14.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <Realm/Realm.h>

@interface Category : RLMObject
/**
 *  类别主键ID
 */
@property NSString* CategoryID;
/**
 *  类别图片文件名
 */
@property NSString *icon;
/**
 *  类别名称
 */
@property NSString *name;
@property NSNumber<RLMBool> *income;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Category>
RLM_ARRAY_TYPE(Category)
