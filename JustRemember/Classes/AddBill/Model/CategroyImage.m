
//
//  CategroyImage.m
//  note-taking
//
//  Created by rising on 16/5/16.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "CategroyImage.h"

@implementation CategroyImage
+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic {
    CategroyImage *image = [[CategroyImage alloc] init];
    image.icon = imageDic[@"icon"];
    image.name = imageDic[@"name"];
    image.income = imageDic[@"income"];
    image.CategroyID = nil;
    return image;
}
@end
