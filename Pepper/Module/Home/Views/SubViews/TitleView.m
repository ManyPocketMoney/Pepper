//
//  TitleView.m
//  Pepper
//
//  Created by dong an on 2023/2/1.
//

#import "TitleView.h"

@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    if (self = [super initWithFrame: frame]) {

        
        UIView *leftView = [[UILabel alloc] init];
        leftView.backgroundColor = BASECOLOR_GREEN;
        [self addSubview:leftView];
        
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(SCALE_SIZE(15));
            make.centerY.equalTo(self);
            make.width.mas_equalTo(SCALE_SIZE(4));
            make.height.mas_equalTo(SCALE_SIZE(20));
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.font = FONTSIZE_MEDIUM(18);
        titleLabel.textColor = BASECOLOR_BLACK;
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right).offset(SCALE_SIZE(6));
            make.centerY.equalTo(self);
        }];
        
        ANButton *moreBtn = [ANButton buttonWithType:UIButtonTypeCustom];
        [moreBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [moreBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        [moreBtn setTitleColor:BASECOLOR_GREEN forState:UIControlStateNormal];
        [[moreBtn titleLabel] setFont:FONTSIZE_REGULAR(12)];
        moreBtn.style = ANImagePositionRight;
        moreBtn.margin = 4;
        [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:moreBtn];
        
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(SCALE_SIZE(5));
            make.centerY.height.equalTo(self);
            make.width.mas_equalTo(SCALE_SIZE(100));
        }];
        
        
    }
    return self;
}

- (void)moreBtnClick {
    if (self.block) {
        self.block();
    }
}

@end
