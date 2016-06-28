//
//  CategoryManagementController.m
//  JustRemember
//
//  Created by risngtan on 16/6/21.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "CategoryManagementController.h"
#import "CategoryManagementCell.h"
#import "RealmManager.h"
#import "CategroyImage.h"
#import "CategoryManagemtetBottomView.h"
#import "MMAlertView.h"
#import "AddCategoryController.h"



@interface CategoryManagementController ()<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic, strong) NSNumber *incomeType;

/***  CollectionView*/
@property(nonatomic , strong) UICollectionView *CategoryManagementCollectionView;
@property (nonatomic, strong) NSMutableArray<CategroyImage *> *images;///<类别数组
@property (nonatomic, strong) Category *category;
/***  添加按钮*/
@property (nonatomic, strong) CategoryManagemtetBottomView *bottomView;



@end
static NSString *indentify = @"CategoryManagementCellID";
@implementation CategoryManagementController
#pragma mark - 懒加载

- (NSNumber *)incomeType {
    if (!_incomeType) {
        _incomeType = @YES; // 默认为收入
    }
    return _incomeType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomSegmented];
    [self addTheCollectionView];
    [self addCategoryBtn];
    [self setCustomLeftButton];
    [self setCustomSegmented];
    [self navline];
    self.view.backgroundColor = [UIColor whiteColor];



}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.images removeAllObjects];
    [self selectedSegmentImage:self.incomeType];
    [self.CategoryManagementCollectionView reloadData];


}

- (void)navline{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, screen_width, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.886 alpha:1.000];
    [view addSubview:lineView];
}


#pragma mark - 添加类别按钮
- (void)addCategoryBtn{
    self.bottomView = [[CategoryManagemtetBottomView alloc] initWithFrame:CGRectMake(screen_width / 1.4,self.view.frame.size.height * 0.85, screen_width / 8, screen_width / 8)];
    [self.view addSubview:self.bottomView];
    [self.bottomView.addBtn addTarget:self action:@selector(selectAddBtn) forControlEvents:UIControlEventTouchUpInside];
}


- (void)selectAddBtn{
    AddCategoryController *vc = [[AddCategoryController alloc] init];
    vc.income = self.incomeType;
    [self.navigationController pushViewController:vc animated:YES];
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
    [segmentedControl insertSegmentWithTitle:@"收入" atIndex:0 animated:YES];
    [segmentedControl insertSegmentWithTitle:@"支出" atIndex:1 animated:YES];
    segmentedControl.selectedSegmentIndex = 0;
    [self selectedSegmentImage:@YES];
    segmentedControl.momentary = NO;
    segmentedControl.multipleTouchEnabled=NO;
    [segmentedControl addTarget:self action:@selector(Selectbutton:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:segmentedControl];
    [self.CategoryManagementCollectionView reloadData];
}

- (void)Selectbutton : (UISegmentedControl *)sender{
    Category *CA = [[Category alloc] init];
    if (sender.selectedSegmentIndex == 0) {
        NSNumber *income = CA.income = @YES;
        [self selectedSegmentImage:income];
        self.incomeType = @YES;
    }else if(sender.selectedSegmentIndex == 1){
        NSNumber *income = CA.income = @NO;
        [self selectedSegmentImage:income];
        self.incomeType = @NO;
    }
    self.category = CA;
}


- (void)selectedSegmentImage:(NSNumber *)income{
    self.images = [[NSMutableArray alloc] init];
    NSArray *imageDics =  (NSArray *)[[RealmManager sharedManager] QueryAndCategory:income];
    for (NSDictionary *imageDic in imageDics) {
        CategroyImage *image = [CategroyImage imageWithImageDic:imageDic];
        [self.images addObject:image];
        [self.CategoryManagementCollectionView reloadData];
    }
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
    
    
    //创建一个UICollectionView

    __weak typeof(self) weakSelf = self;

    self.CategoryManagementCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowL];
    //设置代理为当前控制器
    self.CategoryManagementCollectionView.delegate = self;
    self.CategoryManagementCollectionView.dataSource = self;
    //设置背景
    self.CategoryManagementCollectionView.backgroundColor =[UIColor whiteColor];
    
    // 注册单元格
    [self.CategoryManagementCollectionView registerClass:[CategoryManagementCell class] forCellWithReuseIdentifier:indentify];
//    self.edgesForExtendedLayout=UIRectEdgeNone;
    //添加视图
    [self.view addSubview:self.CategoryManagementCollectionView];
    [self.CategoryManagementCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(screen_width);
        make.height.mas_equalTo(weakSelf.view.frame.size.height * 0.8);
        make.left.mas_equalTo(weakSelf.view).offset(0);
    }];
    
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
    CategoryManagementCell *cell = (CategoryManagementCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    cell.categoryImage.image = [UIImage imageNamed:self.images[indexPath.item].icon];
    cell.categroyName.text = self.images[indexPath.item].name;

    return cell;
    
    
}

//选择collection
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Category *category = [[Category alloc] init];
    category = [[RealmManager sharedManager] QueryAndCategoryIndex:indexPath.item Withincome:self.incomeType];
    
    
    __weak typeof(self) weakSelf = self;

    MMPopupItemHandler block = ^(NSInteger index){
        if (index == 1) {
            
          [[RealmManager sharedManager] deleteCategory:category];
//            [[RealmManager sharedManager] deleteCategoryAndBill:category];
            [weakSelf.images removeObjectAtIndex:indexPath.item];
            [weakSelf.CategoryManagementCollectionView reloadData];
        }
    };
    
    NSArray *items =
    @[MMItemMake(@"不删了", MMItemTypeNormal, block),
      MMItemMake(@"删吧", MMItemTypeNormal, block)];
    
    MMAlertView *alertView = [[MMAlertView alloc] initWithTitle:@"亲这可是类别啊"
                                                         detail:@"删除这个类别你将会失去你以前记的这个类别的账目哦👿"
                                                          items:items];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleLight;
    
    [alertView show];
}


@end
