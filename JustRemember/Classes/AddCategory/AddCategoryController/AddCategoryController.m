//
//  AddCategoryController.m
//  JustRemember
//
//  Created by risngtan on 16/6/15.
//  Copyright © 2016年 rising. All rights reserved.
//

#import "AddCategoryController.h"
#import "AddCategoryCell.h"
#import "AddCategoryTopView.h"
#import "CategroyImages.h"
#import "RealmManager.h"
#import "Category.h"
#import "MMAlertView.h"


static NSString *indentify = @"AddCategoryCellID";
@interface AddCategoryController ()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UITextFieldDelegate
>

/***  CollectionView*/
@property(nonatomic , strong) UICollectionView *AddCategoryCollectionView;
@property (nonatomic, strong) AddCategoryTopView *addCategoryTopView;
@property (nonatomic, strong) NSMutableArray<CategroyImages *> *images;///<类别数组
@property (nonatomic, assign) NSNumber *isNav;
@property (nonatomic, strong) NSString *categoryImageName;
@property (nonatomic, strong) NSMutableArray *CategoryNameArray;
@property (nonatomic, strong) UIScrollView *scrollView;

@end



@implementation AddCategoryController

#pragma mark - 懒加载
- (NSMutableArray *)images {
    //从plist文件中取出字典数组，并封装成对象模型，存入模型数组中
    if (!_images) {
        _images = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"类别.plist" ofType:nil];
        
        NSArray *imageDics = [NSArray arrayWithContentsOfFile:path];
        
        for (NSDictionary *imageDic in imageDics) {
            CategroyImages *image = [CategroyImages imageWithImageDic:imageDic];
            [_images addObject:image];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.CategoryNameArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTheCollectionView];
    [self setAddBillTopView];
    [self setNav];
    [self navline];
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;


}
- (void)navline{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, screen_width, 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.886 alpha:1.000];
    [view addSubview:lineView];
}

#pragma mark - Navgation
- (void)setNav{
    UIColor * color = [UIColor colorWithWhite:0.518 alpha:1.000];
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    //大功告成
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationItem.title = @"新增类别";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem rx_barBtnItemWithNmlImg:@"navigationbar_arrow_back" hltImg:@"navigationbar_arrow_back"  width:10 height:18 target:self action:@selector(goToBack)];
    UIFont *font =  [UIFont fontWithName:@"Arial-BoldItalicMT" size:20];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem rx_barBtnItemWithTitle:@"完成" titleColor:[UIColor colorWithWhite:0.565 alpha:1.000] titleFont:font target:self action:@selector(defaultNaviBarRightBtnPressed)];
}
- (void)goToBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - overload method
- (void)defaultNaviBarRightBtnPressed
{
    Category *ca = [[Category alloc] init];
    ca.CategoryID =[[RealmManager sharedManager] retUUIDString];
    ca.income = self.income;
    
    NSArray *Categorys = (NSArray *)[[RealmManager sharedManager] getArrayOfCategory];
    for (Category *ct  in Categorys) {
        [self.CategoryNameArray addObject:ct.name];
    }
    

    for (int i = 0; i<self.CategoryNameArray.count; i++) {
        if ([self.addCategoryTopView.categoryName.text isEqualToString:self.CategoryNameArray[i]]) {
            [self alert:@"类别重复" Message:@"请重新输入类别名"];
            return;
        }
        else{
            ca.name = self.addCategoryTopView.categoryName.text;
        }
        
    }
    if ( self.addCategoryTopView.categoryName.text.length == 0) {
        [self alert:@"为空" Message:@"请重新输入类别名"];
    }else{
    ca.icon = self.categoryImageName;
    [[RealmManager sharedManager] insertWithCategory:ca];
    [self.navigationController popViewControllerAnimated:YES];
    }
    





}

- (void)setAddBillTopView{
    CGFloat h = screen_height * 0.11;
    self.addCategoryTopView = [[AddCategoryTopView alloc] initWithFrame:CGRectMake(0, 64, screen_width, h)];
    [self.view addSubview:self.addCategoryTopView];
    self.addCategoryTopView.categoryImage.image = [UIImage imageNamed:@"10001"];
    self.categoryImageName = @"10001";
    self.addCategoryTopView.categoryName.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.addCategoryTopView.categoryName resignFirstResponder];
    return YES;
    
}





- (void)alert:(NSString *)Title Message:(NSString *)message{
    MMPopupCompletionBlock completeBlock = ^(MMPopupView *popupView, BOOL finished){
    };
    MMAlertView *alertView = [[MMAlertView alloc] initWithConfirmTitle:Title detail:message];
    alertView.attachedView.mm_dimBackgroundBlurEnabled = YES;
    alertView.attachedView.mm_dimBackgroundBlurEffectStyle = UIBlurEffectStyleDark;
    [alertView showWithBlock:completeBlock];
    
}

- (void)selectBackBtn{
        [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 创建CollectionView
-(void)addTheCollectionView{
    
    //=======================1===========================
    //创建一个块状表格布局对象
    UICollectionViewFlowLayout *flowL = [UICollectionViewFlowLayout new];
    //格子的大小 (长，高)
    CGFloat w = screen_width * 0.09;
    CGFloat itemW = (self.view.frame.size.width - w) / 5;
    CGFloat itemH = screen_height * 0.08;
    
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
    
    
    CGFloat y = screen_height * 0.11;
    
    //创建一个UICollectionView
    self.AddCategoryCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width - w, screen_height - y) collectionViewLayout:flowL];
    //设置代理为当前控制器
    self.AddCategoryCollectionView.delegate = self;
    self.AddCategoryCollectionView.dataSource = self;
    //设置背景
    self.AddCategoryCollectionView.backgroundColor =[UIColor whiteColor];
    
    // 注册单元格
    [self.AddCategoryCollectionView registerClass:[AddCategoryCell class] forCellWithReuseIdentifier:indentify];
    
    //添加视图
    [self.view addSubview:self.AddCategoryCollectionView];
    
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
    AddCategoryCell *cell = (AddCategoryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
        cell.categoryImage.image = [UIImage imageNamed:self.images[indexPath.item].icon];
        return cell;
    
    
}

//选择collection
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.addCategoryTopView.categoryImage.image = [UIImage imageNamed:self.images[indexPath.item].icon];
    self.categoryImageName = self.images[indexPath.item].icon;
    
}


@end
