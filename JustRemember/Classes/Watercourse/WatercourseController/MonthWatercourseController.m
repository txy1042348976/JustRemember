//
//  MonthWatercourseController.m
//  JustRemember
//
//  Created by risngtan on 16/6/1.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "MonthWatercourseController.h"
#import "MonthWatercourseCell.h"
#import "MonthWatercourseHeaderView.h"
#import "DetailController.h"

@interface MonthWatercourseController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *MonthWatercourseTableView;

@property (nonatomic, strong) NSArray *allkeys;
@property (nonatomic, strong) NSDictionary *dataDic;
@end

@implementation MonthWatercourseController

#pragma mark - 懒加载
- (UITableView *)MonthWatercourseTableView{
    if (!_MonthWatercourseTableView) {
        UITableView *MonthWatercourseTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
        MonthWatercourseTableView.delegate = self;
        MonthWatercourseTableView.dataSource = self;
        _MonthWatercourseTableView = MonthWatercourseTableView;
    }
    return _MonthWatercourseTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allkeys = [NSArray array];
    [self.view addSubview:self.MonthWatercourseTableView];
    [self.MonthWatercourseTableView registerClass:[MonthWatercourseCell class] forCellReuseIdentifier:@"WMonthWatercourseCellID"];

    
    NSString *yearmonth = [self.date substringToIndex:7];
    NSString *month = [yearmonth  substringFromIndex:6];
    NSString *year = [yearmonth substringToIndex:4];
    self.navigationItem.title = [NSString stringWithFormat:@"%@年%@月",year,month];
    [self setCustomLeftButton];
    [self navline];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self searchBill];
    self.allkeys = [self sortArray:self.dataDic.allKeys ascending:NO];
    [self.MonthWatercourseTableView reloadData];
}

- (void)navline{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screen_width, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.886 alpha:1.000];
    [view addSubview:lineView];
}

- (void)searchBill{
    NSString *yearmonth = [self.date substringToIndex:7];
    RLMResults *results = [[RealmManager sharedManager] QueryAndBillDate:yearmonth];
    NSDictionary *dc = [[RealmManager sharedManager] queryTimeData:results];
    self.dataDic = dc;
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

#pragma mark - 返回按钮
- (void)setCustomLeftButton {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"navigationbar_arrow_back" hltImg:@"navigationbar_arrow_back"  width:10 height:18 target:self action:@selector(goToBack)];
}

- (void)goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allkeys.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MonthWatercourseCell *cell = [MonthWatercourseCell cellWithTableView:self.MonthWatercourseTableView];
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
    MonthWatercourseHeaderView *headView = [[MonthWatercourseHeaderView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height * 0.05)];
    headView.monthLabel.text = self.allkeys[section];

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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *key = self.allkeys[indexPath.section];
        RLMResults *results = self.dataDic[key];
        Bill *bill = results[indexPath.row];
        [[RealmManager sharedManager] deleteBill:bill];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [self.h]
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}





@end
