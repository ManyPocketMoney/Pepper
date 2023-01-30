//
//  ANRouterSpec+Pepper.m
//  Pepper
//
//  Created by dong an on 2023/1/5.
//

#import "ANRouterSpec+Pepper.h"

/// home
NSString *const KRequestHomeURL                 = @"ZB://home";

/// mine
NSString *const KRequestMineURL                 = @"ZB://mine";

NSString *const KRequestMessageURL              = @"ZB://home/message";


@implementation ANRouterSpec (Pepper)


+ (void)load {
    
    /// tabbar 首页
    [ANRouter registerURLPattern:KRequestHomeURL toObjectHandler:^id _Nullable(NSDictionary * _Nonnull routerParameters) {
        NSDictionary *info = routerParameters[ANRouterParameterUserInfo];
        UIViewController *vc = [ANViewControllerFactory viewControllerFromHost:@"ZBHome" info:info];
        UIViewController *homeNavigationController = [[BaseNavigationController alloc] initWithRootViewController:vc];
        return homeNavigationController;
    }];
    
    /// tabbar 我的
    [ANRouter registerURLPattern:KRequestMineURL toObjectHandler:^id _Nullable(NSDictionary * _Nonnull routerParameters) {
        NSDictionary *info = routerParameters[ANRouterParameterUserInfo];
        UIViewController *vc = [ANViewControllerFactory viewControllerFromHost:@"ZBMine" info:info];
        UIViewController *mineNavigationController = [[BaseNavigationController alloc] initWithRootViewController:vc];
        return mineNavigationController;
    }];
    
    /// 消息
    [ANRouter registerURLPattern:KRequestMessageURL toObjectHandler:^(NSDictionary * _Nonnull routerParameters) {
        NSDictionary *info = routerParameters[ANRouterParameterUserInfo];
        UIViewController *vc = [ANViewControllerFactory viewControllerFromHost:@"ZBMessageGuide" info:info];
        UIViewController *messageNavigationController = [[BaseNavigationController alloc] initWithRootViewController:vc];
        return messageNavigationController;
    }];
}

@end
