//
//  HomeController.m
//  JustRemember
//
//  Created by rising on 16/5/24.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "HomeController.h"
#import "HomeCell.h"
#import "TopView.h"
#import "BottomView.h"
#import "SectionHeaderView.h"
#import "addBillController.h"
#import "WatercourseController.h"
#import "DetailController.h"
#import "PieChartController.h"
#import "RealmManager.h"
#import "MMSheetView.h"
#import "CategoryManagementController.h"
#import "UIBarButtonItem+RXExtension.h"
#import "CategroyImage.h"
#import "GestureSetupViewController.h"



@interface HomeController ()<
UITableViewDelegate,
UITableViewDataSource,
UIViewControllerPreviewingDelegate
>




@property (nonatomic , strong) UITableView *HomeTableView;
@property (nonatomic , strong) UIView *bottomView;
@property (nonatomic , strong) TopView *topView;
@property (nonatomic , strong) BottomView *botView;
@property (nonatomic, strong) NSMutableArray<CategroyImage *> *images;///<类别数组


@property (nonatomic, strong) NSMutableArray *allkeys;
@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic,weak)UITableViewCell *selectedCell;

@property (strong,nonatomic) NSUserDefaults *myDefaults;







@end

@implementation HomeController
#pragma mark - 懒加载
- (NSMutableArray *)images {
    //从plist文件中取出字典数组，并封装成对象模型，存入模型数组中
    if (!_images) {
        _images = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"类别.plist" ofType:nil];
        
        NSArray *imageDics = [NSArray arrayWithContentsOfFile:path];
        
        for (NSDictionary *imageDic in imageDics) {
            
            CategroyImage *image = [CategroyImage imageWithImageDic:imageDic];
            [_images addObject:image];
        }
    }
    return _images;
}

-(UITableView *)HomeTableView{
    if (!_HomeTableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,screen_height*0.38, screen_width, screen_height - screen_height*0.38-screen_height*0.11)];
        tableView.delegate = self;
        tableView.dataSource = self;
        _HomeTableView = tableView;
    }
    return _HomeTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self setTopView];
    [self setBotView];
    [self setExtraCellLineHidden:self.HomeTableView];
    
    self.allkeys = [NSMutableArray array];

    [self.view addSubview:self.HomeTableView];
    [self.HomeTableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCellID"];
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    //选择自己喜欢的颜色
    UIColor * color = [UIColor whiteColor];
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    //大功告成
    self.navigationController.navigationBar.titleTextAttributes = dict;

//
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self searchBill];
    [self database];
    self.allkeys = [self sortArray:self.dataDic.allKeys ascending:NO];
    [self calculateMonthsMoney];
    [self.HomeTableView reloadData];
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"MM"];
    
    NSString *locationString=[dateformatter stringFromDate:senddate];
    self.topView.incomeMonthlyLabel.text = [NSString stringWithFormat:@"%@月收入",locationString];
    self.topView.balanceMonthlyLabel.text = [NSString stringWithFormat:@"%@月结余",locationString];
    self.topView.spendingMonthlyLabel.text = [NSString stringWithFormat:@"%@月支出",locationString];
    
}

- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}





#pragma mark - 类别数据库
-(void)database{
    if ([[RealmManager sharedManager] numberOfCategoyrCout]==0) {
        RealmManager *databse = [[RealmManager alloc] init];
        Category *CA = [[Category alloc] init];
        for (NSInteger i = 0;i < self.images.count; i++) {
            CA.name = self.images[i].name;
            CA.CategoryID = [databse retUUIDString];
            CA.icon = self.images[i].icon;
            CA.income = self.images[i].income;
            [[RealmManager sharedManager] insertWithCategory:CA];
        }
    }
}

- (void)setupSubViews
{
    self.navigationItem.title = @"随便记账";

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"icon_personal_calender" hltImg:@"icon_personal_calender"  width:20 height:20 target:self action:@selector(Watercourse)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"" hltImg:@""  width:10 height:18 target:self action:nil];
    

}
-(void)Watercourse{
    WatercourseController *vc = [[WatercourseController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBill{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM"];
    
    NSString *locationString=[dateformatter stringFromDate:senddate];
    
    
    RLMResults *results = [[RealmManager sharedManager] QueryAndBillDate:locationString];
    NSDictionary *dc = [[RealmManager sharedManager] queryTimeData:results];
    self.dataDic = dc;
}

- (void)calculateMonthsMoney {
    // 先将数据取得添加到暂时数组中，防止每次调用这方法在没有数据改变的情况下金额显示增大
    float tmpTotalIncome = 0;
    float tmpTotalExpense = 0;
    for (NSInteger i = 0; i < self.allkeys.count; i++) {
        NSArray *results = (NSArray *)[[RealmManager sharedManager] QueryAndBillDate:self.allkeys[i]];
         double income = 0;
        double expense = 0;
        for (Bill *account in results) {
            if ([account.isIncome isEqual:@YES]) {
                income += [account.money doubleValue];
            } else {
                expense += [account.money doubleValue];
            }
        }
        // 加到暂存总收入支出中
        tmpTotalIncome += income;
        tmpTotalExpense += expense;
        
    }
    double remainMoney = tmpTotalIncome - tmpTotalExpense;
    
    // 将暂存值赋给属性以显示在UI上
    self.topView.monthlySpendingLabel.text = [NSString stringWithFormat:@"%0.2f",tmpTotalIncome];
    self.topView.monthlyIncomeLabel.text = [NSString stringWithFormat:@"%0.2f",tmpTotalExpense];
    self.topView.monthlyBalanceLabel.text = [NSString stringWithFormat:@"%0.2f",remainMoney];
    
}



#pragma mark - 排序
- (NSMutableArray *)sortArray:(NSArray *)array ascending:(BOOL)ascending{
    //比较操作
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch
    | NSNumericSearch
    | NSWidthInsensitiveSearch
    | NSForcedOrderingSearch;
    NSLocale *currentLocale = [NSLocale currentLocale];
    
    NSArray *finderSortArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSRange string1Range = NSMakeRange(0, [obj2 length]);
        //ascending ? 生序:降序
        return ascending?[obj1 compare:obj2 options:comparisonOptions range:string1Range locale:currentLocale]:[obj2 compare:obj1 options:comparisonOptions range:string1Range locale:currentLocale];
    }];
    return (NSMutableArray *)finderSortArray;
    
}

#pragma mark - TopView
- (void)setTopView{
self.topView =[[TopView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height*0.38)];
[self.view addSubview:self.topView];

[self.topView.waterCourseBtn addTarget:self action:@selector(Watercourse) forControlEvents:UIControlEventTouchUpInside];
}




#pragma mark - 底部视图
- (void)setBotView{
    CGFloat y = screen_height*0.38 + (screen_height - screen_height*0.38-screen_height*0.11);
    self.botView = [[BottomView alloc] initWithFrame:CGRectMake(0, y, screen_width, screen_height*0.11)];
    [self.view addSubview:self.botView];
    [self.botView.addBillBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.botView.pieChartBtn addTarget:self action:@selector(pie) forControlEvents:UIControlEventTouchUpInside];
    [self.botView.settingBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)add{
    addBillController *VC = [[addBillController alloc] init];

    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:2];
    [self.navigationController pushViewController:VC animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];

  
    
}



- (void)pie{
    PieChartController *vc = [[PieChartController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)setting{
    MMPopupItemHandler block = ^(NSInteger index){
        if (index == 0) {
            CategoryManagementController *vc = [[CategoryManagementController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(index == 1){
            GestureSetupViewController * gVC = [[GestureSetupViewController alloc] init];
            
            [self.navigationController pushViewController: gVC animated:YES];
        }
    };
    
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
    };
    NSArray *items =
    @[
      MMItemMake(@"类别管理", MMItemTypeNormal, block),
      MMItemMake(@"密码与提醒", MMItemTypeNormal, block),
      MMItemMake(@"关于", MMItemTypeNormal, block)
      ];
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"设置"
                                                          items:items];
    sheetView.attachedView.mm_dimBackgroundBlurEnabled = NO;
    [sheetView showWithBlock:completeBlock];
}



#pragma mark - UITableViewDataSource
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.allkeys.count;
}
//cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = self.allkeys[section];
    RLMResults *results = self.dataDic[key];
    return results.count;
}
//cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat tableViewH = screen_height*0.11;
    return tableViewH;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [HomeCell cellWithTableView:self.HomeTableView];
    NSString *key = self.allkeys[indexPath.section];
    RLMResults *results = self.dataDic[key];
    Bill *bill = results[indexPath.row];
    cell.iconView.image = [UIImage imageNamed:bill.category.icon];
    if ([bill.isIncome isEqual: @YES] ) {
        cell.priceLabel.textColor = [UIColor greenColor];
    }else{
        cell.priceLabel.textColor = [UIColor blackColor];
    }
    cell.priceLabel.text = bill.money;
    cell.titleLabel.text = bill.category.name;
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionHeaderView *headView = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height * 0.05)];
    headView.dateLabel.text = self.allkeys[section];

    return headView;
}

//组头视图
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

  return self.allkeys[section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailController *vc = [[DetailController alloc] init];

    NSString *key = self.allkeys[indexPath.section];
    RLMResults *results = self.dataDic[key];
    Bill *bill = results[indexPath.row];
    vc.bill = bill;
    [self.navigationController pushViewController:vc animated:YES];
}





//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//       
//        NSString *key = self.allkeys[indexPath.section];
//        RLMResults *results = self.dataDic[key];
//        Bill *bill = results[indexPath.row];
//         [[RealmManager sharedManager] deleteBill:bill];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        
//        
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//
//    }
//    [self.HomeTableView reloadData];
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}




@end
