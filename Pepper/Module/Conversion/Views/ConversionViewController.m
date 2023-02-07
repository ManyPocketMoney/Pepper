//
//  ConversionViewController.m
//  Pepper
//
//  Created by dong an on 2023/2/7.
//

#import "ConversionViewController.h"
#import "GetConversionTokenRequest.h"
#import "ConversionHistoryViewController.h"

@interface ConversionViewController () <UIDocumentPickerDelegate>

@property (nonatomic, strong) UIDocumentPickerViewController *documentPicker;
@property (nonatomic, copy) NSArray *types;

@end

@implementation ConversionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转化历史";
    [self createInterface];
    [self getToken];
}

- (void)createInterface {
    self.view.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"conversion_top"]];
    [self.view addSubview:imgView];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_SIZE(15));
        make.right.mas_equalTo(-SCALE_SIZE(15));
        make.top.mas_equalTo(SCALE_SIZE(28));
        make.height.mas_equalTo(SCALE_SIZE(146));
    }];
    
    NSArray *array = @[@{@"title":@"pdf转word",@"image":@"word"},
                       @{@"title":@"pdf转excel",@"image":@"excel"},
                       @{@"title":@"word转pdf",@"image":@"pdf"},
                       @{@"title":@"ppt转pdf",@"image":@"pdf"},
                       @{@"title":@"pdf转ppt",@"image":@"ppt"},
                       @{@"title":@"pdf转txt",@"image":@"txt"}];
    
    CycleUtil *util = [[CycleUtil alloc] init];
    util.column = 2;
    util.height = SCALE_SIZE(165);
    util.topSpace = SCALE_SIZE(180);
    util.leftSpace = SCALE_SIZE(15);
    [util cycleWithCount:array.count cycleViewBlock:^(NSInteger index, CGRect rect) {
        NSDictionary *dic = array[index];
        ANButton *button = [ANButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:dic[@"image"]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:dic[@"image"]] forState:UIControlStateHighlighted];
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button setTitleColor:BASECOLOR_BLACK_333 forState:UIControlStateNormal];
        [[button titleLabel] setFont:FONTSIZE_REGULAR(16)];
        button.style = ANImagePositionUp;
        button.margin = 14;
        button.tag = 100 + index;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        button.frame = rect;
    }];
}

- (void)btnClick:(UIButton *)button {
    [ANAlert alertShowWithParams:^(ANAlert * _Nonnull alert) {
        alert.title(@"请选择文件方式")
        .alertStyle(UIAlertControllerStyleActionSheet)
        .actionTitles(@[@"文件库导入",@"QQ、微信导入",@"取消"]);
    } handler:^(int index) {
        if (index == 0) {
            [self presentViewController:self.documentPicker animated:YES completion:nil];
        }
    }];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    /// 获取授权
    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
    if (fileUrlAuthozied) {
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL * _Nonnull newURL) {
            /// 读取文件
            NSString *fileName = [newURL lastPathComponent];
            NSError *error = nil;
            NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
            
            NSLog(@"名字:%@",fileName);
            NSLog(@"文件:%@",fileData);
            if (error) {
                
            } else {
                ConversionHistoryViewController *vc = [[ConversionHistoryViewController alloc] init];
                vc.fileName = fileName;
                vc.fileData = fileData;
                vc.fileUrl = newURL;
                [self.navigationController pushViewController:vc animated:NO];
            }
            /// 写入沙盒
//            NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
//            NSFileManager *fileManager = [NSFileManager defaultManager];
//            BOOL isExists = [fileManager fileExistsAtPath:filePath];
//            if (isExists) {
//                [fileManager removeItemAtPath:filePath error:nil];
//            }
//            BOOL isCreate = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
//            if (isCreate) {
//                BOOL isWrite = [fileData writeToFile:filePath options:NSDataWritingAtomic error:nil];
//                if (isWrite) {
//
//
//                }
//            }
        }];
        [urls.firstObject stopAccessingSecurityScopedResource];
    }
}

/// 获取token
- (void)getToken {
    if (![UserDefaultUtil userDefaultsObject:@"token"]) {
        GetConversionTokenRequest *request = [[GetConversionTokenRequest alloc] init];
        [request netRequestWithSuccess:^(id  _Nonnull response) {
            [UserDefaultUtil setUserDefaultsObject:response[@"data"][@"token"] forKey:@"token"];
        } error:^{
            
        } failure:^(NSString * _Nonnull msg) {
            
        }];
    }
}

- (NSArray *)types {
    return @[@"public.data"];
}

- (UIDocumentPickerViewController *)documentPicker {
    if (!_documentPicker) {
        _documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:self.types inMode:UIDocumentPickerModeOpen];
        _documentPicker.delegate = self;
        _documentPicker.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return _documentPicker;
}

@end
