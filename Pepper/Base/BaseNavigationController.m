//
//  BaseNavigationController.m
//  NBox
//
//  Created by 安东 on 2018/9/4.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "BaseNavigationController.h"
#import <ANCore/ANCore.h>
#import "ZBBaseViewController.h"
#import "ZBMacros.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate>


@property (nonatomic, strong) UIBarButtonItem  *leftBtnItem;
@property (nonatomic, strong) UIButton         *rightBtn;
@property (nonatomic, strong) API_AVAILABLE(ios(13.0)) UINavigationBarAppearance *navBarAppearance;
@property (nonatomic, strong) NSMutableDictionary *attributes;

@end


@implementation BaseNavigationController

/// APP生命周期中 只会执行一次
+ (void)initialize {
    
}

/// 当设置了 childViewControllerForStatusBarStyle 后，不会进入这里
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

/// 以topViewController 的 preferredStatusBarStyle 来设置 statusBarStyle
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
        
    /// 设置navigationBar上title的颜色与字体
    [self.attributes setObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    [self.attributes setObject:[UIFont systemFontOfSize:18.f weight:UIFontWeightBold] forKey:NSFontAttributeName];
    
    /// 不透明
    self.navigationBar.translucent = NO;

    if (@available(iOS 13.0, *)) {
        self.navBarAppearance.titleTextAttributes = self.attributes;
        self.navigationBar.scrollEdgeAppearance   = self.navBarAppearance;
        self.navigationBar.standardAppearance     = self.navBarAppearance;
    } else {
        self.navigationBar.titleTextAttributes = self.attributes;
        [self.navigationBar setShadowImage:[UIImage new]];
    }
    /// 导航栏阴影
    self.navigationBar.layer.shadowColor = BASECOLOR_BACKGROUND_GRAY.CGColor;
    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 0.1);
    self.navigationBar.layer.shadowOpacity = 0.5;
    
    /// 设全屏启动右滑返回手势
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    
    /// 获取添加系统边缘触发手势的View
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    
    /// 创建pan手势 作用范围是全屏
    UIPanGestureRecognizer *fullScreenGes = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
    fullScreenGes.delegate = self;
    [targetView addGestureRecognizer:fullScreenGes];
    
    /// 关闭边缘触发手势 防止和原有边缘手势冲突（也可不用关闭）
    [self.interactivePopGestureRecognizer setEnabled:NO];
    
    @weakify(self);
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        @strongify(self);
        self.interactivePopGestureRecognizer.delegate = (id)self;
    }
}

- (UINavigationBarAppearance *)navBarAppearance {
    if (!_navBarAppearance) {
        _navBarAppearance = [UINavigationBarAppearance new];
        _navBarAppearance.backgroundColor = [UIColor whiteColor];
        _navBarAppearance.backgroundEffect = nil;
        _navBarAppearance.shadowColor = [UIColor clearColor];
    }
    return _navBarAppearance;
}


#pragma mark - UIGestureRecognizerDelegate
/// 这个方法是在手势将要激活前调用：返回YES允许右滑手势的激活，返回NO不允许右滑手势的激活
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /// 根视图禁用右滑
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    
    if (self.interactivePopGestureRecognizer &&
        [[self.interactivePopGestureRecognizer.view gestureRecognizers] containsObject:gestureRecognizer]) {
        
        CGPoint tPoint = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
        
        if (tPoint.x >= 0) {
            CGFloat y = fabs(tPoint.y);
            CGFloat x = fabs(tPoint.x);
            CGFloat af = 30.0f/180.0f * M_PI;
            CGFloat tf = tanf(af);
            if ((y/x) <= tf) {
                return YES;
            }
            return NO;
            
        } else {
            return NO;
        }
    }
    return YES;
}

/// push时隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = self.leftBtnItem;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}


#pragma mark -  导航控制器的子控制器被pop[移除]的时候会调用
-(UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    return [super popViewControllerAnimated:animated];
}

#pragma mark - 重新定义左侧按键的点击方法
- (void)showLeftNavBtnWithClick:(leftNavigationClickBlock)leftClickBlock {
    
    [NSObject currentActiveController].navigationItem.leftBarButtonItem = self.leftBtnItem;
    [self currentBaseVC].navigationBarLeftButtonClickBlock = leftClickBlock;
}

#pragma mark - 隐藏左侧按键
- (void)hiddenLeftNavigationItem {

    [NSObject currentActiveController].navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
}

/// 当前baseVC
- (ZBBaseViewController *)currentBaseVC {
    return (ZBBaseViewController *)[NSObject currentActiveController];
}


#pragma mark - navigationBar button click
- (void)leftNavigationBtnClick:(UIButton *)backBtn {
    if ([self currentBaseVC].navigationBarLeftButtonClickBlock) {
        [self currentBaseVC].navigationBarLeftButtonClickBlock(backBtn);
    } else {
        if (self.viewControllers.count > 1) {
            /// push
            [self popViewControllerAnimated:YES];
        } else {
            /// present方式
            [[NSObject currentActiveController] dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)rightNavigationBtnClick:(UIButton *)rightNavigationBtn {
    ZBBaseViewController *currentVC = [self currentBaseVC];
    /// 对于集合视图 获取当前视图为YN子视图 所以对于应用YN的VC 需要特别处理 否则导航栏的回调则不生效
    if ([currentVC.parentViewController isKindOfClass:NSClassFromString(@"YNPageViewController")]) {
        currentVC = (ZBBaseViewController *)currentVC.parentViewController.parentViewController;
    }
    
    if (currentVC.navigationBarRightButtonClickBlock) {
        currentVC.navigationBarRightButtonClickBlock(rightNavigationBtn);
    }
}

#pragma mark - navigation left button 展示样式
- (void)setNavigationBarLeftItemWithImageName:(NSString *)imageName
                           highlightImageName:(NSString *)highlightImageName
                                   clickBlock:(leftNavigationClickBlock)block {
    [self currentBaseVC].navigationBarLeftButtonClickBlock = block;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(leftNavigationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, KNavBarHeight*2, KNavBarHeight)];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [NSObject currentActiveController].navigationItem.leftBarButtonItem = leftBtnItem;
}

#pragma mark - navigation right button 展示样式
-(void)setNavigationBarRightItemWithImageName:(NSString *)imageName
                           highlightImageName:(NSString *)highlightImageName
                                   clickBlock:(rightNavigationClickBlock)block {
    [self currentBaseVC].navigationBarRightButtonClickBlock = block;
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setFrame:CGRectMake(0, 0, KNavBarHeight*2, KNavBarHeight)];
    [self.rightBtn addTarget:self  action:@selector(rightNavigationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.rightBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.rightBtn setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    [NSObject currentActiveController].navigationItem.rightBarButtonItem = rightBtnItem;
}

-(void)setNavigationBarRightItemWithButtonTitle:(NSString *)title clickBlock:(rightNavigationClickBlock)block {
    [self currentBaseVC].navigationBarRightButtonClickBlock = block;

    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitle:title forState:UIControlStateNormal];
    [self.rightBtn setFrame:CGRectMake(0, 0, KNavBarHeight*2, KNavBarHeight)];
    [self.rightBtn addTarget:self  action:@selector(rightNavigationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitleColor:BASECOLOR_BLUE forState:UIControlStateNormal];
    [self.rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.rightBtn titleLabel].font = FONTSIZE_REGULAR(14);
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    [self currentBaseVC].navigationItem.rightBarButtonItem = rightBtnItem;
}

- (void)setNavigationBarCustomBtn:(UIButton *)button {
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [NSObject currentActiveController].navigationItem.rightBarButtonItem = rightBtnItem;
}

- (void)navigationBarChangeRightButtonTitle:(NSString *)title {
    [self.rightBtn setTitle:title forState:UIControlStateNormal];
}

- (void)navigationBarChangeRightButtonTitleColor:(UIColor *)color {
    [self.rightBtn setTitleColor:color forState:UIControlStateNormal];
}

- (void)setNavigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor {
    self.navigationBar.barTintColor             = navigationBarBackgroundColor;
    if (@available(iOS 13.0, *)) {
        self.navBarAppearance.backgroundColor   = navigationBarBackgroundColor;
        self.navigationBar.scrollEdgeAppearance = self.navBarAppearance;
        self.navigationBar.standardAppearance   = self.navBarAppearance;
    }
}

- (void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor {
    if (@available(iOS 13.0, *)) {
        [self.attributes setObject:navigationBarTitleColor forKey:NSForegroundColorAttributeName];
        self.navBarAppearance.titleTextAttributes = self.attributes;
        self.navigationBar.scrollEdgeAppearance   = self.navBarAppearance;
        self.navigationBar.standardAppearance     = self.navBarAppearance;
    } else {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:navigationBarTitleColor}];
    }
}

#pragma mark - getters
- (UIBarButtonItem *)leftBtnItem {
    if (!_leftBtnItem) {
        ANButton *backBtn = [ANButton buttonWithType:UIButtonTypeCustom];
        backBtn.style = ANImagePositionLeft;
        backBtn.margin = 3;
        [backBtn setFrame:CGRectMake(0, 0, KNavBarHeight*2, KNavBarHeight)];
        [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [backBtn setTitleColor:BASECOLOR_BLUE forState:UIControlStateNormal];
        [[backBtn titleLabel] setFont:FONTSIZE_REGULAR(14)];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"ZBCore.bundle/nav_left_back_default@3x.png"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"ZBCore.bundle/nav_left_back_default@3x.png"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(leftNavigationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    
    return _leftBtnItem;
}


- (NSMutableDictionary *)attributes {
    if (!_attributes) {
        _attributes = [NSMutableDictionary dictionary];
    }
    return _attributes;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
