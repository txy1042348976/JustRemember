//
//  DetailController.m
//  JustRemember
//
//  Created by risngtan on 16/6/1.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "DetailController.h"
#import "addBillController.h"
#import "ModifyAndDeleteBtnView.h"
#import "noteCell.h"
#import "ListCell.h"
#import "HomeController.h"
#import "MMAlertView.h"
#import "WatercourseController.h"

@interface DetailController ()<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UIButton *modifyBtn;
@property (nonatomic, strong) UIButton *DeletBtn;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *noteData;

@end

@implementation DetailController
#pragma mark - 懒加载
-(UITableView *)table{
    if (!_table) {
        CGFloat h = screen_height * 0.3;
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height - h)];
        table.dataSource = self;
        table.delegate = self;
        table.userInteractionEnabled = NO;
        _table = table;
    }
    return _table;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00];


    
    [self.view addSubview:self.table];
    [self.table registerClass:[noteCell class] forCellReuseIdentifier:@"noteCellID"];
    [self setModifyBtn];
    [self setDeletBtn];
    [self setCustomLeftButton];
    [self navline];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.table reloadData];
}


- (void)navline{
    UIColor * color = [UIColor colorWithWhite:0.518 alpha:1.000];
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    //大功告成
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, screen_width, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.886 alpha:1.000];
    [view addSubview:lineView];
}
#pragma mark - 修改按钮
- (void)setModifyBtn{
    CGFloat x = screen_width * 0.12;
    CGFloat y = screen_height - (screen_height * 0.3) + (screen_height * 0.06);
    CGFloat h = screen_height * 0.08;
    CGFloat w = screen_width * 0.8;
    ModifyAndDeleteBtnView *view = [[ModifyAndDeleteBtnView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [self.view addSubview:view];
    self.modifyBtn = view.modifyAndDeleteBtn;
    [self.modifyBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.modifyBtn addTarget:self action:@selector(modifyBtnSelect) forControlEvents:UIControlEventTouchUpInside];
}
- (void)modifyBtnSelect{
    addBillController *vc = [[addBillController alloc] init];
    vc.bill = self.bill;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - 删除按钮
- (void)setDeletBtn{
    CGFloat x = screen_width * 0.12;
    CGFloat y = screen_height - (screen_height * 0.3) + (screen_height * 0.06) + (screen_height * 0.03) + (screen_height * 0.08);
    CGFloat h = screen_height * 0.08;
    CGFloat w = screen_width * 0.8;
    ModifyAndDeleteBtnView *view = [[ModifyAndDeleteBtnView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [self.view addSubview:view];
    self.DeletBtn = view.modifyAndDeleteBtn;
    [self.DeletBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.DeletBtn addTarget:self action:@selector(deleteBtnSelect) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)deleteBtnSelect{


        MMPopupItemHandler block = ^(NSInteger index){
            if (index == 1) {
                [[RealmManager sharedManager] deleteBill:self.bill];
            
                HomeController *viewCtl = self.navigationController.viewControllers[0];
                
                [self.navigationController popToViewController:viewCtl animated:YES];
            }
            
        };
        
        NSArray *items =
        @[MMItemMake(@"不删了", MMItemTypeNormal, block),
          MMItemMake(@"删吧", MMItemTypeNormal, block)];
        
        MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"你确定要删除吗？"
                                                             detail:@"辛辛苦苦记得账就找不回来了😭"
                                                              items:items];
        alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
        alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
        
        [alertView show];
}



#pragma mark - 返回按钮
- (void)setCustomLeftButton {
    //选择自己喜欢的颜色
    UIColor * color = [UIColor whiteColor];
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    //大功告成
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"navigationbar_arrow_back" hltImg:@"navigationbar_arrow_back"  width:10 height:18 target:self action:@selector(goToBack)];
    self.navigationItem.title = @"明细";

}

- (void)goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger cellNumber;
    if (section == 0) {
        cellNumber = 3;
    }else if (section == 1){
        cellNumber = 1;
    }
    return cellNumber;
}


//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cells;

    if (indexPath.section == 0) {
        ListCell *cell = [ListCell cellWithTableView:self.table];
        if (indexPath.row == 0) {
            cell.priceOrcategoryOrdateNameLabel.text = @"记账金额";
            cell.priceOrcategoryOrdateLabel.text = self.bill.money;
        }else if (indexPath.row == 1){
            cell.priceOrcategoryOrdateNameLabel.text = @"分类";
            if ([self.bill.isIncome  isEqual: @YES]) {
                cell.priceOrcategoryOrdateLabel.text = [NSString stringWithFormat:@"收入>%@",self.bill.category.name];
            }
            else if([self.bill.isIncome  isEqual: @NO]){
                cell.priceOrcategoryOrdateLabel.text = [NSString stringWithFormat:@"支出>%@",self.bill.category.name];
            }
        }else if (indexPath.row == 2){
            UIView *footer =[[UIView alloc] initWithFrame:CGRectZero];
            self.table.tableFooterView = footer;
            cell.priceOrcategoryOrdateNameLabel.text = @"记录时间";
            cell.priceOrcategoryOrdateLabel.text = self.bill.date;
        }
        
        cells = cell;
    }else if (indexPath.section == 1){
        
    noteCell *cell = [noteCell cellWithTableView:self.table];
    cell.noteNameLabel.text = @"备注";
    cell.noteLabel.numberOfLines = 4;
        cell.noteLabel.text = self.bill.remarks;

           cells = cell;
    }
    return cells;
 
}
//cell行高

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger h;
    CGFloat listTableH = screen_height * 0.09;
    if (indexPath.section == 0) {
        h = listTableH;
    }else if (indexPath.section == 1){
    CGRect rect =[self rectWidthAndHeightWithStr:self.bill.remarks AndFont:12 WithStrWidth:300];
        h = 70*Height+rect.size.height;
    }
    return h;

}
- (CGRect)rectWidthAndHeightWithStr:(NSString *)str AndFont:(CGFloat)fontFloat WithStrWidth:(CGFloat)widh
{
    //计算文本尺寸
    CGRect fcRect = [str boundingRectWithSize:CGSizeMake(widh*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontFloat*Width]} context:nil];
    return fcRect;
}


//组头视图
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    return @"   ";
}



@end
