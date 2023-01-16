//
//  BaseNavigationController.h
//  NBox
//
//  Created by 安东 on 2018/9/4.
//  Copyright © 2018年 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^leftNavigationClickBlock)(id sender);
typedef void (^rightNavigationClickBlock)(id sender);

@interface BaseNavigationController : UINavigationController

@property (nonatomic, strong) UIColor            *navigationBarBackgroundColor;

/// 导航栏标题颜色
@property (nonatomic, strong) UIColor            *navigationBarTitleColor;

- (void)hiddenLeftNavigationItem;

- (void)showLeftNavBtnWithClick:(leftNavigationClickBlock)leftClickBlock;

- (void)setNavigationBarLeftItemWithImageName:(NSString *)imageName
                           highlightImageName:(NSString *)highlightImageName
                                   clickBlock:(leftNavigationClickBlock)block;

- (void)setNavigationBarRightItemWithImageName:(NSString *)imageName
                            highlightImageName:(NSString *)highlightImageName
                                    clickBlock:(rightNavigationClickBlock)block;


- (void)setNavigationBarRightItemWithButtonTitle:(NSString *)title
                                      clickBlock:(rightNavigationClickBlock)block;


- (void)setNavigationBarCustomBtn:(UIButton *)button;


- (void)navigationBarChangeRightButtonTitle:(NSString *)title;


- (void)navigationBarChangeRightButtonTitleColor:(UIColor *)color;

@end
