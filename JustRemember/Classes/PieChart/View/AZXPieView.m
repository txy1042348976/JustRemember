 //
//  AZXPieView.m
//  AZXTallyBook
//
//  Created by azx on 16/3/12.
//  Copyright © 2016年 azx. All rights reserved.
//

#import "AZXPieView.h"

@interface AZXPieView ()

@property (strong, nonatomic) NSArray *colorArray;

@property (strong, nonatomic) NSArray *typeArray;

@property (strong, nonatomic) NSArray *percentArray;

@property (strong, nonatomic) NSMutableArray *labelArray;

@end

//IB_DESIGNABLE
@implementation AZXPieView

- (void)drawRect:(CGRect)rect {
    // 先将背景色设为默认
    [[UIColor whiteColor] set];
    UIRectFill(rect);
    
    self.labelArray = [NSMutableArray array];
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(percentsForPieView:)] && [self.dataSource respondsToSelector:@selector(typesForPieView:)] && [self.dataSource respondsToSelector:@selector(colorsForPieView:)]) {
        // 如果代理存在且实现了这些方法
        self.typeArray = [self.dataSource typesForPieView:self];
        self.percentArray = [self.dataSource percentsForPieView:self];
        self.colorArray = [self.dataSource colorsForPieView:self];
        
        // 计算得出各自的起始角度
        NSMutableArray *startAngleArray = [NSMutableArray array];
        
        CGFloat angle = 0;
        
        for (NSInteger i = 0; i < self.percentArray.count; i++) {
            [startAngleArray addObject:[NSNumber numberWithDouble:angle]];
            angle += [self.percentArray[i] doubleValue] * 2 * M_PI / 100;
        }
        
        for (NSInteger j = 0; j < self.typeArray.count; j++) {
            [self drawSectorWithStartAngle:[startAngleArray[j] doubleValue] Percent:[self.percentArray[j] doubleValue]/100 Type:self.typeArray[j] Color:self.colorArray[j]];
        }
        
    }
    
}

- (void)drawSectorWithStartAngle:(double)startAngle Percent:(double)percent Type:(NSString *)type Color:(UIColor *)color {
    CGFloat radius = self.frame.size.width > self.frame.size.height? self.frame.size.height/2 : self.frame.size.width/2;  // 半径取矩形短的一边
    // self.center显示是在超类中的位置，要将偏移量减去
    CGPoint center = self.center;
    center.x -= self.frame.origin.x;
    center.y -= self.frame.origin.y;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:startAngle + 2*M_PI*percent clockwise:YES];

    [path addLineToPoint:center];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    label.text = type;
    
    label.textColor = [UIColor blackColor];
    
    label.backgroundColor = [UIColor clearColor];
    
    label.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [label sizeToFit];
    
    // 判断扇形能不能容纳下label的内容
    // 判断label在垂直于过扇形中点的半径方向的投影是否大于扇形在该处的长度，">"后面用的余弦定理(角度小于180度时有效，故前加一个percent < 0.5的判定)
    // 或者只要小于3%的通通设为..
    if ((percent < 0.5 && label.frame.size.width * fabs(sin(startAngle + M_PI*percent)) > sqrt(2*(radius/2)*(radius/2) - 2*radius/2*radius/2*cos(2*M_PI*percent))) || percent < 0.03) {
        label.text = @"..";
    }
    
    // 找到扇形中心点
    CGFloat centerX = center.x + (radius/2*cos(startAngle + M_PI*percent));
    CGFloat centerY = center.y + (radius/2*sin(startAngle + M_PI*percent));
    
    label.center = CGPointMake(centerX, centerY);

    
    [self addSubview:label];
    
    [self.labelArray addObject:label]; // 将label放入数组，离开界面时一并移除
    
    [color set];
    
    [path fill];

}

- (void)reloadData {
    [self setNeedsDisplay];
}

- (void)removeAllLabel {
    for (UILabel *label in self.labelArray) {
        [label removeFromSuperview];
    }
}

@end
