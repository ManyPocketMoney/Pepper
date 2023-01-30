//
//  BaseViewController.h
//  ZBMOM
//
//  Created by andong on 2021/1/19.
//

#import <UIKit/UIKit.h>
//#import "BaseNavigationController.h"
//#import "ZBToolView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

/// 导航栏左侧按钮点击回调
/// 如需自定义左侧点击事件方法 重写此参数setter方法
@property (nonatomic, copy) leftNavigationClickBlock  navigationBarLeftButtonClickBlock;

/// 导航栏右侧按钮点击回调
@property (nonatomic, copy) rightNavigationClickBlock navigationBarRightButtonClickBlock;

/// 表视图
@property (nonatomic, strong) UITableView        *tableView;

/// 数据源
@property (nonatomic, strong) NSMutableArray     *dataSource;

/// 导航栏背景颜色
@property (nonatomic, strong) UIColor            *navigationBarBackgroundColor;

/// 导航栏标题颜色
@property (nonatomic, strong) UIColor            *navigationBarTitleColor;

/// 自定义导航栏右侧按钮
@property (nonatomic, strong) UIButton           *navigationBarCustomRightButton;

/// 导航栏左侧按钮是否隐藏 导航页面push出二级页面左侧按钮自动显示 如需隐藏请设置此参数
/// 如果非push出页面 不会自动显示左侧返回按钮 如需显示也需要设置次参数
@property (nonatomic, assign) BOOL               navigationBarLeftButtonHidden;

/// 按钮栏
//@property (nonatomic, strong) ZBToolView         *toolBarView;

/// 路由跳转页面数据回调
@property (nonatomic, copy) void (^completion)(id);


/// 设置navigation左侧按钮（图片)
/// @param imageName 设置图片的名字
/// @param highlightImageName 高亮图片名字
/// @param block 点击回调
- (void)setNavigationBarLeftItemWithImageName:(NSString *)imageName
                           highlightImageName:(NSString *)highlightImageName
                                   clickBlock:(rightNavigationClickBlock)block;
/**
 设置navigation右侧按钮（图片)

 @param imageName 设置图片的名字
 @param highlightImageName 高亮图片名字
 @param block 点击回调
 */
- (void)setNavigationBarRightItemWithImageName:(NSString *)imageName
                            highlightImageName:(NSString *)highlightImageName
                                    clickBlock:(rightNavigationClickBlock)block;

/**
 设置navigation右侧按钮（文字）

 @param title 按钮文字
 @param block 点击回调
 */
- (void)setNavigationBarRightItemWithButtonTitle:(NSString *)title
                                      clickBlock:(rightNavigationClickBlock)block;

/// 关闭当前页面并刷新传入页面（pop）
/// @param className 要刷新的页面名称
- (void)closeVCToRefreshListVC:(NSString *)className;

/// 改变右侧导航按钮文字
/// @param title 文本
- (void)navigationBarChangeRightButtonTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
