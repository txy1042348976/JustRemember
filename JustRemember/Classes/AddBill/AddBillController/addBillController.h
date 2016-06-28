//
//  addBillController.h
//  JustRemember
//
//  Created by rising on 16/5/25.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealmManager.h"

@interface addBillController : UIViewController
@property (nonatomic) double firstNumber;
@property (nonatomic) double secondNumber;
@property (nonatomic) NSString *symbol;
@property (nonatomic) Boolean numStarted;
@property (nonatomic) Boolean numPressed;
@property (nonatomic, assign) NSNumber *isNav;
@property (nonatomic, strong) Bill *bill;
@end
