//
//  TopicView.m
//  Pepper
//
//  Created by dong an on 2023/2/6.
//

#import "TopicView.h"

@implementation TopicView

- (instancetype)initWithFrame:(CGRect)frame data: (NSDictionary *)data {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        
//        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
//        self.layer.shadowColor = [[UIColor hexStringToColor:@"#000000"] colorWithAlphaComponent:0.15].CGColor;
//        self.layer.shadowOpacity = 1.0f;
//        self.layer.shadowOffset = CGSizeMake(0,0);
//        self.layer.shadowRadius = 6;
        
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [imgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"placeholder_topic"]];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.layer.masksToBounds = YES;
//        [imgView zy_cornerRadiusAdvance:20 rectCornerType:UIRectCornerTopLeft|UIRectCornerBottomLeft];
        [self addSubview:imgView];

        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(frame.size.height*0.65);
            make.width.top.left.equalTo(self);

        }];
        
//        UILabel *titleLabel = [[UILabel alloc] init];
//        titleLabel.text = @"EXCEL精选";
//        titleLabel.font = FONTSIZE_MEDIUM(14);
//        titleLabel.textColor = BASECOLOR_GREEN;
//        [self addSubview:titleLabel];
//
//        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(imgView.mas_right).offset(SCALE_SIZE(25));
//            make.top.equalTo(self).offset(SCALE_SIZE(10));
//        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"专辑名称专辑名称专辑...";
        titleLabel.font = FONTSIZE_MEDIUM(16);
        titleLabel.textColor = BASECOLOR_BLACK_333;
//        detailLabel.numberOfLines = 0;
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCALE_SIZE(15));
            make.right.equalTo(self).offset(-SCALE_SIZE(15));
            make.top.equalTo(imgView.mas_bottom).offset(SCALE_SIZE(11));
        }];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.text = @"5个课程内容";
        detailLabel.font = FONTSIZE_MEDIUM(12);
        detailLabel.textColor = BASECOLOR_BLACK_999;
//        detailLabel.numberOfLines = 0;
        [self addSubview:detailLabel];
        
      
        
        ANButton *browseBtn = [ANButton buttonWithType:UIButtonTypeCustom];
        [browseBtn setImage:[UIImage imageNamed:@"browse"] forState:UIControlStateNormal];
        [browseBtn setTitle:[NSString stringWithFormat:@"%@",@"666"]  forState:UIControlStateNormal];
        [[browseBtn titleLabel] setFont:FONTSIZE_REGULAR(14)];
        [browseBtn setTitleColor:BASECOLOR_BLACK_999 forState:UIControlStateNormal];
        browseBtn.style = ANImagePositionLeft;
        browseBtn.margin = 4;
//        [browseBtn addTarget:self action:@selector(studyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:browseBtn];
        
        [browseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_SIZE(70));
            make.height.mas_equalTo(SCALE_SIZE(20));
            make.bottom.equalTo(self).offset(-SCALE_SIZE(9));
            make.right.equalTo(self).offset(-SCALE_SIZE(15));
        }];
        
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCALE_SIZE(15));
//            make.right.equalTo(self).offset(-SCALE_SIZE(15));
            make.centerY.equalTo(browseBtn);
        }];
        
//        ANButton *giveBtn = [ANButton buttonWithType:UIButtonTypeCustom];
//        [giveBtn setImage:[UIImage imageNamed:@"give"] forState:UIControlStateNormal];
//        [giveBtn setTitle:[NSString stringWithFormat:@"%@",data[@"give"]]  forState:UIControlStateNormal];
//        [[giveBtn titleLabel] setFont:FONTSIZE_REGULAR(14)];
//        [giveBtn setTitleColor:BASECOLOR_BLACK_999 forState:UIControlStateNormal];
//        giveBtn.style = ANImagePositionLeft;
//        giveBtn.margin = 4;
////        [giveBtn addTarget:self action:@selector(studyBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:giveBtn];
//
//        [giveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(SCALE_SIZE(70));
//            make.height.mas_equalTo(SCALE_SIZE(20));
//            make.bottom.equalTo(self).offset(-SCALE_SIZE(11));
//            make.left.equalTo(imgView.mas_right).offset(SCALE_SIZE(145));
//        }];
    }
    return self;
}

@end
