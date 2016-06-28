//
//  addBillController.m
//  JustRemember
//
//  Created by rising on 16/5/25.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "addBillController.h"
#import "HomeController.h"
#import "AddBillInputCompleteView.h"
#import "AddBillCell.h"
#import "DateAndNoteView.h"
#import "InputTextView1.h"
#import "SZCalendarPicker.h"
#import "CalculatorView.h"
#import "CategroyImage.h"
#import "Bill.h"
#import "Category.h"
#import "RealmManager.h"
#import "MMAlertView.h"
#import "DetailController.h"


@interface addBillController ()<
UICollectionViewDataSource,
UICollectionViewDelegate,
InputTextView1Delgate
>


/***  结果视图*/
@property (nonatomic , strong) AddBillInputCompleteView *addBillInputCompleteView;
/***  选择日期和备注视图*/
@property (nonatomic , strong) DateAndNoteView *dateAndNoteView;
/***  计算器*/
@property (nonatomic, strong) CalculatorView *calculatorView;

/***  CollectionView*/
@property(nonatomic , strong) UICollectionView *AddBillCollectionView;

@property (nonatomic, strong) NSMutableArray<CategroyImage *> *images;///<类别数组

@property (nonatomic, strong) Category *category;

@property (nonatomic, assign) NSNumber *incomeType;

@property (nonatomic, strong) NSNumber *dateSelect;
@property (nonatomic, strong) NSNumber *notSelect;
@property (nonatomic, strong) NSNumber *categorySelect;

@property (nonatomic, copy) NSString *typeImageName;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, strong) UISegmentedControl *segmented;

@property (nonatomic, strong) NSMutableArray *categoryNameArray;







@end
//设置标识
static NSString *indentify = @"AddBillCellID";
@implementation addBillController

-(NSMutableArray<CategroyImage *> *)images{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomSegmented];
    [self setAddBillInputCompleteView];
    [self addTheCollectionView];
    [self setDateAndNoteView];
    [self setAddBillCalculatorView];
    [self btn];
    [self navline];
    
    
    self.categoryNameArray = [NSMutableArray array];
    self.dateSelect = @NO;
    self.notSelect = @NO;
    self.categorySelect = @NO;


}

- (void)navline{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, screen_width, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.886 alpha:1.000];
    [view addSubview:lineView];
}

#pragma mark - 判断是类别数据库是否有数据
- (void)dataBaseIf{

    Category *CA = [[Category alloc] init];
    NSNumber *income = CA.income = @YES;
    [self selectedSegmentImage:income];
    self.incomeType = @YES;
    
}



- (void)viewWillAppear:(BOOL)animated{
[super viewWillAppear:animated];

    [self dataBaseIf];
    RealmManager *databse = [RealmManager sharedManager];
    Category *CA = [[Category alloc] init];
    if (self.bill == nil) {
        self.isNav = @0;
        if ([self.bill.isIncome isEqual:@YES]) {
            [databse QueryAndCategoryIndex:0 Withincome:@YES];
            CA  = [databse QueryAndCategoryIndex:0 Withincome:@YES];
            [self selectedSegmentImage:self.bill.isIncome];
              self.segmented.selectedSegmentIndex = 0;
        }else if([self.bill.isIncome isEqual:@NO]){
            [databse QueryAndCategoryIndex:0 Withincome:@NO];
            CA  = [databse QueryAndCategoryIndex:0 Withincome:@NO];
            [self selectedSegmentImage:self.bill.isIncome];
              self.segmented.selectedSegmentIndex = 1;
        }

    }
    else if (self.bill != nil) {
        self.isNav = @1;
        self.addBillInputCompleteView.categoryImage.image = [UIImage imageNamed:self.bill.category.icon];
        self.addBillInputCompleteView.categoryName.text = self.bill.category.name;
        self.addBillInputCompleteView.price.text = self.bill.money;
        [self.dateAndNoteView.dateBtn setTitle:self.bill.date forState:UIControlStateNormal];
        self.date = self.bill.date;
        [self.dateAndNoteView.noteBtn setTitle:self.bill.remarks forState:UIControlStateNormal];
        self.remarks = self.bill.remarks;
        self.category = self.bill.category;
        if ([self.bill.isIncome isEqual:@YES]) {
            [databse QueryAndCategoryIndex:0 Withincome:@YES];
            CA  = [databse QueryAndCategoryIndex:0 Withincome:@YES];
            [self selectedSegmentImage:self.bill.isIncome];
              self.segmented.selectedSegmentIndex = 0;
        }else if([self.bill.isIncome isEqual:@NO]){
            [databse QueryAndCategoryIndex:0 Withincome:@NO];
            CA  = [databse QueryAndCategoryIndex:0 Withincome:@NO];
            [self selectedSegmentImage:self.bill.isIncome];
              self.segmented.selectedSegmentIndex = 1;
        }
        
    }
    
    
    
}




- (void)btn{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@" " hltImg:@" "  width:10 height:18 target:self action:@selector(doBack:)];
   self.navigationItem.rightBarButtonItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"icon_add_expense_cancel" hltImg:@"icon_add_expense_cancel"  width:18 height:18 target:self action:@selector(doBack:)];
    
}

-(void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 收支选择
#pragma mark - UISegmentedControl
- (void)setCustomSegmented{
    self.segmented =[[UISegmentedControl alloc] initWithFrame:CGRectMake(80.0f, 5.0f, 110.0f, 30.0f) ];
    self.segmented.tintColor = [UIColor colorWithRed:0.95 green:0.60 blue:0.17 alpha:1.00];
    [self.segmented insertSegmentWithTitle:@"收入" atIndex:0 animated:NO];
    [self.segmented insertSegmentWithTitle:@"支出" atIndex:1 animated:NO];
    self.segmented.selectedSegmentIndex = 0;
    self.segmented.momentary = NO;
    self.segmented.multipleTouchEnabled=NO;
    [self.segmented addTarget:self action:@selector(selectSegment:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:self.segmented];
    
}

//选择按钮
- (void)selectSegment:(UISegmentedControl *)sender{
    RealmManager *databse = [RealmManager sharedManager];
    Category *CA = [[Category alloc] init];
    [self.images removeAllObjects];
if (sender.selectedSegmentIndex == 0) {
    NSNumber *income = CA.income = @YES;
    [databse QueryAndCategoryIndex:0 Withincome:@YES];
    CA  = [databse QueryAndCategoryIndex:0 Withincome:@YES];
    self.addBillInputCompleteView.categoryImage.image = [UIImage imageNamed:CA.icon];
    self.addBillInputCompleteView.categoryName.text = CA.name;

    [self selectedSegmentImage:income];
    self.incomeType = @YES;
}else if(sender.selectedSegmentIndex == 1){
    NSNumber *income = CA.income = @NO;
    [databse QueryAndCategoryIndex:0 Withincome:@NO];
    CA  = [databse QueryAndCategoryIndex:0 Withincome:@NO];
    self.addBillInputCompleteView.categoryImage.image = [UIImage imageNamed:CA.icon];
    self.addBillInputCompleteView.categoryName.text = CA.name;

    [self selectedSegmentImage:income];
    self.incomeType = @NO;
}
    self.category = CA;
    [self.AddBillCollectionView reloadData];


}
- (void)selectedSegmentImage:(NSNumber *)income{
      [self.images removeAllObjects];
    NSArray *imageDics =  (NSArray *)[[RealmManager sharedManager] QueryAndCategory:income];
    for (NSDictionary *imageDic in imageDics) {
    CategroyImage *image = [CategroyImage imageWithImageDic:imageDic];
    [self.images addObject:image];
    [self.AddBillCollectionView reloadData];
}
}
//关闭按钮时间
- (void)closes{

if ([self.isNav isEqual: @0]) {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}else if([self.isNav isEqual: @1]){
    [self.navigationController popViewControllerAnimated:YES];
}
}


#pragma mark - 设置输入结果视图
- (void)setAddBillInputCompleteView{
self.addBillInputCompleteView = [[AddBillInputCompleteView alloc] initWithFrame:CGRectMake(0, screen_height * 0.11, screen_width, screen_height * 0.10)];
[self.view addSubview:self.addBillInputCompleteView];
    if ([[RealmManager sharedManager] numberOfCategoyrCout]!=0) {
    RealmManager *databse = [RealmManager sharedManager];
    Category *CA = [[Category alloc] init];
    if (self.segmented.selectedSegmentIndex == 0) {
        [databse QueryAndCategoryIndex:0 Withincome:@YES];
        CA  = [databse QueryAndCategoryIndex:0 Withincome:@YES];
    }else if (self.segmented.selectedSegmentIndex == 1){
        [databse QueryAndCategoryIndex:0 Withincome:@NO];
        CA  = [databse QueryAndCategoryIndex:0 Withincome:@NO];
    }
    self.addBillInputCompleteView.categoryImage.image = [UIImage imageNamed:CA.icon];
   self.addBillInputCompleteView.categoryName.text = CA.name;
self.category = CA;
    }

}

#pragma mark - 设置日期和备注视图
- (void)setDateAndNoteView{
CGFloat dateAndNoteViewY = screen_height * 0.11 + screen_height * 0.10 + screen_height * 0.30;
self.dateAndNoteView = [[DateAndNoteView alloc] initWithFrame:CGRectMake(0, dateAndNoteViewY, screen_width, screen_height * 0.10)];
[self.view addSubview:self.dateAndNoteView];
[self.dateAndNoteView.dateBtn addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventTouchUpInside];
[self.dateAndNoteView.noteBtn addTarget:self action:@selector(selectNote) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 日期选择事件
- (void)selectDate{
    self.dateSelect = @YES;
    __weak typeof(self) weakSelf = self;
    SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
    calendarPicker.layer.cornerRadius = 10;
    calendarPicker.layer.masksToBounds = YES;
    calendarPicker.today = [NSDate date];
    calendarPicker.date = calendarPicker.today;
    calendarPicker.frame = CGRectMake(25, 100, self.view.frame.size.width-50, 352);
    calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
        [weakSelf.dateAndNoteView.dateBtn setTitle:[NSString stringWithFormat:@"%ld-%ld",month,(long)day] forState:UIControlStateNormal];

    if (month<10) {
        self.date = [NSString stringWithFormat:@"%ld-0%ld-%ld",year,month,(long)day];
    }else{
        self.date = [NSString stringWithFormat:@"%ld-%ld-%ld",year,month,(long)day];
    }
    
};

}

#pragma mark - 添加备注事件
- (void)selectNote{
    self.notSelect = @YES;
    InputTextView1 * input=[InputTextView1 creatInputTextView1];
    input.delegate=self;
    [self.dateAndNoteView.noteBtn becomeFirstResponder];
    [input show];
}
//点击确定按钮后赋值给写备注按钮
-(void)finishedInput1:(InputTextView1 *)InputTextView1
{
    [self.dateAndNoteView.noteBtn setTitle:InputTextView1.textView.text forState:UIControlStateNormal];
    self.remarks = InputTextView1.textView.text;
}
//退出按钮时间
-(void)cancleInput1{
}
//退出键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}




#pragma mark - 计算器
- (void)setAddBillCalculatorView{
    CGFloat AddBillCalculatorViewY = screen_height * 0.11 + screen_height * 0.10 + screen_height * 0.30 + screen_height * 0.10;
    CGFloat AddBillCalculatorViewH = screen_height - (screen_height * 0.11 + screen_height * 0.10 + screen_height * 0.30 + screen_height * 0.10);

    self.calculatorView = [[CalculatorView alloc] initWithFrame:CGRectMake(0, AddBillCalculatorViewY, screen_width, AddBillCalculatorViewH)];
    [self.view addSubview:self.calculatorView];
    [self.calculatorView.point addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.touch0 addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.touch1 addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.touch2 addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.touch3 addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.touch4 addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.touch5 addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.touch6 addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.touch7 addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.touch8 addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.touch9 addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.clear addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.jian addTarget:self action:@selector(calculation:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.jia addTarget:self action:@selector(calculation:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView.equal addTarget:self action:@selector(equals) forControlEvents:UIControlEventTouchUpInside];

    [self.calculatorView.okBtn addTarget:self action:@selector(selectOK) forControlEvents:UIControlEventTouchUpInside];

}
- (void)clear {
    self.addBillInputCompleteView.price.text = @"0";
    self.firstNumber = 0;
    self.secondNumber = 0;
    self.symbol = @"";
    self.numStarted = NO;
    self.numPressed = NO;
}




- (void)number:(UIButton *)sender {

if(self.numStarted){
    if([[self.addBillInputCompleteView.price.text substringToIndex:1] isEqualToString:@"0"] && [self.addBillInputCompleteView.price.text containsString:@"."] == NO){
        self.addBillInputCompleteView.price.text = @"";
        self.addBillInputCompleteView.price.text = sender.currentTitle;
    }
    else{
        self.addBillInputCompleteView.price.text = [self.addBillInputCompleteView.price.text stringByAppendingString:sender.currentTitle];
    }
}
else{
    if([sender.currentTitle isEqualToString:@"0"]){
        self.addBillInputCompleteView.price.text = @"0";
    }
    else{
        self.addBillInputCompleteView.price.text = sender.currentTitle;
    }
    self.numStarted = YES;
}

self.numPressed = YES;
}


- (void)calculation:(UIButton *)sender {
self.numStarted = NO;
self.firstNumber = [self.addBillInputCompleteView.price.text doubleValue];
self.symbol = [sender currentTitle];
}

- (void)equals {
self.numStarted = NO;
double result = 0;

if(self.numPressed){
    self.secondNumber = [self.addBillInputCompleteView.price.text doubleValue];
    self.numPressed = NO;
}
else{
    self.firstNumber = [self.addBillInputCompleteView.price.text doubleValue];
}

if([self.symbol isEqualToString:@"+"]){
    result = self.firstNumber + self.secondNumber;
}
else if([self.symbol isEqualToString:@"-"]){
    result = self.firstNumber - self.secondNumber;
}

if(isnan(result)){
    self.addBillInputCompleteView.price.text = @"Error";
}
else{
    self.addBillInputCompleteView.price.text = [NSString stringWithFormat:@"%g", result];
}
}

//保存数据
- (void)selectOK{
    RealmManager *databse = [RealmManager sharedManager];
    Bill *bill = [[Bill alloc] init];

    if (self.bill == nil) {
        if (self.date == nil || [self.addBillInputCompleteView.price.text  isEqual: @"0.00"] || self.category == nil) {
            [self alter];
        }else{
            bill.money = self.addBillInputCompleteView.price.text;
            bill.isIncome = self.incomeType;
            bill.remarks = self.remarks;
            bill.category  = self.category;
            bill.date = self.date;
            [databse insertWithBill:bill];
            [self.navigationController popViewControllerAnimated:YES];
        }


    }else if(self.bill != nil){

        [self modifyBill];
        [self.navigationController popViewControllerAnimated:YES];
    }

    

}



- (void)alter{
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
        NSLog(@"animation complete");
    };
    MMAlertView *alertView = [[MMAlertView alloc] initWithConfirmTitle:@"警告⚠️" detail:@"金额,类别或时间没有输入哦😰"];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
    [alertView showWithBlock:completeBlock];

}

-(void)modifyBill{
    [self.bill modifyMoney: self.addBillInputCompleteView.price.text];
    [self.bill modifyDate:self.date];
    [self.bill modifyRemarks:self.remarks];
    [self.bill modifyIsIncome:self.incomeType];
    [self.bill modifyCategory:self.category];

}

#pragma mark - 创建CollectionView
-(void)addTheCollectionView{

//=======================1===========================
//创建一个块状表格布局对象
UICollectionViewFlowLayout *flowL = [UICollectionViewFlowLayout new];
//格子的大小 (长，高)
CGFloat itemW = screen_width / 5;
CGFloat itemH = self.view.frame.size.height * 0.30 / 2;

flowL.itemSize = CGSizeMake(itemW, itemH);
//横向最小距离
flowL.minimumInteritemSpacing = 0;
//    flowL.minimumLineSpacing=60.f;//代表的是纵向的空间间隔
//设置，上／左／下／右 边距 空间间隔数是多少
flowL.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//如果有多个 区 就可以拉动h
[flowL setScrollDirection:UICollectionViewScrollDirectionVertical];
//可以左右拉动
//        [flowL setScrollDirection:UICollectionViewScrollDirectionHorizontal];


CGFloat y = screen_height * 0.11 + screen_height * 0.10;
//创建一个UICollectionView
self.AddBillCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height * 0.30) collectionViewLayout:flowL];
//设置代理为当前控制器
self.AddBillCollectionView.delegate = self;
self.AddBillCollectionView.dataSource = self;
//设置背景
self.AddBillCollectionView.backgroundColor =[UIColor whiteColor];

// 注册单元格
[self.AddBillCollectionView registerClass:[AddBillCell class] forCellWithReuseIdentifier:indentify];

//添加视图
[self.view addSubview:self.AddBillCollectionView];

}


#pragma mark - UICollectionView dataSource


//每个section有多少个元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
return self.images.count;
}
//每个单元格的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//初始化每个单元格
AddBillCell *cell = (AddBillCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];

        cell.categoryImage.image = [UIImage imageNamed:self.images[indexPath.item].icon];
        cell.categroyName.text = self.images[indexPath.item].name;
        self.typeImageName = self.images[indexPath.item].icon;
        self.type = self.images[indexPath.item].name;
        [self.categoryNameArray addObject:self.type];
return cell;


}

//选择collection
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.categorySelect = @YES;
        self.addBillInputCompleteView.categoryImage.image = [UIImage imageNamed:self.images[indexPath.item].icon];
            self.addBillInputCompleteView.categoryName.text = self.images[indexPath.item].name;
            
            RealmManager *databse = [RealmManager sharedManager];
            Category *CA = [[Category alloc] init];
            if (self.segmented.selectedSegmentIndex == 0) {
                [databse QueryAndCategoryIndex:indexPath.item Withincome:@YES];
                CA  = [databse QueryAndCategoryIndex:indexPath.item Withincome:@YES];
            }else if (self.segmented.selectedSegmentIndex == 1){
                [databse QueryAndCategoryIndex:indexPath.item Withincome:@NO];
                CA  = [databse QueryAndCategoryIndex:indexPath.item Withincome:@NO];
            }
            self.category = CA;
}




@end
