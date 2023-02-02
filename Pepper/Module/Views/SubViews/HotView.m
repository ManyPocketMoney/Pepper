//
//  HotView.m
//  Pepper
//
//  Created by dong an on 2023/2/1.
//

#import "HotView.h"
#import "HotCourseRequest.h"

@implementation HotView {
    NSArray *_array;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        HotCourseRequest *request = [[HotCourseRequest alloc] init];
        [request netRequestWithSuccess:^(id  _Nonnull response) {
            self->_array = response[@"data"];
            [self createInterface];
        } error:^{
            
        } failure:^(NSString * _Nonnull msg) {
            
        }];
    }
    return self;
}

- (void)createInterface {
    _array = @[@"",@"",@"",@"",@"",@""];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, iPhoneWidth, self.frame.size.height)];
    scrollView.contentSize = CGSizeMake(SCALE_SIZE(15)+SCALE_SIZE(100)*_array.count, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    for (int i = 0; i < _array.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"文档表格" forState:UIControlStateNormal];
        [button setTitleColor:BASECOLOR_BLACK_999 forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor hexStringToColor:@"#D4E1EE"]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:BASECOLOR_GREEN] forState:UIControlStateSelected];
        [button titleLabel].font = FONTSIZE_REGULAR(13);
        button.layer.cornerRadius = SCALE_SIZE(17);
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [scrollView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCALE_SIZE(15)+SCALE_SIZE(100)*i);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(SCALE_SIZE(82));
            make.height.mas_equalTo(SCALE_SIZE(34));
        }];
        
        if (i == 0) {
            button.selected = YES;
            
        }
    }
}

- (void)buttonClick:(UIButton *)button {
    for (int i = 0; i < _array.count; i++) {
        UIButton *btn = [self viewWithTag:100+i];
        btn.selected = NO;
    }
    button.selected = YES;
}

@end
