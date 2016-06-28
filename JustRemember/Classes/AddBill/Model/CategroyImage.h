//
//  CategroyImage.h
//  note-taking
//
//  Created by rising on 16/5/16.
//  Copyright © 2016年 rising. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CategroyImage : NSObject
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *CategroyID;

@property (nonatomic, assign) NSNumber* income;


+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic;

@end
