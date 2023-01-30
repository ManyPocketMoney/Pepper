//
//  BaseViewController.m
//  ZBMOM
//
//  Created by andong on 2021/1/19.
//

#import "BaseViewController.h"


@interface BaseViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    CGFloat height = SCALE_SIZE(49)+KTabSpace;
//    self.toolBarView.frame = CGRectMake(0, iPhoneHeight-height-KtopHeitht, iPhoneWidth, height);
}

#pragma mark - 创建tableview  tableview懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.frame;
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setTableFooterView:[[UIView alloc] init]];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
        [_tableView setRowHeight:0];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //  _tableView.contentInset = UIEdgeInsetsMake(0, 0, KTabSpace, 0);
        [self.view addSubview:_tableView];

        
        if(@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
    }
    return _tableView;
}

//- (ZBToolView *)toolBarView {
//    if (!_toolBarView) {
//        _toolBarView = [[ZBToolView alloc] init];
//        [self.view addSubview:_toolBarView];
//    }
//    return _toolBarView;
//}

#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 关闭当前页面并刷新传入页面
- (void)closeVCToRefreshListVC:(NSString *)className {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIViewController *listVC;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:NSClassFromString(className)]) {
                listVC = vc;
            }
        }
        
        if ([listVC respondsToSelector:@selector(refreshData)]) {
            [listVC performSelector:@selector(refreshData)];
        }
        [self.navigationController popToViewController:listVC animated:NO];
    });
}

#pragma mark - 下级页面返回时调用的刷新数据
- (void)refreshData {
    self.dataSource = [NSMutableArray array];
    [self getData];
}

#pragma mark - 当前页面获取数据方法
- (void)getData {
    /// 子页面需重写此方法才能让上边关闭页面刷新列表页面方法生效
}


#pragma mark - getters and setters
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - 是否显示左侧按钮
- (void)setNavigationBarLeftButtonHidden:(BOOL)navigationBarLeftButtonHidden {
    if (navigationBarLeftButtonHidden) {
        /// 隐藏
        [(BaseNavigationController *)self.navigationController hiddenLeftNavigationItem];
    } else {
        /// 显示
        [(BaseNavigationController *)self.navigationController showLeftNavBtnWithClick:nil];
    }
}

#pragma mark - 设置navigation左侧按钮 - 图片
- (void)setNavigationBarLeftItemWithImageName:(NSString *)imageName
                           highlightImageName:(NSString *)highlightImageName
                                   clickBlock:(rightNavigationClickBlock)block {
    [(BaseNavigationController *)self.navigationController setNavigationBarLeftItemWithImageName:imageName
                                                                              highlightImageName:highlightImageName
                                                                                      clickBlock:block];
}

#pragma mark - 设置navigation右侧按钮 - 图片
- (void)setNavigationBarRightItemWithImageName:(NSString *)imageName
                            highlightImageName:(NSString *)highlightImageName
                                    clickBlock:(rightNavigationClickBlock)block {
    [(BaseNavigationController *)self.navigationController setNavigationBarRightItemWithImageName:imageName
                                                                               highlightImageName:highlightImageName
                                                                                       clickBlock:block];
}


#pragma mark - 设置navigation右侧按钮 - 文字
- (void)setNavigationBarRightItemWithButtonTitle:(NSString *)title
                                      clickBlock:(rightNavigationClickBlock)block {
    [(BaseNavigationController *)self.navigationController setNavigationBarRightItemWithButtonTitle:title clickBlock:block];
    
}


#pragma mark - 自定义右侧按键
- (void)setNavigationBarCustomRightButton:(UIButton *)navigationBarCustomRightButton {
    [(BaseNavigationController *)self.navigationController setNavigationBarCustomBtn:navigationBarCustomRightButton];
}

#pragma mark - 改变右侧导航按钮文字
- (void)navigationBarChangeRightButtonTitle:(NSString *)title {
    [(BaseNavigationController *)self.navigationController navigationBarChangeRightButtonTitle:title];
}

#pragma mark - 设置导航栏背景颜色
- (void)setNavigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor {
    [(BaseNavigationController *)self.navigationController setNavigationBarBackgroundColor:navigationBarBackgroundColor];
}


#pragma mark - 导航栏标题颜色
- (void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor {
    [(BaseNavigationController *)self.navigationController setNavigationBarTitleColor:navigationBarTitleColor];
}

- (void)dealloc {
    NSLog(@"%@", [NSString stringWithFormat:@"%@释放", [self class]])
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
