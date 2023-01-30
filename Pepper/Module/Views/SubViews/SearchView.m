//
//  SearchView.m
//  Pepper
//
//  Created by dong an on 2023/1/6.
//

#import "SearchView.h"

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"search_back"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"search_back"] forState:UIControlStateHighlighted];
        [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCALE_SIZE(15));
            make.right.mas_equalTo(-SCALE_SIZE(15));
            make.top.height.equalTo(self);
        }];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"search"];
        [self addSubview:imgView];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backBtn).offset(SCALE_SIZE(28));
            make.top.equalTo(backBtn).offset(21);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"请输入你要查询的课程";
        titleLabel.font = FONTSIZE_MEDIUM(15);
        titleLabel.textColor = BASECOLOR_BLACK_666;
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView.mas_right).offset(SCALE_SIZE(15));
            make.centerY.equalTo(imgView);
        }];
    }
    return self;
}

- (void)backBtnClick {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

@end
