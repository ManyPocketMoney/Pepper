//
//  NavigationView.m
//  Pepper
//
//  Created by dong an on 2023/1/6.
//

#import "NavigationView.h"

@implementation NavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [headBtn setImage:[UIImage imageNamed:@"navigation_head"] forState:UIControlStateNormal];
        [headBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:headBtn];
        
        [headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.mas_equalTo(SCALE_SIZE(15));
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"青椒课堂";
        titleLabel.font = FONTSIZE_MEDIUM(20);
        titleLabel.textColor = BASECOLOR_GREEN;
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headBtn.mas_right).offset(SCALE_SIZE(7));
            make.bottom.equalTo(self.mas_centerY);
        }];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.text = [NSString stringWithFormat:@"Hi，%@好",[self showNow]];
        detailLabel.font = FONTSIZE_REGULAR(15);
        detailLabel.textColor = BASECOLOR_BLACK;
        [self addSubview:detailLabel];
        
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel);
            make.top.equalTo(self.mas_centerY).offset(SCALE_SIZE(6));
        }];
        
        ANButton *historyBtn = [ANButton buttonWithType:UIButtonTypeCustom];
        [historyBtn setImage:[UIImage imageNamed:@"navigation_history"] forState:UIControlStateNormal];
        [historyBtn setTitle:@"观看历史" forState:UIControlStateNormal];
        [[historyBtn titleLabel] setFont:[UIFont systemFontOfSize:10]];
        [historyBtn setTitleColor:BASECOLOR_BLACK forState:UIControlStateNormal];
        historyBtn.style = ANImagePositionUp;
        historyBtn.margin = 6;
        [historyBtn addTarget:self action:@selector(historyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:historyBtn];
        
        [historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_SIZE(70));
            make.height.right.top.equalTo(self);
        }];
        
        ANButton *studyBtn = [ANButton buttonWithType:UIButtonTypeCustom];
        [studyBtn setImage:[UIImage imageNamed:@"navigation_study"] forState:UIControlStateNormal];
        [studyBtn setTitle:@"专注学习" forState:UIControlStateNormal];
        [[studyBtn titleLabel] setFont:[UIFont systemFontOfSize:10]];
        [studyBtn setTitleColor:BASECOLOR_BLACK forState:UIControlStateNormal];
        studyBtn.style = ANImagePositionUp;
        studyBtn.margin = 6;
        [studyBtn addTarget:self action:@selector(studyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:studyBtn];
        
        [studyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCALE_SIZE(70));
            make.height.top.equalTo(self);
            make.right.equalTo(historyBtn.mas_left).offset(SCALE_SIZE(16));
        }];
    }
    return self;
}

- (void)historyBtnClick {
    if (self.clickBlock) {
        self.clickBlock(3);
    }
}

- (void)studyBtnClick {
    if (self.clickBlock) {
        self.clickBlock(2);
    }
}

- (void)headBtnClick {
    if (self.clickBlock) {
        self.clickBlock(1);
    }
}

- (NSString *)showNow {
    NSDate *date6 = [self getCustomDateWithHour:6];
    NSDate *date11 = [self getCustomDateWithHour:11];
    NSDate *date13 = [self getCustomDateWithHour:13];
    NSDate *date18 = [self getCustomDateWithHour:18];
    NSDate *date23 = [self getCustomDateWithHour:23];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date6]==NSOrderedDescending && [currentDate compare:date11]==NSOrderedAscending)
    {
        return @"上午";
    }
    else if ([currentDate compare:date11]==NSOrderedDescending && [currentDate compare:date13]==NSOrderedAscending)
    {
        return @"中午";
    }
    else if ([currentDate compare:date13]==NSOrderedDescending && [currentDate compare:date18]==NSOrderedAscending)
    {
        return @"下午";
    }
    else if ([currentDate compare:date18]==NSOrderedDescending && [currentDate compare:date23]==NSOrderedAscending)
    {
        return @"晚上";
    }
    else if ([currentDate compare:date23]==NSOrderedDescending && [currentDate compare:date6]==NSOrderedAscending)
    {
        return @"凌晨";
    }
    return @"";
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour {
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    /// 设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}

@end
