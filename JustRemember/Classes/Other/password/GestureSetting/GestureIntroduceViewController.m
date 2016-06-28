//
//  GestureIntroduceViewController.m
//  TemplatesProject
//
//  Created by OYXJ on 15/8/6.
//  Copyright (c) 2015年 OYXJ. All rights reserved.
//

#import "GestureIntroduceViewController.h"

#import "DrawPatternLockViewController.h"//绘制手势
#import "GestureSettingViewController.h"//手势设置页面
#import "GestureTool_Public.h"//手势工具
#import "TouchIdUnlock.h"//指纹解锁

#import "SystemDefine.h"


/**
 手势密码介绍页面
 */
@interface GestureIntroduceViewController ()<
DrawPatternLockViewControllerDelegate>
{
    UIImageView * _gestureImgView;
    UIButton    * _gestureButton;
}
@end


@implementation GestureIntroduceViewController

- (UIView *)mainContentView
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if(appName.length <= 0)
        appName = @"";
    
    
    
    UIView * mainView = [[UIView alloc] initWithFrame:m_mainContentViewFrame];
    mainView.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
    
    
    
    _gestureImgView = [[UIImageView alloc] initWithFrame:CGRectMake(mainView.bounds.size.width * (195.0/640.0),
                                                                    mainView.bounds.size.width * (100.0/1010.0),
                                                                    mainView.bounds.size.width * (220.0/640.0),
                                                                    mainView.bounds.size.height * (460.0/1010.0) )];
    _gestureImgView.image = [UIImage imageNamed:@"gesture_introduce"];
    
    
    
    _gestureButton = [[UIButton alloc] initWithFrame:CGRectMake(15,
                                                                mainView.bounds.size.height * (730.0/1010.0),
                                                                mainView.bounds.size.width - 15*2,
                                                                40)];
    _gestureButton.layer.cornerRadius = 5.0f;
    _gestureButton.layer.masksToBounds = YES;
    
    UIImage * aImg = [self imageWithColor:[UIColor colorWithRed:56.0/255.0 green:187.0/255.0 blue:204.0/255.0 alpha:1.0]];
    [_gestureButton setBackgroundImage:aImg forState:UIControlStateNormal];
    [_gestureButton setTitle:@"创建手势密码" forState:UIControlStateNormal];
    [_gestureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gestureButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [_gestureButton addTarget:self action:@selector(onGestureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    float yDelta = _gestureButton.frame.origin.y - (_gestureImgView.frame.origin.y + _gestureImgView.frame.size.height);
    UILabel * lb = [[UILabel alloc] init];
    lb.frame = CGRectMake(15,
                          (yDelta * 60.0/160.0) + (_gestureImgView.frame.origin.y + _gestureImgView.frame.size.height),
                          mainView.bounds.size.width - 15*2,
                          36);
    lb.text = [NSString stringWithFormat:@"你可以创建一个%@解锁图片，这样他人在借用你的手机时，将无法打开%@。", appName, appName];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont systemFontOfSize:15.0];
    lb.numberOfLines = 2;
    
    
    [mainView addSubview: _gestureImgView];
    [mainView addSubview: _gestureButton];
    [mainView addSubview: lb];
    
    return mainView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        [self navline];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"手势"];
    
    UIColor * color = [UIColor colorWithWhite:0.518 alpha:1.000];
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    //大功告成
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"navigationbar_arrow_back" hltImg:@"navigationbar_arrow_back"  width:10 height:18 target:self action:@selector(goToBack)];
}


- (void)goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)navline{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -64, screen_width, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.886 alpha:1.000];
    [view addSubview:lineView];
    
}


#pragma mark - 按钮事件

- (void)onGestureButtonClicked:(UIButton *)sender
{
    /**
     手势设置页面
     */
    GestureSettingViewController * gsVC = [[GestureSettingViewController alloc] init];
    gsVC.title = @"手势设置";
    if ([[TouchIdUnlock sharedInstance] canVerifyTouchID]) {
        gsVC.title = @"手势、指纹设置";
    }
    
    gsVC.view.hidden = YES;
    [self.navigationController pushViewController:gsVC animated:NO];
    NSTimeInterval timeInSec = 0.5;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, timeInSec * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        gsVC.view.hidden = NO;
    });
    
    
    /**
     设置新的手势密码
     */
    DrawPatternLockViewController * dplVC = [[DrawPatternLockViewController alloc] init];
    
    dplVC.drawPatternCtlType = kDrawPatternCtlTypeGesturePwdSetup;
    
    dplVC.delegate = self;
    
    dplVC.title = @"新的手势密码";
    [self.navigationController pushViewController:dplVC animated:YES];
}


#pragma mark - <DrawPatternLockViewControllerDelegate>

- (void)drawPatternLockViewController:(DrawPatternLockViewController *)aViewController
             finishDrawPatternWithKey:(NSString *)key
{
    if (aViewController.drawPatternCtlType == kDrawPatternCtlTypeGesturePwdSetup &&
        aViewController.isSetupOrModifyGestureComplete)
    {
        if ([[self.navigationController topViewController] isEqual:aViewController]) {
            // do nothing
            //DrawPatternLockViewController这个类的内部，会调用popViewControllerAnimated出栈。
        }
    }
    else if (  aViewController.drawPatternCtlType == kDrawPatternCtlTypeGesturePwdSetup &&
             ! aViewController.isSetupOrModifyGestureComplete)
    {
        [self.navigationController popToViewController:self animated:YES];
    }
}



#pragma mark - 自定义

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


@end
