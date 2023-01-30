//
//  AppDelegate.m
//  Pepper
//
//  Created by dong an on 2023/1/5.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    /// 配置rootViewController
    Class class = NSClassFromString(@"HomeViewController");
    UIViewController *ctrl = class.new;
    self.window.rootViewController = ctrl;
    
    return YES;
}





@end
