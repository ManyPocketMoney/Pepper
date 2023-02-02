//
//  HotCourseView.m
//  Pepper
//
//  Created by dong an on 2023/2/2.
//

#import "HotCourseView.h"

@implementation HotCourseView

- (instancetype)initWithFrame:(CGRect)frame data: (NSDictionary *)data {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        
        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        self.layer.shadowColor = [[UIColor hexStringToColor:@"#000000"] colorWithAlphaComponent:0.15].CGColor;
        self.layer.shadowOpacity = 1.0f;
        self.layer.shadowOffset = CGSizeMake(0,0);
        self.layer.shadowRadius = 6;
        
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [imgView sd_setImageWithURL:[NSURL URLWithString:data[@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
//        imgView.layer.masksToBounds = YES;
//        [imgView zy_cornerRadiusAdvance:20 rectCornerType:UIRectCornerTopLeft|UIRectCornerBottomLeft];
        [self addSubview:imgView];

        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_SIZE(134));
            make.height.centerY.left.equalTo(self);

        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"EXCEL精选";
        titleLabel.font = FONTSIZE_MEDIUM(14);
        titleLabel.textColor = BASECOLOR_GREEN;
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView.mas_right).offset(SCALE_SIZE(25));
            make.top.equalTo(self).offset(SCALE_SIZE(10));
        }];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.text = data[@"headline"];
        detailLabel.font = FONTSIZE_MEDIUM(16);
        detailLabel.textColor = BASECOLOR_BLACK_333;
        [self addSubview:detailLabel];
        
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgView.mas_right).offset(SCALE_SIZE(25));
            make.top.equalTo(titleLabel.mas_bottom).offset(SCALE_SIZE(5));
        }];
        
        ANButton *browseBtn = [ANButton buttonWithType:UIButtonTypeCustom];
        [browseBtn setImage:[UIImage imageNamed:@"browse"] forState:UIControlStateNormal];
        [browseBtn setTitle:[NSString stringWithFormat:@"%@",data[@"browse"]]  forState:UIControlStateNormal];
        [[browseBtn titleLabel] setFont:FONTSIZE_REGULAR(14)];
        [browseBtn setTitleColor:BASECOLOR_BLACK_999 forState:UIControlStateNormal];
        browseBtn.style = ANImagePositionLeft;
        browseBtn.margin = 4;
//        [browseBtn addTarget:self action:@selector(studyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:browseBtn];
        
        [browseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_SIZE(70));
            make.height.mas_equalTo(SCALE_SIZE(20));
            make.bottom.equalTo(self).offset(-SCALE_SIZE(11));
            make.left.equalTo(imgView.mas_right).offset(SCALE_SIZE(50));
        }];
        
        ANButton *giveBtn = [ANButton buttonWithType:UIButtonTypeCustom];
        [giveBtn setImage:[UIImage imageNamed:@"give"] forState:UIControlStateNormal];
        [giveBtn setTitle:[NSString stringWithFormat:@"%@",data[@"give"]]  forState:UIControlStateNormal];
        [[giveBtn titleLabel] setFont:FONTSIZE_REGULAR(14)];
        [giveBtn setTitleColor:BASECOLOR_BLACK_999 forState:UIControlStateNormal];
        giveBtn.style = ANImagePositionLeft;
        giveBtn.margin = 4;
//        [giveBtn addTarget:self action:@selector(studyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:giveBtn];
        
        [giveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_SIZE(70));
            make.height.mas_equalTo(SCALE_SIZE(20));
            make.bottom.equalTo(self).offset(-SCALE_SIZE(11));
            make.left.equalTo(imgView.mas_right).offset(SCALE_SIZE(145));
        }];
    }
    return self;
}
@end
