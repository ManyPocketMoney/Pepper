//
//  QJTakePhotoViewController.m
//  Pepper
//
//  Created by 雷子 on 2023/2/1.
//

#import "QJTakePhotoViewController.h"

@interface QJTakePhotoViewController ()

@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UIButton     *backButton;
@property (nonatomic, strong) UIButton     *xzButton;

@end

@implementation QJTakePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.titleLabel];
}

#pragma mark ====返回按钮
- (void)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ====旋转按钮
- (void)xzButtonClick:(UIButton *)sender {
    
}

- (UILabel *)titleLabel {
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"文件拍照翻译";
        _titleLabel.font = FONTSIZE_BLOD(18);
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.mas_equalTo(SCALE_SIZE(50));
        }];
    }
    return _titleLabel;
}

- (UIButton *)backButton {
    if(!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"nav_close"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.mas_equalTo(SCALE_SIZE(5));
            make.width.mas_equalTo(SCALE_SIZE(34));
            make.height.mas_equalTo(SCALE_SIZE(34));
        }];
    }
    return _backButton;
}


- (UIButton *)xzButton {
    if(!_xzButton) {
        _xzButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_xzButton setImage:[UIImage imageNamed:@"photo_fz"] forState:UIControlStateNormal];
        [_xzButton addTarget:self action:@selector(xzButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_xzButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(self.view).offset(-SCALE_SIZE(39));
            make.width.mas_equalTo(SCALE_SIZE(34));
            make.height.mas_equalTo(SCALE_SIZE(34));
        }];
    }
    return _backButton;
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
