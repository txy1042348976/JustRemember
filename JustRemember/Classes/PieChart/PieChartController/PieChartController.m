//
//  PieChartController.m
//  JustRemember
//
//  Created by risngtan on 16/6/5.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "PieChartController.h"
#import "PieChartView.h"
#import "HooDatePicker.h"
#import "PieChartCell.h"
#import "RealmManager.h"
#import "AZXPieView.h"



@interface PieChartController ()<
AZXPieViewDataSource,
HooDatePickerDelegate,
UITableViewDelegate,
UITableViewDataSource
>
/***  时间选择pickerView*/
@property (nonatomic, strong) HooDatePicker *datePicker;
/***  时间选择视图*/
@property (nonatomic, strong) PieChartView *PieChartView;
@property (nonatomic, strong) AZXPieView *pieView;
@property (nonatomic , strong) UITableView *PieChartTableView;
@property (strong, nonatomic) NSArray *colors; // 一条渐变的颜色带
@property (strong, nonatomic) NSMutableArray *colorArray; // 储存各种颜色(对应不同的type)
@property (strong, nonatomic) NSString *currentDateString; // 当前日期，用来显示与筛选fetch结果
@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) NSNumber *incomeType;
@property (strong, nonatomic) NSArray *dataArray; // fetch来的Accounts
@property (assign, nonatomic) double totalMoney; // 收入/支出总额
@property (strong, nonatomic) NSMutableArray *uniqueTypeArray;
@property (strong, nonatomic) NSArray *uniqueDateArray;
@property (strong, nonatomic) NSArray<NSNumber *> *sortedMoneyArray;
@property (strong, nonatomic) NSMutableArray *sortedPercentArray; // 相应类别所占总金额的比例








@end

@implementation PieChartController

- (NSNumber *)incomeType {
    if (!_incomeType) {
        _incomeType = @YES; // 默认为收入
    }
    return _incomeType;
}
- (NSArray *)colors {
    if (!_colors) {
        _colors =@[[UIColor colorWithRed:252/255.0 green:25/255.0 blue:28/255.0 alpha:1],
                    [UIColor colorWithRed:254/255.0 green:200/255.0 blue:46/255.0 alpha:1],
                    [UIColor colorWithRed:217/255.0 green:253/255.0 blue:53/255.0 alpha:1],
                    [UIColor colorWithRed:42/255.0 green:253/255.0 blue:130/255.0 alpha:1],
                    [UIColor colorWithRed:43/255.0 green:244/255.0 blue:253/255.0 alpha:1],
                    [UIColor colorWithRed:18/255.0 green:92/255.0 blue:249/255.0 alpha:1],
                    [UIColor colorWithRed:219/255.0 green:39/255.0 blue:249/255.0 alpha:1],
                    [UIColor colorWithRed:253/255.0 green:105/255.0 blue:33/255.0 alpha:1],
                    [UIColor colorWithRed:255/255.0 green:245/255.0 blue:54/255.0 alpha:1],
                    [UIColor colorWithRed:140/255.0 green:253/255.0 blue:49/255.0 alpha:1],
                    [UIColor colorWithRed:44/255.0 green:253/255.0 blue:218/255.0 alpha:1],
                    [UIColor colorWithRed:29/255.0 green:166/255.0 blue:250/255.0 alpha:1],
                    [UIColor colorWithRed:142/255.0 green:37/255.0 blue:248/255.0 alpha:1],
                    [UIColor colorWithRed:249/255.0 green:31/255.0 blue:181/255.0 alpha:1]];
        
    }  // 共14种颜色，从红到紫，呈彩虹状渐变
    return _colors;
}

- (UITableView *)PieChartTableView{
    if (!_PieChartTableView) {
        CGFloat y = 64 + screen_height * 0.07 + screen_height - (screen_height * 0.07) - (screen_height * 0.45);
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,y, screen_width, screen_height - y)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = NO;
        _PieChartTableView = tableView;
    }
    return _PieChartTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSArray array];
    self.uniqueDateArray = [NSArray array];
    self.uniqueTypeArray = [NSMutableArray array];
    self.sortedMoneyArray = [NSArray array];
    self.sortedPercentArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self fetchData];
    [self filterData];
    [self pieCHart];
    [self selectDate];
    


    [self.view addSubview:self.PieChartTableView];
    [self.PieChartTableView registerClass:[PieChartCell class] forCellReuseIdentifier:@"PieChartCellID"];


    [self datePickers];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomLeftButton];
    [self setCustomSegmented];
    [self refreshAll];

}
- (void)viewWillDisappear:(BOOL)animated {
    // 离开界面时将图上label全部移除
    [self.pieView removeAllLabel];
}




- (void)refreshAll {
    [self.pieView removeAllLabel];
    
    
    [self fetchData];
    
    [self filterData];
    
    
    [self.PieChartTableView reloadData];
    
    [self.pieView reloadData];
}

#pragma mark - 时间选择picker
- (void)datePickers{
    self.datePicker = [[HooDatePicker alloc] initWithSuperView:self.view];
    self.datePicker.delegate = self;
    self.datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSDate *maxDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[NSDate date]]];
    NSDate *minDate = [dateFormatter dateFromString:@"01-01-1971 00:00:00"];
    
    [self.datePicker setDate:[NSDate date] animated:YES];
    self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = maxDate;
}
#pragma mark - 时间选择
- (void)selectDate{
    self.PieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height * 0.07)];
    [self.view addSubview:self.PieChartView];
    [self.PieChartView.date addTarget:self action:@selector(selectDateBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.PieChartView.leftBtn addTarget:self action:@selector(selectLastMonth) forControlEvents:UIControlEventTouchUpInside];
    [self.PieChartView.rightBtn addTarget:self action:@selector(selectNextMonth) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 选择时间
- (void)selectDateBtn{
    [self.datePicker show];
}

#pragma mark - 上月
- (void)selectLastMonth{
    // 创建一个标准日历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:-1];
    self.currentDate = [calendar dateByAddingComponents:comps toDate:self.currentDate options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *time = [[dateFormatter stringFromDate:self.currentDate] substringToIndex:7];
    [self.PieChartView.date setTitle:time forState:UIControlStateNormal];
    [self refreshAll];
}

- (void)selectNextMonth{
    // 创建一个标准日历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:+1];
    self.currentDate = [calendar dateByAddingComponents:comps toDate:self.currentDate options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *time = [[dateFormatter stringFromDate:self.currentDate] substringToIndex:7];
    [self.PieChartView.date setTitle:time forState:UIControlStateNormal];
    [self refreshAll];
}

#pragma mark - 饼图
- (void)pieCHart{
    self.pieView = [[AZXPieView alloc] initWithFrame:CGRectMake(0, 64 + screen_height * 0.07, screen_width, screen_height - (screen_height * 0.07) - (screen_height * 0.45))];
    [self.view addSubview:self.pieView];
    self.pieView.dataSource = self;
}


#pragma mark - AZXPieView DataSource

- (NSArray *)percentsForPieView:(AZXPieView *)pieView {
    return self.sortedPercentArray;
}

- (NSArray *)colorsForPieView:(AZXPieView *)pieView {
    return self.colorArray;
}

- (NSArray *)typesForPieView:(AZXPieView *)pieView {
    return self.uniqueTypeArray;
}






#pragma mark - 返回按钮
- (void)setCustomLeftButton {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"navigationbar_arrow_back" hltImg:@"navigationbar_arrow_back"  width:10 height:18 target:self action:@selector(goToBack)];
}
- (void)goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISegmentedControl
- (void)setCustomSegmented{
    
    UISegmentedControl *segmentedControl=[[UISegmentedControl alloc] initWithFrame:CGRectMake(80.0f, 5.0f, 110.0f, 30.0f) ];
    segmentedControl.tintColor = [UIColor colorWithRed:0.95 green:0.60 blue:0.17 alpha:1.00];
    [segmentedControl insertSegmentWithTitle:@"收入" atIndex:0 animated:NO];
    [segmentedControl insertSegmentWithTitle:@"支出" atIndex:1 animated:NO];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.momentary = NO;
    segmentedControl.multipleTouchEnabled=NO;
    [segmentedControl addTarget:self action:@selector(Selectbutton:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:segmentedControl];
    
    
}

- (void)Selectbutton : (UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        self.incomeType = @YES;
        [self refreshAll];
    } else {
        self.incomeType = @NO;
        [self refreshAll];
    }
}

#pragma mark - 时间选择
- (void)datePicker:(HooDatePicker *)datePicker didSelectedDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    if (datePicker.datePickerMode == HooDatePickerModeDate) {
        [dateFormatter setDateFormat:@"MM-dd"];
    } else if (datePicker.datePickerMode == HooDatePickerModeTime) {
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    } else if (datePicker.datePickerMode == HooDatePickerModeYearAndMonth){
        [dateFormatter setDateFormat:@"yyyy-MM"];
    } else {
        [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    }
    self.currentDate = date;
    NSString *value = [dateFormatter stringFromDate:date];
    [self.PieChartView.date setTitle:value forState:UIControlStateNormal];
    [self refreshAll];
}


#pragma mark - UITableViewDataSource

//cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.uniqueTypeArray.count;
}
//cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat tableViewH = screen_height*0.11;
    return tableViewH;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PieChartCell *cell = [PieChartCell cellWithTableView:self.PieChartTableView];
    cell.iconImage.backgroundColor = self.colorArray[indexPath.row];
        cell.nameLabel.text = self.uniqueTypeArray[indexPath.row];
    cell.priceLabel.text = [self.sortedMoneyArray[indexPath.row] stringValue];
    NSNumber *percent = self.sortedPercentArray[indexPath.row];
    NSString *percentString = [NSString stringWithFormat:@"%@", percent];
    if ([percentString isEqualToString:@"100"]) {
         NSString *percents = [percentString substringToIndex:3];
        cell.thePercentageLabel.text = [NSString stringWithFormat:@"%@%%",percents];

    }else{
    NSString *percents = [percentString substringToIndex:4];
        cell.thePercentageLabel.text = [NSString stringWithFormat:@"%@%%",percents];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (NSString *)filterLastZeros:(NSString *)string {
    NSString *str = string;
    if ([str containsString:@"."] && [string substringFromIndex:[string rangeOfString:@"."].location].length > 3) {
        // 如果小数点后大于2位，只保留两位
        str = [string substringToIndex:[string rangeOfString:@"."].location+3];
    }
    if ([str containsString:@"."]) {
        if ([[str substringFromIndex:str.length-1] isEqualToString: @"0"]) {
            // 如果最后一位为0，舍弃
            return [str substringToIndex:str.length-1];
        } else if ([[str substringFromIndex:str.length-2] isEqualToString:@"00"]) {
            // 如果后两位为0，舍弃
            return [str substringToIndex:str.length-2];
        } else {
            return str;
        }
    }
    return str;
}


#pragma mark - 获取数据
- (void)fetchData {

    // 设置日期格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    if (self.currentDateString == nil) {
        // 如果还未设置，默认显示当前所处月份
        self.currentDate = [NSDate date];
        self.currentDateString = [[dateFormatter stringFromDate:self.currentDate] substringToIndex:7];
        
       self.dataArray= (NSArray *)[[RealmManager sharedManager] QueryAndBillDate:self.currentDateString WithIncome:self.incomeType];

    } else {

        self.currentDateString = [[dateFormatter stringFromDate:self.currentDate] substringToIndex:7];
        
      self.dataArray=  (NSArray *)[[RealmManager sharedManager] QueryAndBillDate:self.currentDateString WithIncome:self.incomeType];
    }
}

// 得到了totalMoney(总金额)，sortedMoneyArray(某一类别的金额的数组)，uniqueTypeArray(类别数组，与左边的数组排序相同)，uniqueDateArray(日期数组)，sortedPercentArray(每个类别所花金额占总金额的比例)，colorArray（储存各种颜色对应不同的type)
- (void)filterData {
    // 设置各个属性的暂存数组，防止直接数据加入属性多次调用方法导致数据叠加
    NSMutableArray *tmpTypeArray = [NSMutableArray array];
    NSMutableArray *tmpAccountArray = [NSMutableArray array];
    NSDictionary *tmpDict = [NSMutableDictionary dictionary];
    NSMutableArray *tmpMoneyArray = [NSMutableArray array];
    NSMutableArray *tmpDateArray = [NSMutableArray array];
    NSMutableArray *tmpSortedPercentArray = [NSMutableArray array];
    NSMutableArray *tmpColorArray = [NSMutableArray array];
    
    double tmpMoney = 0;
    for (Bill *bill in self.dataArray) {
        [tmpTypeArray addObject:bill.category.name];
        [tmpAccountArray addObject:bill];
        tmpMoney += [bill.money doubleValue];
        [tmpDateArray addObject:[bill.date substringToIndex:7]];
    }
    
    self.totalMoney = tmpMoney;
    
    // 去掉重复元素
    NSSet *typeSet = [NSSet setWithArray:[tmpTypeArray copy]];
    
    //
    tmpTypeArray = [NSMutableArray array];
    
    // 得到降序的无重复元素的日期数组
    NSSet *dateSet = [NSSet setWithArray:[tmpDateArray copy]];
    self.uniqueDateArray = [dateSet sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:nil ascending:NO]]];
    
    for (NSString *type in typeSet) {
        // 从中过滤其中一个类别的所有bill，然后得到一个类别的总金额
        NSArray *array = [tmpAccountArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"category.name == %@", type]];
        
        double totalMoneyInOneType = 0;
        for (Bill *bill in array) {
            totalMoneyInOneType += [bill.money doubleValue];
        }
        
        // 将金额封装成NSNumber来排序
        [tmpMoneyArray addObject:[NSNumber numberWithDouble:totalMoneyInOneType]];
        
        // 将type加入数组
        [tmpTypeArray addObject:type];
        
    }
    
    // 这里使用字典是为了使type和money能关联起来，而且因为money要排序的原因无法使它们在各自数组保持相同的index，所以用字典的方法
    tmpDict = [NSDictionary dictionaryWithObjects:[tmpMoneyArray copy] forKeys:[tmpTypeArray copy]];
    
    // 降序排列
    self.sortedMoneyArray = [tmpMoneyArray sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:nil ascending:NO]]];
    
    NSMutableArray *tmpTypes = [NSMutableArray array];
    NSInteger x = 0;
    
    double tmpTotalPercent = 0;
    
    for (NSInteger i = 0; i < self.sortedMoneyArray.count; i++) {
        // 将相应百分比(小数点后两位)加入数组
        // 此处为了总和为100%，将最后一个设为总额减去数组前除最后一个外所有的元素的百分比
        double money = [self.sortedMoneyArray[i] doubleValue];
        
        double percent = [[NSString stringWithFormat:@"%.2f",money/self.totalMoney*100] doubleValue];
        
        if (i != self.sortedMoneyArray.count - 1) {
            // 如果不是数组最后一个的话，直接加入数组
            [tmpSortedPercentArray addObject:[NSNumber numberWithDouble:percent]];
            // 并累计前面百分比的总和
            tmpTotalPercent += percent;
        } else {
            // 如果是最后一个元素，通过用1减去前面的总和得到
            [tmpSortedPercentArray addObject:[NSNumber numberWithDouble:[[NSString stringWithFormat:@"%.2f", 100-tmpTotalPercent] doubleValue]]];
        }
        
        // 将相应颜色加入数组(超过数组的14时从头开始)
        [tmpColorArray addObject:self.colors[i%14]];
        
        
        // 将相应类型加入数组
        // 因为可能一个金额对应着多个类型，判断是否出现此情况，若出现，则将x++, 取出数组其余类型
        if (i > 0 && (self.sortedMoneyArray[i-1] == self.sortedMoneyArray[i])) {
            x++;
        } else {
            x = 0;
        }
        NSString *type = [tmpDict allKeysForObject:self.sortedMoneyArray[i]][x];
        // 此数组中加入的顺序与moneyArray中一样
        [tmpTypes addObject:type];
    }
    
    self.sortedPercentArray = [tmpSortedPercentArray copy];
    self.colorArray = [tmpColorArray copy];
    self.uniqueTypeArray = [tmpTypes copy];
    
}


@end
