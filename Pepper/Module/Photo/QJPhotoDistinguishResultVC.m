//
//  QJPhotoDistinguishResultVC.m
//  Pepper
//
//  Created by 雷子 on 2023/2/2.
//

#import "QJPhotoDistinguishResultVC.h"

@interface QJPhotoDistinguishResultVC ()

@property (nonatomic, strong) UIButton      *textCopyButton;
@property (nonatomic, strong) UIButton      *saveButton;
@property (nonatomic, strong) UITextView     *contentTextView;

@end

@implementation QJPhotoDistinguishResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"识别结果";
    self.view.backgroundColor = BASECOLOR_GRAY_F5;
    [self addUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)textCopyButtonClick:(UIButton *)sender {
    
}

- (void)textSaveButtonClick:(UIButton *)sender {
    
}

- (void)addUI {
    [self.view addSubview:self.textCopyButton];
    [self.view addSubview:self.saveButton];
    [self.view addSubview:self.contentTextView];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-kVertiSpace(50));
        make.width.mas_equalTo(kLevelSpace(265));
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(SCALE_SIZE(50));
    }];
    
    [self.textCopyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(self.saveButton);
        make.bottom.equalTo(self.saveButton.mas_top).offset(-kVertiSpace(18));
    }];
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(24);
        make.width.mas_equalTo(iPhoneWidth-20);
        make.bottom.equalTo(self.textCopyButton.mas_top).offset(-24);
    }];
}

- (UIButton *)textCopyButton {
    if(!_textCopyButton) {
        _textCopyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_textCopyButton setTitle:@"复制文字" forState:(UIControlStateNormal)];
        [_textCopyButton setBackgroundColor:BASECOLOR_BLACK_999];
        _textCopyButton.layer.cornerRadius = 5;
        [_textCopyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_textCopyButton addTarget:self action:@selector(textCopyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [[_textCopyButton titleLabel] setFont:FONTSIZE_BLOD(18)];
    }
    return _textCopyButton;
}

- (UIButton *)saveButton {
    if(!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitle:@"保存文字" forState:(UIControlStateNormal)];
        [_saveButton setBackgroundColor:BASECOLOR_GREEN];
        _saveButton.layer.cornerRadius = 5;
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(textSaveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [[_saveButton titleLabel] setFont:FONTSIZE_BLOD(18)];
    }
    return _saveButton;
}

- (UITextView *)contentTextView {
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        _contentTextView.textColor = [UIColor hexStringToColor:@"#333333"];
        _contentTextView.font = FONTSIZE_REGULAR(16);
        _contentTextView.editable = NO;
        _contentTextView.text = @"首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter方法.其次,您正在设置一大堆非常接近默认值的不必要属性.这是一个更简单的,也许你的代码意图首先,当您可以使用属性时,您正在使用setter";
        //_contentTextView.delegate = self;
        _contentTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 5);
//        [_contentTextView setScrollEnabled:YES];
//        _contentTextView.layoutManager.allowsNonContiguousLayout = NO;
        _contentTextView.textAlignment = NSTextAlignmentCenter;
        _contentTextView.showsVerticalScrollIndicator=YES;
    }
    return _contentTextView;
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
