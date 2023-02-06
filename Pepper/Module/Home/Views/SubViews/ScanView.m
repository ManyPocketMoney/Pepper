//
//  ScanView.m
//  Pepper
//
//  Created by dong an on 2023/1/6.
//

#import "ScanView.h"

@implementation ScanView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"scan_back"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"scan_back"] forState:UIControlStateHighlighted];
//        [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCALE_SIZE(15));
            make.right.mas_equalTo(-SCALE_SIZE(15));
            make.top.height.equalTo(self);
        }];
        
        

        UILabel *middleLabel = [[UILabel alloc] init];
        middleLabel.text = @"「扫描识别」";
        middleLabel.font = FONTSIZE_MEDIUM(20);
        middleLabel.textColor = [UIColor whiteColor];
        [self addSubview:middleLabel];

        [middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backBtn).offset(SCALE_SIZE(15));
            make.centerY.equalTo(backBtn).offset(SCALE_SIZE(9));
        }];
        
        UILabel *topLabel = [[UILabel alloc] init];
        topLabel.text = @"精选学习工具";
        topLabel.font = FONTSIZE_MEDIUM(15);
        topLabel.textColor = [UIColor whiteColor];
        [self addSubview:topLabel];

        [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(middleLabel).offset(SCALE_SIZE(15));
            make.bottom.equalTo(middleLabel.mas_top).offset(-SCALE_SIZE(13));
        }];
        
        UILabel *downLabel = [[UILabel alloc] init];
        downLabel.text = @"哪里不清楚，扫描帮你";
        downLabel.font = FONTSIZE_REGULAR(12);
        downLabel.textColor = [UIColor whiteColor];
        [self addSubview:downLabel];

        [downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(middleLabel).offset(SCALE_SIZE(15));
            make.top.equalTo(middleLabel.mas_bottom).offset(SCALE_SIZE(12));
        }];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"scan_next"];
        [self addSubview:imgView];

        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(middleLabel);
            make.left.equalTo(middleLabel.mas_right);
        }];
    }
    return self;
}
@end
