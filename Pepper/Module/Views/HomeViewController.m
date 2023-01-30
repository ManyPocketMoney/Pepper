//
//  HomeViewController.m
//  Pepper
//
//  Created by dong an on 2023/1/5.
//

#import "HomeViewController.h"
#import "NavigationView.h"
#import "SearchView.h"
#import "ScanView.h"

@interface HomeViewController ()

@property (nonatomic, strong) NavigationView *navigationView;
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ScanView *scanView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
    [self.view addSubview:self.navigationView];
    [self.scrollView addSubview:self.searchView];
    [self.scrollView addSubview:self.scanView];
}

#pragma marks - getters
- (NavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[NavigationView alloc] initWithFrame:CGRectMake(0, KStatusBarHeight, iPhoneWidth, SCALE_SIZE(70))];
        
        _navigationView.clickBlock = ^(int i) {
            switch (i) {
                case 1:
                    /// 头像
                    break;
                case 2:
                    /// 专注学习
                    break;
                case 3:
                    /// 观看历史
                    break;
                    
                default:
                    break;
            }
            
        };
    }
    return _navigationView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _navigationView.frame.size.height+_navigationView.frame.origin.y, iPhoneWidth, iPhoneHeight-KStatusBarHeight-SCALE_SIZE(80))];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (SearchView *)searchView {
    if (!_searchView) {
        _searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, SCALE_SIZE(10), iPhoneWidth, 63)];
        _searchView.clickBlock = ^{
            
        };
    }
    return _searchView;
}

- (ScanView *)scanView {
    if (!_scanView) {
        _scanView = [[ScanView alloc] initWithFrame:CGRectMake(0, _searchView.frame.size.height+_searchView.frame.origin.y, iPhoneWidth, SCALE_SIZE(165))];
        
    }
    return _scanView;
}

@end
