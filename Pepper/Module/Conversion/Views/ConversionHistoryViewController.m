//
//  ConversionHistoryViewController.m
//  Pepper
//
//  Created by dong an on 2023/2/7.
//

#import "ConversionHistoryViewController.h"
#import "ConversionFileUploadRequest.h"
#import "FileDownloadRequest.h"

@interface ConversionHistoryViewController ()

@end

@implementation ConversionHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转化历史";
    [self.dataSource addObject:@{@"name":self.fileName,@"url":self.fileUrl}];
    [self createInterface];
}

- (void)createInterface {
    
    if ((self.index == 0 || self.index == 1 || self.index == 4 || self.index == 5) && ![self.fileUrl.pathExtension isEqualToString:@"pdf"]) {
        [ProgressHUDManager showHUDAutoHiddenWithWarning:@"请选择PDF类型的文件"];
        [self.navigationController popViewControllerAnimated:NO];
        return;
    }
    
    else if (self.index == 2 && !([self.fileUrl.pathExtension isEqualToString:@"doc"] || [self.fileUrl.pathExtension isEqualToString:@"docx"])) {
        [ProgressHUDManager showHUDAutoHiddenWithWarning:@"请选择WORD类型的文件"];
        [self.navigationController popViewControllerAnimated:NO];
        return;
    }
    
    else if (self.index == 3 && !([self.fileUrl.pathExtension isEqualToString:@"ppt"] || [self.fileUrl.pathExtension isEqualToString:@"pptx"])) {
        [ProgressHUDManager showHUDAutoHiddenWithWarning:@"请选择PPT类型的文件"];
        [self.navigationController popViewControllerAnimated:NO];
        return;
    }
    
    NSString *name = @"pdf";
    if ([self.fileUrl.pathExtension isEqualToString:@"pdf"]) {
        name = @"pdf";
    } else if ([self.fileUrl.pathExtension isEqualToString:@"doc"] || [self.fileUrl.pathExtension isEqualToString:@"docx"]) {
        name = @"word";
    } else if ([self.fileUrl.pathExtension isEqualToString:@"ppt"] || [self.fileUrl.pathExtension isEqualToString:@"pptx"]) {
        name = @"ppt";
    } else if ([self.fileUrl.pathExtension isEqualToString:@"xls"] || [self.fileUrl.pathExtension isEqualToString:@"xlsx"]) {
        name = @"excel";
    } else if ([self.fileUrl.pathExtension isEqualToString:@"txt"]) {
        name = @"txt";
    }
    
    
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
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
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
        
        ConversionFileUploadRequest *request = [[ConversionFileUploadRequest alloc] initWithFilePathURL:self.fileUrl type:self.info[@"type"] format:self.info[@"format"]];
        
        [request netRequestUploadMedia:UploadMediaFileType success:^(id  _Nonnull response) {
            [self downloadFileWithType:response[@"data"][@"handle_type"] fileKey:response[@"data"][@"file_key"]];
        } error:^{
            
        } progress:^(NSProgress * _Nonnull progress) {
            
        } failure:^(NSString * _Nonnull msg) {
            
        }];
    }
}

- (void)downloadFileWithType:(NSString *)type fileKey:(NSString *)fileKey {
    FileDownloadRequest *request = [[FileDownloadRequest alloc] initWithType:type fileKey:fileKey];
    [request netRequestDownloadFileWithSuccess:^(id  _Nonnull response) {
        
    } error:^{
        
    } progress:^(NSProgress * _Nonnull progress) {
        
    } failure:^(NSString * _Nonnull msg) {
        
    }];
}

@end
