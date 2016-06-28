//
//  AZXPieView.h
//  AZXTallyBook
//
//  Created by azx on 16/3/12.
//  Copyright © 2016年 azx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AZXPieView;

@protocol AZXPieViewDataSource <NSObject>

@required

- (NSArray *)percentsForPieView:(AZXPieView *)pieView;
- (NSArray *)typesForPieView:(AZXPieView *)pieView;
- (NSArray *)colorsForPieView:(AZXPieView *)pieView;

@end

@interface AZXPieView : UIView

@property (weak, nonatomic) id<AZXPieViewDataSource> dataSource;

- (void)reloadData;

- (void)removeAllLabel;

@end
