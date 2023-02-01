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
#import "TitleView.h"
#import "QJPersonalViewController.h"
#import "QJTakePhotoViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) NavigationView *navigationView;
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ScanView *scanView;
@property (nonatomic, strong) UIButton *conversionBtn;
@property (nonatomic, strong) UIButton *translationBtn;
@property (nonatomic, strong) TitleView *hotTitleView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
    [self.view addSubview:self.navigationView];
    [self.scrollView addSubview:self.searchView];
    [self.scrollView addSubview:self.scanView];
    [self.scrollView addSubview:self.conversionBtn];
    [self.scrollView addSubview:self.translationBtn];
    [self.scrollView addSubview:self.hotTitleView];
}

/// 文件转化点击
- (void)conversionBtnClick {
    
}

/// 拍照翻译点击
- (void)translationBtnClick {
    QJTakePhotoViewController *photo = [[QJTakePhotoViewController alloc] init];
    [self.navigationController pushViewController:photo animated:YES];
}

#pragma marks - getters
- (NavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[NavigationView alloc] initWithFrame:CGRectMake(0, KStatusBarHeight, iPhoneWidth, SCALE_SIZE(70))];
        
        _navigationView.clickBlock = ^(int i) {
            switch (i) {
                case 1:
                    /// 头像
                {
                    [self pushPersonal];
                }
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

- (void)pushPersonal {
    QJPersonalViewController *personal = [[QJPersonalViewController alloc] init];
    [self.navigationController pushViewController:personal animated:YES];
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

- (UIButton *)conversionBtn {
    if (!_conversionBtn) {
        _conversionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _conversionBtn.frame = CGRectMake(SCALE_SIZE(8),
                                          _scanView.frame.size.height+_scanView.frame.origin.y+SCALE_SIZE(15),
                                          SCALE_SIZE(185),
                                          SCALE_SIZE(120));
        [_conversionBtn setBackgroundImage:[UIImage imageNamed:@"conversion"] forState:UIControlStateNormal];
        [_conversionBtn addTarget:self action:@selector(conversionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conversionBtn;
}

- (UIButton *)translationBtn {
    if (!_translationBtn) {
        _translationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _translationBtn.frame = CGRectMake(iPhoneWidth-SCALE_SIZE(193),
                                           _scanView.frame.size.height+_scanView.frame.origin.y+SCALE_SIZE(15),
                                           SCALE_SIZE(185),
                                           SCALE_SIZE(120));
        [_translationBtn setBackgroundImage:[UIImage imageNamed:@"translation"] forState:UIControlStateNormal];
        [_translationBtn addTarget:self action:@selector(translationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _translationBtn;
}

- (TitleView *)hotTitleView {
    if (!_hotTitleView) {
        _hotTitleView = [[TitleView alloc] initWithFrame:CGRectMake(0, _conversionBtn.frame.size.height+_conversionBtn.frame.origin.y+SCALE_SIZE(15), iPhoneWidth, SCALE_SIZE(30)) title:@"热门课程"];
        _hotTitleView.block = ^{
            
        };
    }
    return _hotTitleView;
}

@end
