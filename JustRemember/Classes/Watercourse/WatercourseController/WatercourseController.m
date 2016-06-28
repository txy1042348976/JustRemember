//
//  WatercourseController.m
//  JustRemember
//
//  Created by risngtan on 16/5/31.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "WatercourseController.h"
#import "WatercourseHeaderView.h"
#import "WatercourseCell.h"
#import "MonthWatercourseController.h"
#import "RealmManager.h"

@interface WatercourseController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic , strong) UITableView *WatercourseTableView;

@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSDictionary *monthDic;

@property (nonatomic, strong) NSArray *allkeys;
@property (nonatomic, strong) NSArray *monthAllkeys;


@property (nonatomic, strong) NSString *income;
@property (nonatomic, strong) NSString *outIncome;
@property (nonatomic, strong) NSString *balance;
@property (nonatomic, strong) NSString *monthIncome;
@property (nonatomic, strong) NSString *monthOutIncome;
@property (nonatomic, strong) NSString *monthBalance;
@property (nonatomic, strong) NSString *year;


@end

@implementation WatercourseController
#pragma mark - 懒加载
-(UITableView *)WatercourseTableView{
    if (!_WatercourseTableView) {
        UITableView *WatercourseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
        WatercourseTableView.delegate = self;
        WatercourseTableView.dataSource = self;
        _WatercourseTableView = WatercourseTableView;
        
    }
    return _WatercourseTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setTitle:@"流水统计"];
    [self.view addSubview:self.WatercourseTableView];
    [self.WatercourseTableView registerClass:[WatercourseCell class] forCellReuseIdentifier:@"WatercourseCellID"];

    self.allkeys = [NSArray array];
    self.monthAllkeys = [NSArray array];
    [self setCustomLeftButton];
    [self navline];



}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self searchMonthBill];
    [self searchYearBill];

    self.allkeys = [self sortArray:self.dic.allKeys ascending:NO];
    self.monthAllkeys = [self sortArray:self.monthDic.allKeys ascending:NO];
    [self calculateYearsMoney];
    


}

- (void)navline{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screen_width, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.886 alpha:1.000];
    [view addSubview:lineView];

}


//查询月
- (void)searchMonthBill{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY"];
    
    NSString *locationString=[dateformatter stringFromDate:senddate];

    RLMResults *results = [[RealmManager sharedManager] QueryAndBillDate:locationString];
    NSDictionary *dc = [[RealmManager sharedManager] queryMonthData:results];
    self.monthDic = dc;
}


//查询年
- (void)searchYearBill{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY"];
  
    
    NSString *locationString=[dateformatter stringFromDate:senddate];
    self.year = locationString;
    RLMResults *results = [[RealmManager sharedManager] QueryAndBillDate:locationString];
    NSDictionary *dc = [[RealmManager sharedManager] queryTimeData:results];
    self.dic = dc;
}

#pragma mark - 排序
- (NSArray *)sortArray:(NSArray *)array ascending:(BOOL)ascending{
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
    return finderSortArray;
    
}


#pragma MARK - 计算年的收入支付结余
- (void)calculateYearsMoney {
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
    self.outIncome = [NSString stringWithFormat:@"%0.2f",tmpTotalIncome];
    self.income = [NSString stringWithFormat:@"%0.2f",tmpTotalExpense];
    self.balance = [NSString stringWithFormat:@"%0.2f",remainMoney];
    
}
#pragma mark - 计算月份的收入支出结余
- (void)calculateMonthsMoney:(NSInteger )index{
    // 先将数据取得添加到暂时数组中，防止每次调用这方法在没有数据改变的情况下金额显示增大
    float tmpTotalIncome = 0;
    float tmpTotalExpense = 0;
//    for (NSInteger i = 0; i < self.monthAllkeys.count; i++) {
        NSString *key = self.monthAllkeys[index];
         NSString *yearmonth = [key substringToIndex:7];
        NSArray *results = (NSArray *)[[RealmManager sharedManager] QueryAndBillDate:yearmonth];
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
        
//    }
    double remainMoney = tmpTotalIncome - tmpTotalExpense;
    
    // 将暂存值赋给属性以显示在UI上
    self.monthOutIncome= [NSString stringWithFormat:@"%0.2f",tmpTotalIncome];
    self.monthIncome = [NSString stringWithFormat:@"%0.2f",tmpTotalExpense];
    self.monthBalance = [NSString stringWithFormat:@"%0.2f",remainMoney];
    
}




#pragma mark - 返回按钮
- (void)setCustomLeftButton {
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.monthAllkeys.count;
    
}
//cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat tableViewH = screen_height*0.12;
    return tableViewH;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WatercourseCell *cell = [WatercourseCell cellWithTableView:self.WatercourseTableView];
   
    [self calculateMonthsMoney:indexPath.row];
    NSString *yearmonth = [self.monthAllkeys[indexPath.row] substringToIndex:7];
    NSString *month = [yearmonth  substringFromIndex:6];
    cell.monthLabel.text = [NSString stringWithFormat:@"%@月",month];
    cell.monthIncomePriceLabel.text = self.monthOutIncome;
    cell.monthIncomeNameLabel.text = @"收:";
    cell.monthInoutNameLabel.text = @"支:";
    cell.monthInoutPriceLabel.text =self.monthIncome;
    cell.monthSurplusNameLabel.text = @"结余";
    cell.monthSurplusPriceLabel.text = self.monthBalance;

    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WatercourseHeaderView *headView = [[WatercourseHeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height * 0.12)];
    headView.yearLabel.text = self.year;
    headView.yearIncomePriceLabel.text = self.outIncome;
    headView.yearInoutPriceLabel.text = self.income;
    headView.yearSurplusNameLabel.text = @"结余";
    headView.yearSurplusPriceLabel.text = self.balance;
    
    return headView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat headerH = screen_height * 0.12;
    return headerH;
}


//组头视图
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"ok";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *key = self.monthAllkeys[indexPath.row];
    NSString *yearmonth = [key substringToIndex:7];
    NSArray *results = (NSArray *)[[RealmManager sharedManager] QueryAndBillDate:yearmonth];
    MonthWatercourseController *vc = [[MonthWatercourseController alloc] init];
    for (Bill *account in results) {
        vc.date = account.date;
    }
    [self.navigationController pushViewController:vc animated:YES];
    
    
} 



@end
