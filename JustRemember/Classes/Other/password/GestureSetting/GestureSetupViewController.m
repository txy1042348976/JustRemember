//
//  GestureSetupViewController.m
//  TemplatesProject
//
//  Created by OYXJ on 14/12/2.
//  Copyright (c) 2014年 OYXJ. All rights reserved.
//

#import "GestureSetupViewController.h"

#import "TouchIdUnlock.h"//指纹解锁
#import "GestureTool_Public.h"//手势工具
#import "GestureSettingViewController.h"//手势设置页面
#import "DrawPatternLockViewController.h"//绘制手势
#import "GestureIntroduceViewController.h"//手势介绍页面

#import "SystemDefine.h"


static NSString *cellReuseIdentifier = @"com.cellReuseIdentifier";

/**
 手势
 */
@interface GestureSetupViewController () <
UITableViewDataSource,
UITableViewDelegate>
{
    UITableView * _tableView;
    
    //当前系统和设备，是否能够使用指纹解锁
    BOOL _isTouchIdAllowBySystem;
}

@end


@implementation GestureSetupViewController

#pragma mark - life cycle



- (UIView *)mainContentView
{
    /**
     当前系统和设备，是否能够使用指纹解锁
     */
    _isTouchIdAllowBySystem = [[TouchIdUnlock sharedInstance] isTouchIdEnabledOrNotBySystem];
    
    
    UIView * mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    
    
    _tableView = [[UITableView alloc] initWithFrame:mainView.bounds style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = [UIColor clearColor];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseIdentifier];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    
    [mainView addSubview:_tableView];
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
- (void)navline{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -64, screen_width, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.886 alpha:1.000];
    [view addSubview:lineView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 按钮事件

- (void)onNavigationLeftButtonClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
            
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if (![cell.contentView viewWithTag:147258])
    {
        float screenW = [UIScreen mainScreen].bounds.size.width;
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(screenW-90,
                                                                 0,
                                                                 60,
                                                                 cell.bounds.size.height)];
        lb.text = nil;
        lb.textColor = SystemBlue;
        lb.textAlignment = NSTextAlignmentRight;
        
        lb.tag = 147258;//请勿更改这个。
        
        lb.hidden = YES;
        [cell.contentView addSubview: lb];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    
    switch (indexPath.section)
    {
        case 0: //section 0
        {
            switch (indexPath.row)
            {
                case 0: //row 0
                {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    NSString * textLock = @"手势锁定";
                    if (_isTouchIdAllowBySystem) {
                        textLock = @"手势、指纹锁定";
                    }
                    cell.textLabel.text = textLock; //手势这行单元格
                    
                    
                    /**
                     在NSUserDefaults中，是否 已经保存了手势密码
                     */
                    BOOL isHasGestureSavedInNSUserDefaults = [GestureTool_Public isHasGesturePwdStringWhichSavedInNSUserDefaults];
                    
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSNumber * num = [defaults objectForKey:KEY_UserDefaults_isGestureLockEnabledOrNotByUser];
                    /**
                      用户是否 想使用手势锁屏，这个配置，保存在NSUserDefaults。
                     */
                    BOOL isGestureLockEnabledOrNotByUser = [num boolValue];
                    
                    if (isHasGestureSavedInNSUserDefaults &&
                        isGestureLockEnabledOrNotByUser)
                    {
                        UILabel * lb = (UILabel *)[cell.contentView viewWithTag:147258];
                        lb.textColor = SystemBlue;
                        
                        lb.hidden = NO;
                    }
                    else if (!isHasGestureSavedInNSUserDefaults)
                    {
                        UILabel * lb = (UILabel *)[cell.contentView viewWithTag:147258];
                        lb.text = @"未设置";//还没有设置手势密码
                        lb.textColor = SystemGray;
                        
                        lb.hidden = NO;
                    }
                    else if (!isGestureLockEnabledOrNotByUser)
                    {
                        UILabel * lb = (UILabel *)[cell.contentView viewWithTag:147258];
                        lb.textColor = SystemGray;
                        
                        lb.hidden = NO;
                    }
                    
                }break; //row 0
                    
                default:{
                    
                }break;
                    
            }//switch,row.
            
        }break;//section 0
            
            
        default:
        {
        }break;
            
    }//switch,section.
    
    
    return cell;
}


#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)  //switch,section.
    {
        case 0: //section 0
        {
            switch (indexPath.row)  //switch,row
            {
                case 0: //row 0
                {
                    /**
                     在NSUserDefaults中，是否 已经保存了手势密码
                     */
                    BOOL isHasGestureSavedInNSUserDefaults = [GestureTool_Public isHasGesturePwdStringWhichSavedInNSUserDefaults];
                    
                    if (isHasGestureSavedInNSUserDefaults)
                    {
                        /**
                         手势设置页面
                         */
                        GestureSettingViewController * gsVC = [[GestureSettingViewController alloc] init];
                        
                        __block UITableView * ___tableView = _tableView;
                        
                        /**
                         避免 block造成retain-cycle 或 内存泄漏
                         */
                        gsVC.popBackBlock = ^{
                            [___tableView reloadData];
                        };
                        
                        if (_isTouchIdAllowBySystem) {
                            gsVC.title = @"手势、指纹设置";
                        }else{
                            gsVC.title = @"手势设置";
                        }
                        
                        [self.navigationController pushViewController:gsVC animated:YES];
                    }
                    else
                    {
                        /**
                         手势密码介绍页面
                         */
                        GestureIntroduceViewController *giVC = [[GestureIntroduceViewController alloc] init];
                        
                        giVC.title = @"手势密码锁定";
                        [self.navigationController pushViewController:giVC animated:YES];
                    }
                    
                }break;//row 0
                    
                default:
                {
                }break;
                    
            }//switch,row
            
        }break; //section 0
            
        default:
        {
        }break;
            
    }//switch,section.
}



@end
