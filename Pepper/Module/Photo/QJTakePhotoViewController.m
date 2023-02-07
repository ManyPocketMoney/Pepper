//
//  QJTakePhotoViewController.m
//  Pepper
//
//  Created by 雷子 on 2023/2/1.
//

#import "QJTakePhotoViewController.h"
#import "QJPhotoDistinguishResultVC.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@interface QJTakePhotoViewController ()<AVCapturePhotoCaptureDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UIButton     *backButton;
@property (nonatomic, strong) UIButton     *xzButton;
@property (nonatomic, strong) UILabel      *detailLabel;
@property (nonatomic, strong) UIView       *greenView;
@property (nonatomic, strong) UIButton     *lampButton;
@property (nonatomic, strong) UIView       *whiteView;

@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCapturePhotoOutput *imageOutput;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, assign) BOOL isFlashLampMode;

@property (strong, nonatomic) UIImagePickerController *ipc;/* 相册选择器 */
@end

@implementation QJTakePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addUI];
    
    
    self.device = [QJTakePhotoViewController getCaptureDevicePosition:AVCaptureDevicePositionBack];
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    self.imageOutput = [[AVCapturePhotoOutput alloc] init];
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPreset1280x720;
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.imageOutput])
    {
        [self.session addOutput:self.imageOutput];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.previewLayer)
    {
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        self.previewLayer.frame = self.whiteView.frame;
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.view.layer addSublayer:self.previewLayer];
        //设备取景开始
        [self.session startRunning];
    }
}


#pragma mark ====返回按钮
- (void)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ====旋转按钮
- (void)xzButtonClick:(UIButton *)sender {
    //给摄像头的切换添加翻转动画
    CATransition *animation = [CATransition animation];
    animation.duration = .5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"oglFlip";

    AVCaptureDevice *newCamera = nil;
    AVCaptureDeviceInput *newInput = nil;
    //拿到另外一个摄像头位置
    AVCaptureDevicePosition position = [[_input device] position];
    if (position == AVCaptureDevicePositionFront)
    {
        newCamera = [QJTakePhotoViewController getCaptureDevicePosition:AVCaptureDevicePositionBack];
        animation.subtype = kCATransitionFromLeft;//动画翻转方向
    }
    else {
        newCamera = [QJTakePhotoViewController getCaptureDevicePosition:AVCaptureDevicePositionFront];
        animation.subtype = kCATransitionFromRight;//动画翻转方向
    }
    //生成新的输入
    newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
    [self.previewLayer addAnimation:animation forKey:nil];
    if (newInput != nil) {
        [self.session beginConfiguration];
        [self.session removeInput:self.input];
        if ([self.session canAddInput:newInput]) {
            [self.session addInput:newInput];
            self.input = newInput;
        } else {
            [self.session addInput:self.input];
        }
        [self.session commitConfiguration];
    }
}
#pragma mark ====中间确认按钮
- (void)photo_pButtonClick:(UIButton *)sender {
//    AVCaptureConnection *conntion = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
//    if (!conntion) {
//        NSLog(@"拍照失败!");
//        return;
//    }
//    AVCapturePhotoSettings *settings = [[AVCapturePhotoSettings alloc] init];
//    settings.flashMode = self.isFlashLampMode;
//    [self.imageOutput capturePhotoWithSettings:settings delegate:self];
    
    QJPhotoDistinguishResultVC *vc = [[QJPhotoDistinguishResultVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ====手电筒确认按钮
- (void)lampButtonClick:(UIButton *)sender {
    self.isFlashLampMode = !self.isFlashLampMode;
    if (self.isFlashLampMode)
        [self.lampButton setImage:[UIImage imageNamed:@"photo_lampOn"] forState:UIControlStateNormal];
    else
        [self.lampButton setImage:[UIImage imageNamed:@"photo_lamp"] forState:UIControlStateNormal];
}
#pragma mark ====选择图片按钮
- (void)picButtonClick:(UIButton *)sender {
    //创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    //设置拾取源类型
    ipc.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.mediaTypes = @[(NSString *)kUTTypeImage];
    ipc.delegate = self;//设置代理
    ipc.allowsEditing = NO;
    self.ipc = ipc;
    //弹出图片选择控制器
    [self presentViewController:ipc animated:YES completion:nil];
}



/* 选择了一个图片或者视频后调用 */
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSURL *mediaURL = nil;
    UIImage *image = nil;
    if ([mediaType isEqualToString:@"public.image"]){//选择了图片
        mediaURL = [info objectForKey:UIImagePickerControllerImageURL];
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        if (mediaURL && image) {
//            self.imgTakePhoto.image = image;
//            self.imgTakePhoto.hidden = NO;
//            [self.view bringSubviewToFront:self.imgTakePhoto];
//            self.imgIdentify.hidden = NO;
//            self.lblIdentify.hidden = NO;
//            [self.view bringSubviewToFront:self.imgIdentify];
//            [self.view bringSubviewToFront:self.lblIdentify];
//            __typeof__(self) __weak weakSelf = self;
//            [self imageOcr:image completionBlock:^(NSString *words) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    __typeof__(self) strongSelf = weakSelf;
//                    strongSelf.imgIdentify.hidden = YES;
//                    strongSelf.lblIdentify.hidden = YES;
//                    strongSelf.imgTakePhoto.hidden = YES;
//                    if ([words isEqualToString:@"TP_OCR_FAIL"])
//                    {
//                        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"文字识别" message:@"识别失败，请联系技术支持！" preferredStyle:UIAlertControllerStyleAlert];
//                        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                        }];
//                        [vc addAction:act];
//                        [self presentViewController:vc animated:YES completion:nil];
//                    }
//                    else {
//                        TPPhotoOcrVC *ocrVC = [[TPPhotoOcrVC alloc] initWithNibName:@"TPPhotoOcrVC" bundle:nil];
//                        ocrVC.modalPresentationStyle = UIModalPresentationFullScreen;
//                        ocrVC.orcWords = words;
//                        [strongSelf presentViewController:ocrVC animated:YES completion:nil];
//                    }
//                });
//            }];
        }
    }];
}

#pragma mark AVCapturePhotoCaptureDelegate
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error
{
    if (!error)
    {
        NSData *data = [photo fileDataRepresentation];
        UIImage *image = [UIImage imageWithData:data];
//        self.imgTakePhoto.image = image;
//        self.imgTakePhoto.hidden = NO;
//        [self.view bringSubviewToFront:self.imgTakePhoto];
//
//        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//
//        self.imgIdentify.hidden = NO;
//        self.lblIdentify.hidden = NO;
//        [self.view bringSubviewToFront:self.imgIdentify];
//        [self.view bringSubviewToFront:self.lblIdentify];
//        __typeof__(self) __weak weakSelf = self;
//        [self imageOcr:image completionBlock:^(NSString *words) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                __typeof__(self) strongSelf = weakSelf;
//                strongSelf.imgIdentify.hidden = YES;
//                strongSelf.lblIdentify.hidden = YES;
//                strongSelf.imgTakePhoto.hidden = YES;
//                if ([words isEqualToString:@"TP_OCR_FAIL"])
//                {
//                    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"文字识别" message:@"识别失败，请联系技术支持！" preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                    }];
//                    [vc addAction:act];
//                    [self presentViewController:vc animated:YES completion:nil];
//                }
//                else {
//                    TPPhotoOcrVC *ocrVC = [[TPPhotoOcrVC alloc] initWithNibName:@"TPPhotoOcrVC" bundle:nil];
//                    ocrVC.modalPresentationStyle = UIModalPresentationFullScreen;
//                    ocrVC.orcWords = words;
//                    [strongSelf presentViewController:ocrVC animated:YES completion:nil];
//                }
//            });
//        }];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo
{
}

- (void)addUI {
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.xzButton];
    [self.view addSubview:self.detailLabel];
    [self.view addSubview:self.greenView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(kVertiSpace(50));
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.left.mas_equalTo(SCALE_SIZE(5));
        make.width.mas_equalTo(SCALE_SIZE(34));
        make.height.mas_equalTo(SCALE_SIZE(34));
    }];
    
    [self.xzButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.view).offset(-SCALE_SIZE(39));
        make.width.mas_equalTo(SCALE_SIZE(34));
        make.height.mas_equalTo(SCALE_SIZE(34));
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(kVertiSpace(148));
    }];
    
    [self.greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(kVertiSpace(153));
    }];
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"photo_p"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(photo_pButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.greenView addSubview:button];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.greenView);
        make.top.mas_equalTo(kVertiSpace(37));
        make.width.height.mas_equalTo(kVertiSpace(98));
    }];


    self.lampButton = [[UIButton alloc] init];
    [self.lampButton setImage:[UIImage imageNamed:@"photo_lamp"] forState:UIControlStateNormal];
    [self.lampButton addTarget:self action:@selector(lampButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.greenView addSubview:self.lampButton];

    [self.lampButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(button);
        make.left.mas_equalTo(SCALE_SIZE(20));
        make.width.mas_equalTo(kVertiSpace(24));
        make.height.mas_equalTo(kVertiSpace(36));
    }];

    UIButton *picButton = [[UIButton alloc] init];
    [picButton setImage:[UIImage imageNamed:@"photo_pic"] forState:UIControlStateNormal];
    [picButton addTarget:self action:@selector(picButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.greenView addSubview:picButton];

    [picButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(button);
        make.right.equalTo(self.greenView).offset(-SCALE_SIZE(15));
        make.width.mas_equalTo(kVertiSpace(45));
        make.height.mas_equalTo(kVertiSpace(36));
    }];
    
    
    self.whiteView = [[UIView alloc] init];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.whiteView];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-kVertiSpace(10));
        make.height.mas_equalTo(kVertiSpace(395));
        make.width.mas_equalTo(kLevelSpace(297));
    }];
}

- (UILabel *)titleLabel {
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"文件拍照翻译";
        _titleLabel.font = FONTSIZE_BLOD(18);
        
    }
    return _titleLabel;
}

- (UIButton *)backButton {
    if(!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"nav_close"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}


- (UIButton *)xzButton {
    if(!_xzButton) {
        _xzButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_xzButton setImage:[UIImage imageNamed:@"photo_fz"] forState:UIControlStateNormal];
        [_xzButton addTarget:self action:@selector(xzButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _xzButton;
}

- (UILabel *)detailLabel {
    if(!_detailLabel){
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.text = @"*请将扫描文件放置下方识别区域";
        _detailLabel.font = FONTSIZE_REGULAR(14);
    }
    return _detailLabel;
}

- (UIView *)greenView {
    if(!_greenView) {
        _greenView = [[UIView alloc] init];
        _greenView.backgroundColor = BASECOLOR_GREEN;
    }
    return _greenView;
}

+ (AVCaptureDevice *)getCaptureDevicePosition:(AVCaptureDevicePosition)position {
    NSArray *devices = nil;
    
    AVCaptureDeviceDiscoverySession *deviceDiscoverySession =  [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:position];
    devices = deviceDiscoverySession.devices;
    
    for (AVCaptureDevice *device in devices) {
        if (position == device.position) {
            return device;
        }
    }
    return NULL;
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
