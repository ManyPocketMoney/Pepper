//
//  ConversionHistoryViewController.m
//  Pepper
//
//  Created by dong an on 2023/2/7.
//

#import "ConversionHistoryViewController.h"
#import "ConversionFileUploadRequest.h"

@interface ConversionHistoryViewController ()

@end

@implementation ConversionHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转化历史";
    [self.dataSource addObject:@{@"name":self.fileName,@"data":self.fileData,@"url":self.fileUrl}];
    [self createInterface];
}

- (void)createInterface {
    
    for (int i = 0; i < self.dataSource.count; i++) {
        NSDictionary *dic = self.dataSource[i];
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor hexStringToColor:@"#ADEFBC"];
        backView.layer.cornerRadius = 10;
        [self.view addSubview:backView];
        
        CGFloat width = (iPhoneWidth-SCALE_SIZE(50))/2;
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(SCALE_SIZE(221));
            make.left.mas_equalTo(SCALE_SIZE(15)+(width+SCALE_SIZE(20))*i);
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(SCALE_SIZE(30));
        }];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pdf"]];
        [backView addSubview:imgView];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_SIZE(61));
            make.height.mas_equalTo(SCALE_SIZE(78));
            make.centerX.equalTo(backView);
            make.top.mas_equalTo(SCALE_SIZE(20));
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = dic[@"name"];
        titleLabel.font = FONTSIZE_MEDIUM(16);
        titleLabel.textColor = BASECOLOR_BLACK_333;
        titleLabel.numberOfLines = 0;
        [backView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCALE_SIZE(16));
            make.right.mas_equalTo(-SCALE_SIZE(16));
            make.top.equalTo(imgView.mas_bottom).offset(SCALE_SIZE(12));
            make.height.mas_equalTo(SCALE_SIZE(40));
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = BASECOLOR_GREEN;
        button.layer.cornerRadius = SCALE_SIZE(35)/2;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = FONTSIZE_MEDIUM(15);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        button.tag = 100 + i;
        [backView addSubview:button];
        
        if (i == 0) {
            [button setTitle:@"现在转化" forState:UIControlStateNormal ];
        } else {
            [button setTitle:@"分享" forState:UIControlStateNormal ];
        }
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(titleLabel);
            make.bottom.mas_equalTo(-SCALE_SIZE(16));
            make.height.mas_equalTo(SCALE_SIZE(35));
        }];
        
    }
}

- (void)buttonClick:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"现在转化"]) {
        [ProgressHUDManager showHUDWithText:@"正在生成中..."];
        ConversionFileUploadRequest *request = [[ConversionFileUploadRequest alloc] initWithFilePathURL:self.fileUrl];

        [request netRequestUploadMedia:UploadMediaFileType success:^(id  _Nonnull response) {
            
        } error:^{
            
        } progress:^(NSProgress * _Nonnull progress) {
            
        } failure:^(NSString * _Nonnull msg) {
            
        }];
    }
}

@end
